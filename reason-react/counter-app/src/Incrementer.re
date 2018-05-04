let incrementer = ReasonReact.statelessComponent("Incrementer");

let make = (~handleClick, _children) => {
  ...incrementer,
  render: _self =>
    <button className="btn btn-success btn-block" onClick=handleClick>
      (ReasonReact.string("+"))
    </button>,
};