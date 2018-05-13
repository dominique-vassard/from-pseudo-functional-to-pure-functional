let codeResult = ReasonReact.statelessComponent("CodeResult");

let get_glyph = result =>
  switch (result) {
  | None => "minus"
  | Some(true) => "check"
  | Some(false) => "times"
  };

let get_style = result =>
  switch (result) {
  | None => "text-muted"
  | Some(true) => "text-success"
  | Some(false) => "text-danger"
  };

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