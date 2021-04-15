import { CREATE } from "../constants/actionTypes.js"
export default (state = [], action) => {
    switch(action.type) {
        case CREATE:
            return state
        default:
            return state
    }
   }
