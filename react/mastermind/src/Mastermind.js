import React from "react"
import Board from "./Board"


class Mastermind extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
            "breakerTries": this.init_breaker_tries(),
            "codeToBreak": this.init_code_to_break()
        }
    }

    init_code_to_break() {
        return ["red", "blue", "green", "yellow"]
    }

    init_breaker_tries() {
        return Array(10).fill(["grey", "grey", "grey", "grey"])
    }

    render() {
        return (
            <div className="container jumbotron" >
                <h1>Mastermind</h1>
                <Board breakerTries={this.state.breakerTries} codeToBreak={this.state.codeToBreak} />
            </div>
        )
    }
}

export default Mastermind