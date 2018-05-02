let decrementer = ReasonReact.statelessComponent("Decrementer");

let make = _children => {
  ...decrementer,
  render: self =>
    <button className="btn btn-danger btn-block">
      (ReasonReact.string("-"))
    </button>,
};