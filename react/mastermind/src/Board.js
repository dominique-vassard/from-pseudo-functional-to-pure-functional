import React from "react"
import { ListGroup } from "react-bootstrap"
import CodePhrase from "./CodePhrase"


class Board extends React.Component {
    render() {
        return (
            <ListGroup className="board">
                {/* Breaker tries */}
                {this.props.breakerTries.map((breaker_try, index) =>
                    <CodePhrase key={index} phrase={breaker_try} result={this.props.results[index]} />
                )}

                {/* Code to break */}
                <CodePhrase phrase={this.props.codeToBreak} />
            </ListGroup>
        )
    }
}

export default Board