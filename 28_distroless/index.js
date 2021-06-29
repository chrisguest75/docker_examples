var os = require('os');
const process = require('process');
const internal = require('stream');

var logger = require('pino')();

async function closeGracefully(signal) {
    logger.info("SIGINT handled");
    process.exit()
}
process.on('SIGINT', closeGracefully)

function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}  

async function init() {
    logger.info("Started");
    logger.info("Platform:" + os.platform());
    logger.info("Release:" + os.release());
    logger.info("Hostname:" + os.hostname());
    logger.info("Versions:");
    logger.info(process.versions);
    logger.info("Env:");
    logger.info(process.env);
    logger.info("User:");
    logger.info(os.userInfo());
    let count = 100;
    while(count >= 0) {
        await sleep(1000);
        console.log(".");
        count--;        
    } 
}

init();

