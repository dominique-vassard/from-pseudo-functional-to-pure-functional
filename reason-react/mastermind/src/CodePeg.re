open Types;

let codePeg = ReasonReact.statelessComponent("CodePeg");

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

let make = (~color, _children) => {
  ...codePeg,
  render: _self =>
    <div className=("codepeg-" ++ to_color(color) ++ " rounded-circle") />,
};