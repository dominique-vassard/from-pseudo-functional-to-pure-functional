/* Available peg Colors */
type pegColor =
  | Blue
  | Green
  | Grey
  | Orange
  | Purple
  | Red
  | Yellow;

/* Game states */
type gameState =
  | Start
  | Try
  | Lost
  | Win;

type breakerTry = {
  pegs: list(pegColor),
  result: option(bool),
};

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

let component = ReasonReact.reducerComponent("Mastermind");

let make = _children => {
  ...component,
  reducer: ((), _state: state) => ReasonReact.NoUpdate,
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
  render: _self =>
    <div>
      <header className="app-header">
        <h1 className="text-center title">
          (ReasonReact.string("Mastermind"))
        </h1>
      </header>
      <div className="container jumbotron" />
    </div>,
};