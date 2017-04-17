// # Ghost Configuration
// Setup your Ghost install for various environments
// Documentation can be found at http://support.ghost.org/config/

var path = require('path'),
    config;

config = {
    production: {
        url: process.env.GHOST_URL,
        database: {
            client: "mysql",
            connection: {
                host: process.env.MYSQL_HOST,
                port: process.env.MYSQL_PORT,
                user: process.env.ACCESSKEY,
                password: process.env.SECRETKEY,
                database: 'app_' + process.env.APPNAME,
                charset: "utf8"
            }
        },
        paths: {
            contentPath: path.join(process.env.GHOST_CONTENT, '/')
        },
        server: {
            host: '0.0.0.0',
            port: process.env.PORT
        },
        privacy: {
            useUpdateCheck: false,
            useGoogleFonts: false,
            useGravatar: false,
            useRpcPing: false,
            useStructuredData: false
        }
    }
};

module.exports = config;