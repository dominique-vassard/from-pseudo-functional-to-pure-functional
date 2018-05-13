let historyComponent = ReasonReact.statelessComponent("History");

let get_message = (idx, nbHistories) =>
  if (idx == 0) {
    "Start";
  } else if (idx == nbHistories) {
    "Resume";
  } else {
    "Move #" ++ string_of_int(idx);
  };

let get_indicator_class = (idx, currentHistoryIndex) =>
  if (idx == currentHistoryIndex) {
    "fas fa-angle-right";
  } else {
    "";
  };

let get_selected = (idx, currentHistoryIndex) =>
  if (idx == currentHistoryIndex) {
    "selected-history";
  } else {
    "";
  };

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