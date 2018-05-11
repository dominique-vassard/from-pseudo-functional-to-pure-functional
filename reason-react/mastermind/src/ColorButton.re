let colorButton = ReasonReact.statelessComponent("ColorButton");

let make = (~color, ~onClick, _children) => {
  ...colorButton,
  render: _self =>
    <button className="btn btn-default" onClick> <CodePeg color /> </button>,
};