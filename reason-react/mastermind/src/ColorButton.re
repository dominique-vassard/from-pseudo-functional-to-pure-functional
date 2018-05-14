let colorButton = ReasonReact.statelessComponent("ColorButton");

/* Component definition */
let make = (~color, ~onClick, _children) => {
  ...colorButton,
  render: _self =>
    <button className="btn btn-outline-secondary color-button" onClick>
      <CodePeg color />
    </button>,
};