var os = require('os');
const process = require('process');

let logger = require('pino')();
logger.info("Started");
logger.info("Platform:" + os.platform());
logger.info("Release:" + os.release());
logger.info("Versions:");
logger.info(process.versions);

