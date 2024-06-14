import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { Logger } from '@nestjs/common';

declare const module: any;

const logger = new Logger('velure-auth-service');

async function bootstrap() {
  const PORT = process.env.APP_PORT || 3020;

  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    AppModule,
    {
      transport: Transport.TCP,
      options: {
        host: '127.0.0.1',
        port: +PORT,
      },
    }
  );

  await app.listen();
  logger.log(`Authentication service is running on port ${PORT}`);

  if (module.hot) {
    module.hot.accept();
    module.hot.dispose(() => app.close());
  }
}
bootstrap();
