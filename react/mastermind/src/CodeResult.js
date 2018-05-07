import React from "react"
import { Glyphicon } from "react-bootstrap"

const get_glyph = (result) => {
  let glyph = "minus"

  if (true === result) {
    glyph = "ok"
  } else if (false === result) {
    glyph = "remove"
  }

  return glyph
}

const get_style = (result) => {
  let style = "text-muted"

  if (true === result) {
    style = "text-success"
  } else if (false === result) {
    style = "text-danger"
  }

  return style
}

const CodeResult = (props) =>
  <div className="d-flex">
    <Glyphicon glyph={get_glyph(props.result)} className={get_style(props.result)} />
  </div>

export default CodeResult