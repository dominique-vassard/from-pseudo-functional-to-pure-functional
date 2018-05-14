let historyComponent = ReasonReact.statelessComponent("History");

/**
 * Return message to use depending on hisoty index
 *
 * @param   int          idx            The index
 * @param   int          nbHistories      The number of histories
 *
 * @returns string                      The message string
 *
 */
let get_message = (idx, nbHistories) =>
  if (idx == 0) {
    "Start";
  } else if (idx == nbHistories) {
    "Resume";
  } else {
    "Move #" ++ string_of_int(idx);
  };

/**
   * Return indicator to display depending on the index
   *
   * @param   int       idx             The index
   * @param   int       currentHistory  The curent hisory index
   *
   * @returns string                     The indicator
   *
   */
let get_indicator_class = (idx, currentHistoryIndex) =>
  if (idx == currentHistoryIndex) {
    "fas fa-angle-right";
  } else {
    "";
  };

/**
   * Return selected status to use depending on the index
   *
   * @param   int       idx             The index
   * @param   int       currentHistory  The curent hisory index
   *
   * @returns string                     The selected class
   *
   */
let get_selected = (idx, currentHistoryIndex) =>
  if (idx == currentHistoryIndex) {
    "selected-history";
  } else {
    "";
  };

/* Component definition */
let make = (~history, ~currentHistoryIndex, ~onClick, _children) => {
  ...historyComponent,
  render: self =>
    <div className="card bg-default">
      <div className="card-header"> (ReasonReact.string("Your moves")) </div>
      <div className="card-body">
        (
          ReasonReact.array(
            Array.mapi(
              (idx, _) =>
                <div
                  key=("dh" ++ string_of_int(idx))
                  className=(
                    "link rounded " ++ get_selected(idx, currentHistoryIndex)
                  )
                  onClick=(self.handle((event, click) => onClick(idx)))>
                  <i
                    className=(get_indicator_class(idx, currentHistoryIndex))
                  />
                  <span key=("sph" ++ string_of_int(idx))>
                    (
                      ReasonReact.string(
                        get_message(idx, Array.length(history) - 1),
                      )
                    )
                  </span>
                </div>,
              history,
            ),
          )
        )
      </div>
    </div>,
};