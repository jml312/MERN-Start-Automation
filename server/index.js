import express from "express"
import mongoose from "mongoose"
import cors from "cors"
import dotenv from "dotenv"
// import routes from "./routes/route.js"

const app = express()
dotenv.config()

app.use(express.json())
app.use(cors())

//app.use("/YOUR-STARTING-PATH", routes)
const PORT = process.env.PORT || 5000

mongoose.connect(process.env.CONNECTION_URL, {useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => app.listen(PORT, () => console.log(`Server Running on: http://localhost:${PORT}`)))
    .catch((error) => console.log(error))

mongoose.set("useFindAndModify", false)
