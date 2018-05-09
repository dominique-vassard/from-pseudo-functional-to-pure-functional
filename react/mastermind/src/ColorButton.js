import React from "react"
import { Button } from "react-bootstrap"
import CodePeg from "./CodePeg"

/**
 * Component: ColorButton
 * A round button of the given color, clickable
 *
 * @param   {object}    props       available properties, formated as:
 *                                  {
 *                                      "onClick": the function to call when button is clicked
 *                                      "color": The peg color
 *                                  }
 * @returns {JSX}                   The component
 */
const ColorButton = (props) =>
    <Button onClick={props.onClick}>
        <CodePeg color={props.color} />
    </Button>

export default ColorButton