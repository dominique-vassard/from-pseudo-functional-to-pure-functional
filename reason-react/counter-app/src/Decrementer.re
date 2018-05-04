let decrementer = ReasonReact.statelessComponent("Decrementer");

let make = (~handleClick, _children) => {
  ...decrementer,
  render: _self =>
    <button className="btn btn-danger btn-block" onClick=handleClick>
      (ReasonReact.string("-"))
    </button>,
};