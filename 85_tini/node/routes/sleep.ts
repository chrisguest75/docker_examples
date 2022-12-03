import express, { Request, Response, NextFunction } from 'express'
import { promisify } from 'util'
import { logger } from '../src/logger'

const router = express.Router()

// sleep for a period of time and create a child off passed in span
const sleep = promisify(setTimeout)

// use underscores to ignore parameters ", _next: NextFunction"
const sleepHandler = async (request: Request, response: Response) => {
    logger.info(`sleepHandler`)
    let wait = '500'
    if (typeof request.query.wait === 'string') {
        wait = request.query.wait
    }

    const sleeping = sleep(parseInt(wait))
    await sleeping

    response.status(200).json({ message: 'slept', time: wait, random: Math.floor(Math.random() * 100) })
}

router.get('/', sleepHandler)

export { router as sleepRouter }
