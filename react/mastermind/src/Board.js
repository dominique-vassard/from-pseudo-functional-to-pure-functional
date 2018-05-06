import React from "react"
import CodePhrase from "./CodePhrase"
import { ListGroup } from "react-bootstrap"

class Board extends React.Component {
    render() {
        return (
            <ListGroup className="board">
                {/* Breaker tries */}
                {this.props.breakerTries.map((breaker_try, index) => <CodePhrase key={index} phrase={breaker_try} />)}

                {/* Code to break */}
                <CodePhrase phrase={this.props.codeToBreak} />
            </ListGroup>
        )
    }
}

export default Board