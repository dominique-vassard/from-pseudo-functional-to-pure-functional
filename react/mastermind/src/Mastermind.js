import React from "react"
import Board from "./Board"
import { Grid, Col, Row, Panel } from "react-bootstrap"
import ColorButton from "./ColorButton"
import ControlPanel from "./ControlPanel"
import History from "./History"

const AVAILABLE_COLORS = ["blue", "green", "orange", "purple", "red", "yellow"]
const START = 1
const TRY = 2
const LOST = 3
const WIN = 4

class Mastermind extends React.Component {
    constructor(props) {
        super(props)

        const nbMaxTries = 10

        this.state = {
            "nbMaxTries": nbMaxTries,
            "breakerTries": this.init_breaker_tries(nbMaxTries),
            "tryResults": this.init_try_results(nbMaxTries),
            "codeToBreak": this.init_code_to_break(nbMaxTries),
            "currentTryIndex": 0,
            "currentColorChoice": 0,
            "gameState": START,
            "history": []
        }
    }

    init_code_to_break() {
        let initial_colors = []
        for (let i = 0; i < 4; i++) {
            let idx = parseInt(Math.random() * AVAILABLE_COLORS.length, 10)
            initial_colors.push(AVAILABLE_COLORS[idx])
        }
        return initial_colors
    }

    init_breaker_tries(nbMaxTries) {
        return Array(nbMaxTries).fill(null).map(_unused => ["grey", "grey", "grey", "grey"])
    }

    init_try_results(nbMaxTries) {
        return Array(nbMaxTries).fill(null)
    }

    new_game() {
        this.setState({
            "breakerTries": this.init_breaker_tries(this.state.nbMaxTries),
            "codeToBreak": this.init_code_to_break(this.state.nbMaxTries),
            "tryResults": this.init_try_results(this.state.nbMaxTries),
            "currentTryIndex": 0,
            "currentColorChoice": 0,
            "gameState": TRY,
            "history": []
        })
    }

    save_history() {
        let state = JSON.parse(JSON.stringify(this.state))
        state.history.push({
            "nbMaxTries": state.nbMaxTries,
            "breakerTries": state.breakerTries,
            "tryResults": state.tryResults,
            "codeToBreak": state.codeToBreak,
            "currentTryIndex": state.currentTryIndex,
            "currentColorChoice": state.currentColorChoice,
            "gameState": state.gameState
        })
        this.setState({
            history: state.history
        })
    }

    go_to_history(index) {
        this.setState(
            this.state.history[index]
        )
    }

    check_try(try_num) {
        const to_check = this.state.breakerTries[try_num]
        let is_valid = false
        let nb_valid = 0
        let tryResults = this.state.tryResults
        let gameState = this.state.gameState

        for (let i = 0; i < 4; i++) {
            if (to_check[i] === this.state.codeToBreak[i]) {
                nb_valid++
            }
        }

        tryResults[this.state.currentTryIndex] = false
        if (nb_valid === 4) {
            is_valid = true
            gameState = WIN
            tryResults[this.state.currentTryIndex] = true
        }

        this.setState({
            "gameState": gameState,
            "tryResults": tryResults
        })

        return is_valid
    }

    choose_color(color) {
        if (this.state.gameState !== TRY) {
            return false
        }
        this.save_history()
        let breakerTries = this.state.breakerTries
        let currentTryIndex = this.state.currentTryIndex
        let currentColorChoice = this.state.currentColorChoice
        let gameState = this.state.gameState

        breakerTries[this.state.currentTryIndex][this.state.currentColorChoice] = color
        currentColorChoice++
        if (currentColorChoice === 4) {
            if (this.check_try(currentTryIndex)) {
                return true
            }
            currentColorChoice = 0
            currentTryIndex++
        }

        if (currentTryIndex === (this.state.nbMaxTries)) {
            gameState = LOST
        }

        this.setState({
            "breakerTries": breakerTries,
            "currentColorChoice": currentColorChoice,
            "currentTryIndex": currentTryIndex,
            "gameState": gameState
        })
    }

    render() {
        return (
            <Grid className="container jumbotron" >
                <Row>
                    <Col md={12}>
                        <h1 className="text-center">Mastermind</h1>
                    </Col>
                </Row>
                <ControlPanel gameState={this.state.gameState} newGame={() => this.new_game()} />
                <Row>
                    <Col md={1} />
                    <Col md={4}>
                        <Board breakerTries={this.state.breakerTries} codeToBreak={this.state.codeToBreak} results={this.state.tryResults} />
                    </Col>
                    <Col md={1} />
                    <Col md={5}>
                        <Panel bsStyle="primary">
                            <Panel.Heading>Choose a color</Panel.Heading>
                            <Panel.Body>
                                {AVAILABLE_COLORS.map((av_color, index) => <ColorButton key={index} color={av_color} onClick={() => this.choose_color(av_color)} />)}
                            </Panel.Body>
                        </Panel>
                        <History history={this.state.history} onClick={(index) => this.go_to_history(index)} />
                    </Col>
                    <Col md={1} />
                </Row>
            </Grid>
        )
    }
}

export default Mastermind