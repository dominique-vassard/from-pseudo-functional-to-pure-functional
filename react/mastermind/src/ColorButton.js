import React from "react"
import { Button } from "react-bootstrap"
import CodePeg from "./CodePeg"

const ColorButton = (props) =>
    <Button onClick={props.onClick}>
        <CodePeg color={props.color} />
    </Button>

export default ColorButton