import * as api from "../api"
import { CREATE } from "../constants/actionTypes.js"

const fetch = () => async (dispatch) => {
    try {
        const { data } = await api.fetch()
        dispatch({ type: CREATE, payload: data }) 
    }
    catch (error) {
        console.log(error)
    }
}
