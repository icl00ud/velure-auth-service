import { Module } from '@nestjs/common';
import { AuthenticationModule } from './modules/authentication/authentication.module';
import { ConfigModule } from '@nestjs/config';
import configurationConfig from './config/configuration.config';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [configurationConfig],
      isGlobal: true,
    }),
    AuthenticationModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
