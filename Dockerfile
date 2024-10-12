# Build stage
FROM node:18-alpine AS build  # Usando uma versão estável do Node.js

WORKDIR /app

# Copia somente os arquivos essenciais para o build inicialmente
COPY package*.json ./
COPY tsconfig.build.json ./
COPY prisma ./prisma/  # Inclui o prisma/schema.prisma no build para gerar o cliente Prisma

# Instala dependências de produção e Prisma Client
RUN npm install --production

# Copia todo o restante do código após instalar as dependências
COPY . .

# Gera o cliente Prisma antes do build da aplicação
RUN npx prisma generate

# Constrói a aplicação NestJS
RUN npm run build

# Prod stage
FROM node:18-alpine  # Utilize a mesma versão do Node no estágio de produção

WORKDIR /app

# Copia o arquivo .env e a pasta prisma para o contêiner
COPY ./.env /app/
COPY ./prisma /app/prisma/

# Copia os artefatos gerados pelo build do estágio anterior
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./

# Instala o cliente Prisma no ambiente de produção (sem dependências de desenvolvimento)
RUN npm install @prisma/client --omit=dev

# Define o PATH do Prisma Client
ENV PATH=/app/node_modules/.bin:$PATH

# Comando de inicialização
CMD ["node", "dist/main"]
