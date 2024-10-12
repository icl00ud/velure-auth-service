# Build stage
FROM node:18-alpine AS build  # Especificando uma versão mais estável do Node.js

WORKDIR /app

COPY package*.json ./
COPY tsconfig.build.json ./
COPY prisma ./prisma/

RUN npm install -g @nestjs/cli

RUN npm install --production

COPY . .

RUN npx prisma generate

RUN npm run build

FROM node:18-alpine  # Utilize a mesma versão do Node no estágio de produção

WORKDIR /app

COPY ./.env /app/
COPY ./prisma /app/prisma/

COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./

RUN npm install @prisma/client --omit=dev

ENV PATH=/app/node_modules/.bin:$PATH

CMD ["node", "dist/main"]
