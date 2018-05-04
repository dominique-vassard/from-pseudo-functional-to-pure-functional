/* State Declaration */
type state = {count: int};

/* Action declaration */
type action =
  | Increment
  | Decrement;

let counter = ReasonReact.reducerComponent("Counter");

let make = _children => {
  ...counter,
  /* Manage intial state */
  initialState: () => {count: 5},
  /* State transitions */
  reducer: (action, state) =>
    switch (action) {
    | Increment => ReasonReact.Update({count: state.count + 1})
    | Decrement => ReasonReact.Update({count: state.count - 1})
    },
  /* Rendering */
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
        <div className="col-md-3">
          <Decrementer handleClick=(_event => self.send(Decrement)) />
        </div>
        <div className="col-md-6">
          <center>
            <h1> (ReasonReact.string(string_of_int(self.state.count))) </h1>
          </center>
        </div>
        <div className="col-md-3">
          <Incrementer handleClick=(_event => self.send(Increment)) />
        </div>
      </div>
    </div>,
};