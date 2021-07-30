const logger = require('pino')({
    level: process.env.LOG_LEVEL || 'info'
})

const expresslogger = require('express-pino-logger')({
    logger: logger
})
module.exports = { logger, expresslogger }
