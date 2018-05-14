open Types;

let codePeg = ReasonReact.statelessComponent("CodePeg");

/**
 * Convert pegColor to color
 *
 * @param   pegColor    color     The pegColor to convert
 *
 * @returns string                The corresponding color
 */
let to_color = (color: pegColor) =>
  switch (color) {
  | Blue => "blue"
  | Green => "green"
  | Grey => "grey"
  | Orange => "orange"
  | Purple => "purple"
  | Red => "red"
  | Yellow => "yellow"
  };

/* Component definition */
let make = (~color, _children) => {
  ...codePeg,
  render: _self =>
    <div className=("codepeg-" ++ to_color(color) ++ " rounded-circle") />,
};