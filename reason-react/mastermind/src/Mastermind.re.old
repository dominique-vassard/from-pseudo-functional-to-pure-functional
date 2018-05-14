open Types;

/* Hisotry types */
type history = {
  breakerTries: array(breakerTry),
  gameState,
};

/* State (model) type */
type state = {
  nbMaxTries: int,
  breakerTries: array(breakerTry),
  codeToBreak: breakerTry,
  currentTryIndex: int,
  currentColorChoiceIndex: int,
  gameState,
  history: array(history),
  historyIndex: int,
};

/* Available actions */
type action =
  | NewGame
  | ChooseColor(pegColor)
  | GotToHistory(int);

/**
 * Initialize pegs color
 *
 * @param     int   start     From which int to start
 *
 * @returns   list            A list of pegColor
 *
 */
let rec init_code_pegs = start =>
  if (start >= 4) {
    [];
  } else {
    let colors = enumChoosablePegColors();
    [
      colors[Random.int(Array.length(colors) - 1)],
      ...init_code_pegs(start + 1),
    ];
  };

/**
 * Initializes code to break
 *
 * @returns     breakerTry      The code to break
 */
let init_code_to_break = () => {
  pegs: Array.of_list(init_code_pegs(0)),
  result: None,
};

/**
 * Return a default breakerTry, i.e all Grey with enmpty result
 *
 * @returns     breakerTry      A default breakerTry
 */
let initBreakerTry = () => {pegs: Array.init(4, (_) => Grey), result: None};

/**
 * Initializes list of beakerTries
 *
 * @param     int    nbMaxTries   The maximum number of tries
 *
 * @returns   breakerTries        An array of breakerTry
 */
let initBreakerTries = (nbMaxTries: int) =>
  Array.init(nbMaxTries, (_) => initBreakerTry());

/**
 * Set the state for a new game
 *
 * @param   state     state
 */
let new_game = state =>
  ReasonReact.Update({
    ...state,
    breakerTries: initBreakerTries(state.nbMaxTries),
    codeToBreak: init_code_to_break(),
    currentTryIndex: 0,
    currentColorChoiceIndex: 0,
    gameState: Try,
    history: [|
      {breakerTries: initBreakerTries(state.nbMaxTries), gameState: Try},
    |],
    historyIndex: 0,
  });

/**
 * Copy a breakerTries Array
 *
 * @param     breakerTries    The original
 *
 * @returns   breakerTries    The copy
 */
let copy_breakerTries = breakerTries =>
  Array.map(
    bt => {pegs: Array.copy(bt.pegs), result: bt.result},
    breakerTries,
  );

/**
   * Manage action: ChooseColor
   * Update state depending on the color (and the game win/lose)
   *
   * @param     state     state     The current state
   * @param     pegColor  color     The chosen color
   */
let choose_color = (state, color) =>
  switch (state.gameState) {
  | Try when state.historyIndex == Array.length(state.history) - 1 =>
    let newTries = copy_breakerTries(state.breakerTries);
    newTries[state.currentTryIndex].pegs[state.currentColorChoiceIndex] = color;
    let gameWon =
      if (state.currentColorChoiceIndex
          + 1 == 4
          && newTries[state.currentTryIndex].pegs == state.codeToBreak.pegs) {
        true;
      } else {
        false;
      };
    let result: option(bool) =
      if (state.currentColorChoiceIndex
          + 1 == 4
          && newTries[state.currentTryIndex].pegs == state.codeToBreak.pegs) {
        Some(true);
      } else if (state.currentColorChoiceIndex
                 + 1 == 4
                 &&
                 newTries[state.currentTryIndex].pegs != state.codeToBreak.pegs) {
        Some(false);
      } else {
        None;
      };
    let curTry = {pegs: newTries[state.currentTryIndex].pegs, result};
    newTries[state.currentTryIndex] = curTry;
    let currentColorChoiceIndex =
      if (state.currentColorChoiceIndex + 1 == 4) {
        0;
      } else {
        state.currentColorChoiceIndex + 1;
      };
    let currentTryIndex =
      if (state.currentColorChoiceIndex + 1 == 4) {
        state.currentTryIndex + 1;
      } else {
        state.currentTryIndex;
      };
    let gameState =
      if (gameWon) {
        Win;
      } else if (currentTryIndex == state.nbMaxTries) {
        Lost;
      } else {
        state.gameState;
      };
    let history =
      Array.append(
        state.history,
        Array.make(1, {breakerTries: newTries, gameState}),
      );
    ReasonReact.Update({
      ...state,
      breakerTries: newTries,
      currentTryIndex,
      currentColorChoiceIndex,
      gameState,
      history,
      historyIndex: state.historyIndex + 1,
    });
  | _ => ReasonReact.NoUpdate
  };

/**
   * Go to given history index
   *
   * @param     state     state         The current state
   * @param     int       historyIndex  The wanted hisotryIndex
   */
let go_to_history = (state, historyIndex) =>
  ReasonReact.Update({
    ...state,
    breakerTries: state.history[historyIndex].breakerTries,
    gameState: state.history[historyIndex].gameState,
    historyIndex,
  });

/* ReasonReact.NoUpdate; */
let mastermind_component = ReasonReact.reducerComponent("Mastermind");

/* Component definition */
let make = _children => {
  ...mastermind_component,
  initialState: () => {
    nbMaxTries: 10,
    breakerTries: initBreakerTries(10),
    codeToBreak: initBreakerTry(),
    currentTryIndex: 0,
    currentColorChoiceIndex: 0,
    gameState: Start,
    history: [||],
    historyIndex: 0,
  },
  reducer: (action, state: state) =>
    switch (action) {
    | NewGame => new_game(state)
    | ChooseColor(color) => choose_color(state, color)
    | GotToHistory(historyIndex) => go_to_history(state, historyIndex)
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
          <div className="col-md-5">
            <div className="card bg-default">
              <div className="card-header">
                (ReasonReact.string("Choose a color"))
              </div>
              <div className="card-body">
                (
                  ReasonReact.array(
                    Array.mapi(
                      (idx, color) =>
                        <ColorButton
                          key=(string_of_int(idx))
                          color
                          onClick=(_event => self.send(ChooseColor(color)))
                        />,
                      enumChoosablePegColors(),
                    ),
                  )
                )
              </div>
            </div>
            <History
              history=self.state.history
              currentHistoryIndex=self.state.historyIndex
              onClick=(idx => self.send(GotToHistory(idx)))
            />
          </div>
        </div>
      </div>
    </div>,
};