import React from "react"
import { ListGroup } from "react-bootstrap"
import CodePhrase from "./CodePhrase"

/**
 * Component: Board
 * The game board with:
 *  - 10 lines of ccodebreka tries
 *  - 1 line of code to break
 *
 * Properties:
 *  {
 *      "breakerTries": {Array}     contains user tries for code breaking
 *      "codeToBreak":  {Array}     Contains the code to break
 *  }
 *
 */
class Board extends React.Component {
    /**
     * Render the component
     */
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