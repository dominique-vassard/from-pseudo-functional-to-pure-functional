open Types;

let component = ReasonReact.statelessComponent("ControlPanel");

let get_message = (gameState: gameState) =>
  switch (gameState) {
  | Start => "Click 'New Game' to start."
  | Try => "Try to break the code."
  | Lost => "You lose!"
  | Win => "You won"
  };

let get_style = (gameState: gameState) =>
  switch (gameState) {
  | Start => "info"
  | Try => "warning"
  | Lost => "danger"
  | Win => "success"
  };

let make = (~onClick, ~gameState, _children) => {
  ...component,
  render: _self =>
    <div className="row">
      <div className="col-md-3">
        <button className="btn btn-primary new-game-btn" onClick>
          (ReasonReact.string("New game"))
        </button>
      </div>
      <div className="col-md-1" />
      <div className="col-md-8">
        <div className=("alert alert-" ++ get_style(gameState))>
          (ReasonReact.string(get_message(gameState)))
        </div>
      </div>
    </div>,
};