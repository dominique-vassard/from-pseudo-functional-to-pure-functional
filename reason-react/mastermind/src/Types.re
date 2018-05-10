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

let enumChoosablePegColors = () => [Blue, Green, Orange, Purple, Red, Yellow];