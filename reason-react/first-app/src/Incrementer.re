let incrementer = ReasonReact.statelessComponent("Incrementer");

let make = _children => {
  ...incrementer,
  render: self =>
    <button className="btn btn-success btn-block">
      (ReasonReact.string("+"))
    </button>,
};