import express from "express"
import { genericFunction } from "../controllers/controller.js"

const router = express.Router()

router.get("/", genericFunction)

export default router
