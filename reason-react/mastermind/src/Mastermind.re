open Types;

type history = {
  breakerTries: list(breakerTry),
  gameState,
};

type state = {
  nbMaxTries: int,
  breakerTries: list(breakerTry),
  codeToBreak: breakerTry,
  currentTryIndex: int,
  currentColorChoiceIndex: int,
  gameState,
  history: list(history),
  historyIndex: int,
};

type action =
  | NewGame;

let rec range = (start: int, end_: int) =>
  if (start >= end_) {
    [];
  } else {
    [start, ...range(start + 1, end_)];
  };

let initBreakerTry = () => {
  pegs: List.map((_) => Grey, range(0, 4)),
  result: None,
};

let initBreakerTries = (nbMaxTries: int) =>
  List.map((_) => initBreakerTry(), range(0, nbMaxTries));

let new_game = state =>
  ReasonReact.Update({
    ...state,
    breakerTries: initBreakerTries(state.nbMaxTries),
    codeToBreak: initBreakerTry(),
    currentTryIndex: 0,
    currentColorChoiceIndex: 0,
    gameState: Try,
    history: [
      {breakerTries: initBreakerTries(state.nbMaxTries), gameState: Try},
    ],
    historyIndex: 0,
  });

let mastermind_component = ReasonReact.reducerComponent("Mastermind");

let make = _children => {
  ...mastermind_component,
  initialState: () => {
    nbMaxTries: 10,
    breakerTries: initBreakerTries(10),
    codeToBreak: initBreakerTry(),
    currentTryIndex: 0,
    currentColorChoiceIndex: 0,
    gameState: Start,
    history: [],
    historyIndex: 0,
  },
  reducer: (action, state: state) =>
    switch (action) {
    /* | NewGame => ReasonReact.SideEffects((_self => Js.log("Click!"))) */
    /* | NewGame => ReasonReact.Update({...state, gameState: Try}) */
    | NewGame => new_game(state)
    },
  render: self =>
    <div>
      <header className="app-header">
        <h1 className="text-center title">
          (ReasonReact.string("Mastermind"))
        </h1>
      </header>
      <div className="container jumbotron">
        <ControlPanel
          onClick=(_event => self.send(NewGame))
          gameState=self.state.gameState
        />
        <div className="row">
          <div className="col-md-1" />
          <div className="col-md-4">
            <Board
              breakerTries=self.state.breakerTries
              codeToBreak=self.state.codeToBreak
            />
          </div>
          <div className="col-md-4">
            <div className="card bg-default">
              <div className="card-header">
                (ReasonReact.string("Choose a color"))
              </div>
              <div className="card-body">
                (
                  ReasonReact.array(
                    Array.of_list(
                      List.mapi(
                        (idx, colori) =>
                          <ColorButton
                            key=(string_of_int(idx))
                            color=colori
                          />,
                        enumChoosablePegColors(),
                      ),
                    ),
                  )
                )
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>,
};