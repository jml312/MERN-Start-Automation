# starts a new MERN project
function MERN_START() {
  echo "Creating $1 now..."
  # ---------------------------------------------------------------------------------------------
  # move into the Desktop directory
  cd && cd Desktop 
  # ---------------------------------------------------------------------------------------------
  # create named directory with client and server directories inside
  mkdir $1 && cd $1 && mkdir client server

  # ---------------------------------------------------------------------------------------------
  # ---------------------------------------------------------------------------------------------
  # Configuring the client directory
  cd client && npx create-react-app ./ && npm i redux redux-thunk react-redux axios react-router-dom dotenv
  # ---------------------------------------------------------------------------------------------
  # add proxy to package.json
  sed -i '' -e '4s/^//p; 4s/^.*/  "proxy": "http:\/\/localhost:5000",/' package.json  
  # ---------------------------------------------------------------------------------------------
  #customizing the src directory
  rm -r src && mkdir src src/components src/api src/actions src/reducers src/constants  && touch src/index.js src/App.js src/api/index.js src/actions/action.js src/reducers/index.js src/reducers/reducer.js src/constants/actionTypes.js .env
  # ---------------------------------------------------------------------------------------------
  # writing to src/index.js
echo 'import React from "react"
import ReactDOM from "react-dom"
import { Provider } from "react-redux"
import { createStore, applyMiddleware, compose } from "redux"
import thunk from "redux-thunk"
import reducers from "./reducers/reducer"
import App from "./App"
\nconst store = createStore(reducers, compose(applyMiddleware(thunk)))
\nReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById("root")
)' >> src/index.js
  # ---------------------------------------------------------------------------------------------
  # writing to src/App.js
echo 'import React from "react"
import { BrowserRouter as Router, Route } from "react-router-dom"
\nconst App = () => {
\treturn (
\t   <Router>
\t        <Route path="/">
\t            🚀
\t        </Route>
\t   </Router>
\t)
}
\nexport default App' >> src/App.js
  # ---------------------------------------------------------------------------------------------
  # writing to src/api/index.js
echo 'import axios from "axios"
\nconst url = "http:/localhost:5000/YOUR-STARTING-PATH"
\nexport const fetch = () => axios.get(url)' >> src/api/index.js
  # ---------------------------------------------------------------------------------------------
  # writing to src/actions/action.js
echo 'import * as api from "../api"
import { CREATE } from "../constants/actionTypes.js"
\nconst fetch = () => async (dispatch) => {
    try {
        const { data } = await api.fetch()
        dispatch({ type: CREATE, payload: data }) 
    }
    catch (error) {
        console.log(error)
    }
}' >> src/actions/action.js
  # ---------------------------------------------------------------------------------------------
  # writing to src/reducers/index.js
echo 'import { combineReducers } from "redux"
import reducers from "./reducer"
\nexport const combinedReducers = combineReducers({ reducers })' >> src/reducers/index.js
  # ---------------------------------------------------------------------------------------------
  # writing to src/reducers/reducer.js
echo 'import { CREATE } from "../constants/actionTypes.js"
export default (state = [], action) => {
    switch(action.type) {
        case CREATE:
            return state
        default:
            return state
    }
   }' >> src/reducers/reducer.js
  # ---------------------------------------------------------------------------------------------
  # writing to src/constants/actionTypes.js
echo 'export const CREATE = "CREATE"' >> src/constants/actionTypes.js

  # ---------------------------------------------------------------------------------------------
  # ---------------------------------------------------------------------------------------------
  # Configuring the server directory (also adding .gitignore, .env, and Procfile)
  cd ../server && npm init -y && npm i express mongoose nodemon cors dotenv
  touch .gitignore && echo ".env \n/node_modules" >> .gitignore
  touch .env && echo 'PORT = 5000\nCONNECTION_URL = "YOUR-MONGODB-CONNECTION-URL"' >> .env
  touch Procfile && echo "web: npm run start" >> Procfile
  # ---------------------------------------------------------------------------------------------
  # allowing module import to be used in package.json and creating the start script
  sed -i '' -e '5s/^//p; 5s/^.*/  "type": "module",/' package.json  
  sed -i '' -e 's/"test":.*/  "start": "nodemon index.js"/' package.json
  # ---------------------------------------------------------------------------------------------
  # creating and writing to index.js
  touch index.js
echo 'import express from "express"
import mongoose from "mongoose"
import cors from "cors"
import dotenv from "dotenv"
// import routes from "./routes/route.js"
\nconst app = express()
dotenv.config()
\napp.use(express.json())
app.use(cors())
\n//app.use("/YOUR-STARTING-PATH", routes)
const PORT = process.env.PORT || 5000
\nmongoose.connect(process.env.CONNECTION_URL, {useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => app.listen(PORT, () => console.log(`Server Running on: http://localhost:${PORT}`)))
    .catch((error) => console.log(error))
\nmongoose.set("useFindAndModify", false)' >> index.js
  # ---------------------------------------------------------------------------------------------
  # creating and writing to the routes folder
  mkdir routes && touch routes/route.js
echo 'import express from "express"
import { genericFunction } from "../controllers/controller.js"
\nconst router = express.Router()
\nrouter.get("/", genericFunction)
\nexport default router' >> routes/route.js
  # ---------------------------------------------------------------------------------------------
  # create the controller folder 
  mkdir controllers && touch controllers/controller.js
echo 'import express from "express"
import mongoose from "mongoose"
import Object from "../models/model.js";
\nconst router = express.Router() 
\nexport const genericFunction = async (req, res) => {
    try {
        res.send("SUCCESS")
    }
    catch (error) {
        res.status(404).json({ message: error.message })
    }
}' >> controllers/controller.js    
  # ---------------------------------------------------------------------------------------------
  # creating and writing to models folder
  mkdir models && touch models/model.js
echo 'import mongoose from "mongoose"
\nconst schema = mongoose.Schema({})
const Object = mongoose.model("Schema", schema)
export default Object' >> models/model.js
  # ---------------------------------------------------------------------------------------------
  # ---------------------------------------------------------------------------------------------
  echo '\nSetup Complete 🚀
Visit https://www/mongodb.com/cloud/atlas to connect to your database.'
  cd .. && code .
}
