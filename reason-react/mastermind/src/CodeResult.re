let codeResult = ReasonReact.statelessComponent("CodeResult");

/**
 * Return glyph to use depending on result
 *
 * @param   option(bool)    result      The result
 *
 * @returns string                      The glyph name
 *
 */
let get_glyph = result =>
  switch (result) {
  | None => "minus"
  | Some(true) => "check"
  | Some(false) => "times"
  };

/**
 * Return style to use depending on result
 *
 * @param   option(bool)    result      The result
 *
 * @returns string                      The style string
 *
 */
let get_style = result =>
  switch (result) {
  | None => "text-muted"
  | Some(true) => "text-success"
  | Some(false) => "text-danger"
  };

/* Component definition */
let make = (~result, _children) => {
  ...codeResult,
  render: _self =>
    <div className="d-flex">
      <i
        className=(
          " glyphicon fas fa-"
          ++ get_glyph(result)
          ++ " "
          ++ get_style(result)
        )
      />
    </div>,
};