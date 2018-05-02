let counter = ReasonReact.statelessComponent("Counter");

let make = _children => {
  ...counter,
  render: self =>
    <div className="container jumbotron">
      <div className="row">
        <div className="md-12 mx-auto">
          <center>
            <h1> (ReasonReact.string("This is a simple counter")) </h1>
          </center>
        </div>
      </div>
      <div className="row md-5" />
      <div className="row">
        <div className="col-md-3"> <Decrementer /> </div>
        <div className="col-md-6">
          <center> <h1> (ReasonReact.string("0")) </h1> </center>
        </div>
        <div className="col-md-3"> <Incrementer /> </div>
      </div>
    </div>,
};