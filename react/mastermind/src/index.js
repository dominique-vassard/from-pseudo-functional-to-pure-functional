import React from "react"
import ReactDOM from "react-dom"
import "bootstrap/dist/css/bootstrap.min.css"
import "./index.css"
import Mastermind from "./Mastermind"
import registerServiceWorker from "./registerServiceWorker"

ReactDOM.render(< Mastermind />, document.getElementById("root"))
registerServiceWorker()