import React from "react"
import { Col, Button, Alert, Row } from "react-bootstrap"


const get_message = function (game_state) {
    let message

    switch (game_state) {
        case 1:
            message = "Click new game to play."
            break;
        case 2:
            message = "Try to break the code."
            break;
        case 3:
            message = "You LOST!"
            break;
        case 4:
            message = "You WON!"
            break;
    }

    return message
}

const get_style = function (game_state) {
    let style

    switch (game_state) {
        case 1:
            style = "info"
            break;
        case 2:
            style = "warning"
            break;
        case 3:
            style = "danger"
            break;
        case 4:
            style = "success"
            break;
    }

    return style
}

const ControlPanel = (props) =>
    <Row>
        <Col md={1}>
            <Button bsStyle="primary" className="new-game-btn" onClick={props.newGame}>New game</Button>
        </Col>
        <Col md={1} />
        <Col md={10}>
            <Alert bsStyle={get_style(props.gameState)}>
                <h4>{get_message(props.gameState)}</h4>
            </Alert>

        </Col>
    </Row>

export default ControlPanel