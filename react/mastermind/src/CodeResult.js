import React from "react"
import { Glyphicon } from "react-bootstrap"

/**
 * Determine the gluph depending on the result
 *
 * @param   {null|boolean}    result    The result ffor which deteremine style
 *
 * @returns {string}                    The plyph to use
 */
const get_glyph = (result) => {
  let glyph = "minus"

  if (true === result) {
    glyph = "ok"
  } else if (false === result) {
    glyph = "remove"
  }

  return glyph
}

/**
 * Determine style depending on the result
 *
 * @param   {null|boolean}    result    The result ffor which deteremine style
 *
 * @returns {string}                    The style to apply
 */
const get_style = (result) => {
  let style = "text-muted"

  if (true === result) {
    style = "text-success"
  } else if (false === result) {
    style = "text-danger"
  }

  return style
}

/**
 * Component: CodeResult
 * Display the answer status: pending, ok, ko
 *
 * @param       {object}        props           The required properties:
 *                                              {
 *                                                      "result": {null|boolean} the result to display
 *                                              }
 *
 * @returns                                     The component
 */
const CodeResult = (props) =>
  <div className="d-flex">
    <Glyphicon glyph={get_glyph(props.result)} className={get_style(props.result)} />
  </div>

export default CodeResult