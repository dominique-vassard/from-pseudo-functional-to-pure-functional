import React from "react"
import CodePeg from "./CodePeg"
import { ListGroupItem } from "react-bootstrap"

const CodePhrase = (props) =>
    <ListGroupItem>
        <div className="d-flex flew-row">
            {props.phrase.map((phrase_color, index) => <CodePeg key={index} color={phrase_color} />)}
        </div>
    </ListGroupItem>

export default CodePhrase