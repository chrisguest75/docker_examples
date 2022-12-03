import express, { Request, Response, NextFunction } from 'express'
import { logger } from '../src/logger'

const router = express.Router()

// use underscores to ignore parameters ", _next: NextFunction"
const rootHandler = (request: Request, response: Response) => {
    logger.info('rootHandler')

    let error = 200
    if (typeof request.query.error === 'string') {
        error = parseInt(request.query.error)
    }

    response.status(error).json({ message: 'root', random: Math.floor(Math.random() * 100) })
}

router.get('/', rootHandler)

export { router as rootRouter }
