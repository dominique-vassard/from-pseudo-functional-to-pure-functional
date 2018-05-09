import React from "react"
import CodePeg from "./CodePeg"
import CodeResult from "./CodeResult"
import { ListGroupItem } from "react-bootstrap"

/**
 * Component: CodePhrase
 * Display A series of 4 colors
 *
 *
 * @param   {object}    props       The required properties:
 *                                  {
 *                                      "phrase": The peg color list
 *                                  }
 *
 * @returns                         The component
 */
const CodePhrase = (props) =>
    <ListGroupItem>
        <div className="d-flex flew-row">
            {props.phrase.map((phrase_color, index) => <CodePeg key={index} color={phrase_color} />)}
            <CodeResult result={props.result} />
        </div>
    </ListGroupItem>

export default CodePhrase