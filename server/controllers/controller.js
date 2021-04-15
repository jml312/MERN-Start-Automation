import express from "express"
import mongoose from "mongoose"
import Object from "../models/model.js";

const router = express.Router() 

export const genericFunction = async (req, res) => {
    try {
        res.send("SUCCESS")
    }
    catch (error) {
        res.status(404).json({ message: error.message })
    }
}
