let colorButton = ReasonReact.statelessComponent("ColorButton");

let make = (~color, _children) => {
  ...colorButton,
  render: _self =>
    <button className="btn btn-default"> <CodePeg color /> </button>,
};