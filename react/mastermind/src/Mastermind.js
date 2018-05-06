import React from "react"
import Board from "./Board"
import { Grid, Col, Row, Panel } from "react-bootstrap"
import ColorButton from "./ColorButton"

const AVAILABLE_COLORS = ["blue", "green", "orange", "purple", "red", "yellow"]

class Mastermind extends React.Component {
    constructor(props) {
        super(props)

        const nbMaxTries = 10

        this.state = {
            "nbMaxTries": nbMaxTries,
            "breakerTries": this.init_breaker_tries(nbMaxTries),
            "codeToBreak": this.init_code_to_break(nbMaxTries),
            "currentTryIndex": 0,
            "currentColorChoice": 0,
            "gameIsOver": false
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

    choose_color(color) {
        if (this.state.gameIsOver) {
            return false
        }
        let breakerTries = this.state.breakerTries
        let currentTryIndex = this.state.currentTryIndex
        let currentColorChoice = this.state.currentColorChoice
        let gameIsOver = this.state.gameIsOver

        breakerTries[this.state.currentTryIndex][this.state.currentColorChoice] = color
        currentColorChoice++
        if (currentColorChoice === 4) {
            currentColorChoice = 0
            currentTryIndex++
        }

        if (currentTryIndex === (this.state.nbMaxTries)) {
            gameIsOver = true
        }

        this.setState({
            "breakerTries": breakerTries,
            "currentColorChoice": currentColorChoice,
            "currentTryIndex": currentTryIndex,
            "gameIsOver": gameIsOver
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
                <Row>
                    <Col md={1} />
                    <Col md={4}>
                        <Board breakerTries={this.state.breakerTries} codeToBreak={this.state.codeToBreak} />
                    </Col>
                    <Col md={1} />
                    <Col md={5}>
                        <Panel bsStyle="primary">
                            <Panel.Heading>Choose a color</Panel.Heading>
                            <Panel.Body>
                                {AVAILABLE_COLORS.map((av_color, index) => <ColorButton key={index} color={av_color} onClick={() => this.choose_color(av_color)} />)}
                            </Panel.Body>
                        </Panel>
                    </Col>
                    <Col md={1} />
                </Row>
            </Grid>
        )
    }
}

export default Mastermind