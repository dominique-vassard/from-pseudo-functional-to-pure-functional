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

/* Breakertry */
type breakerTry = {
  pegs: array(pegColor),
  result: option(bool),
};

/* Choosable pegColor list */
let enumChoosablePegColors = () => [|
  Blue,
  Green,
  Orange,
  Purple,
  Red,
  Yellow,
|];