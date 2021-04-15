import axios from "axios"

const url = "http:/localhost:5000/YOUR-STARTING-PATH"

export const fetch = () => axios.get(url)
