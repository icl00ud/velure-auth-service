import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const PORT = process.env.APP_PORT || 3001;
  const ORIGIN_UI = process.env.ORIGIN_UI || 'http://localhost:4200';

  const app = await NestFactory.create(AppModule);
  app.enableCors( { origin: ORIGIN_UI } );

  await app.listen(PORT, () => console.log('Server is listening on port', PORT));
}
bootstrap();
