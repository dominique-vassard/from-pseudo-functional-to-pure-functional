open Types;

let component = ReasonReact.statelessComponent("ControlPanel");

/**
 * Return message to use depending on gameState
 *
 * @param   gameState    gameState      The game State
 *
 * @returns string                      The message string
 *
 */
let get_message = (gameState: gameState) =>
  switch (gameState) {
  | Start => "Click 'New Game' to start."
  | Try => "Try to break the code."
  | Lost => "You lose!"
  | Win => "You won"
  };

/**
 * Return style to use depending on gameState
 *
 * @param   gameState    gameState      The game State
 *
 * @returns string                      The style string
 *
 */
let get_style = (gameState: gameState) =>
  switch (gameState) {
  | Start => "info"
  | Try => "warning"
  | Lost => "danger"
  | Win => "success"
  };

/* Component definition */
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