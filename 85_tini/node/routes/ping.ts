import express, { Request, Response, NextFunction } from 'express'
import { logger } from '../src/logger'

const router = express.Router()

// use underscores to ignore parameters ", _next: NextFunction"
const pingHandler = async (_request: Request, response: Response) => {
    logger.info(`pingHandler`)

    response.status(200).json({ message: 'pong', random: Math.floor(Math.random() * 100) })
}

router.get('/', pingHandler)

export { router as pingRouter }
