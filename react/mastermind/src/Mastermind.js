import React from "react"
import Board from "./Board"
import { Grid, Col, Row, Panel } from "react-bootstrap"
import ColorButton from "./ColorButton"
import ControlPanel from "./ControlPanel"
import History from "./History"

// Aailabe peg colors
const AVAILABLE_COLORS = ["blue", "green", "orange", "purple", "red", "yellow"]

// Game steps
const START = 1
const TRY = 2
const LOST = 3
const WIN = 4

/**
 * Component: Mastermind
 * Holds the game
 */
class Mastermind extends React.Component {
    constructor(props) {
        super(props)

        // MAx number of tries to breack the code
        const nbMaxTries = 10

        this.state = {
            "nbMaxTries": nbMaxTries,
            "breakerTries": this.init_breaker_tries(nbMaxTries),
            "tryResults": this.init_try_results(nbMaxTries),
            "codeToBreak": this.init_code_to_break(nbMaxTries),
            "currentTryIndex": 0,
            "currentColorChoice": 0,
            "gameState": START,
            "history": [],
            "historyIndex": 0
        }
    }

    /**
     * Initializes the code to break
     *
     * @returns     {Array}      an array containing the four colors of the code to break
     */
    init_code_to_break() {
        let initial_colors = []
        for (let i = 0; i < 4; i++) {
            let idx = parseInt(Math.random() * AVAILABLE_COLORS.length, 10)
            initial_colors.push(AVAILABLE_COLORS[idx])
        }
        return initial_colors
    }

    /**
     * Initializes the container for the breaker tries
     *
     * @param   {int}   nbMaxTries      The max number of tries to break the code
     *
     * @returns {Array}                 An array fill the start colors
     */
    init_breaker_tries(nbMaxTries) {
        return Array(nbMaxTries).fill(null).map(_unused => ["grey", "grey", "grey", "grey"])
    }

    /**
     * Initializes the container for the try results
     *
     * @param   {int}   nbMaxTries      The max number of tries to break the code
     *
     * @returns {Array}                 An array fill the starting results
     */
    init_try_results(nbMaxTries) {
        return Array(nbMaxTries).fill(null)
    }

    /**
     * Re-initializes the data for a new game
     *
     * @returns void
     */
    new_game() {
        this.setState({
            "breakerTries": this.init_breaker_tries(this.state.nbMaxTries),
            "codeToBreak": this.init_code_to_break(this.state.nbMaxTries),
            "tryResults": this.init_try_results(this.state.nbMaxTries),
            "currentTryIndex": 0,
            "currentColorChoice": 0,
            "gameState": TRY,
            "history": [
                {
                    "breakerTries": this.init_breaker_tries(this.state.nbMaxTries),
                    "tryResults": this.init_try_results(this.state.nbMaxTries),
                    "gameState": TRY
                }
            ],
            "historyIndex": 0
        })
    }

    /**
     * Save current state in order to fuel time travel
     *
     * @returns void
     */
    save_history() {
        let state = JSON.parse(JSON.stringify(this.state))
        state.history.push({
            "breakerTries": state.breakerTries,
            "tryResults": state.tryResults,
            "gameState": state.gameState
        })
        this.setState({
            history: state.history,
            historyIndex: state.historyIndex + 1
        })
    }

    /**
     * Time travel to wanted time
     *
     * @param   {int}   index       The index of the history to display
     *
     * @returns void
     */
    go_to_history(index) {
        let new_state = JSON.parse(JSON.stringify(this.state.history[index]))
        new_state.historyIndex = index
        this.setState(new_state)
    }

    /**
     * Check if the answer is correct or not
     * If answer is correct, stop the game
     *
     * @param   {int}   try_index       Index of the try to check
     *
     * @returns {bool}                  True is answer is correct, false otherwise
     */
    check_try(try_index) {
        const to_check = this.state.breakerTries[try_index]
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

    /**
     * Event handler: when user click a color to compose the code
     * If all tries are used, stop the game
     *
     * @param   {string}     color       The chosen color
     *
     * @returns void
     */
    choose_color(color) {
        if (this.state.gameState !== TRY || this.state.historyIndex !== this.state.history.length - 1) {
            return false
        }
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

        this.save_history()
    }

    /**
     * Render the game page
     */
    render() {
        return (
            <div>
                <header className="app-header">
                    <h1 className="text-center title">Mastermind</h1>
                </header>
                <Grid className="container jumbotron" >
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
                            <History history={this.state.history} currentHistory={this.state.historyIndex} onClick={(index) => this.go_to_history(index)} />
                        </Col>
                        <Col md={1} />
                    </Row>
                </Grid>
            </div>
        )
    }
}

export default Mastermind