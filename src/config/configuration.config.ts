export default () => ({
    applicationPort: parseInt(process.env.APP_PORT, 10) || 3001,
    database: {
        host: process.env.POSTGRES_HOST,
        port: parseInt(process.env.POSTGRES_PORT, 10) || 3306,
        username: process.env.POSTGRES_USER,
        password: process.env.POSTGRES_PASSWORD,
        database: process.env.POSTGRES_DATABASE_NAME,
    },
});