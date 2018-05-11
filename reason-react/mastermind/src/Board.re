let board = ReasonReact.statelessComponent("Board");

let make = (~breakerTries, ~codeToBreak, _children) => {
  ...board,
  render: _self =>
    <ul className="list-group">
      (
        ReasonReact.array(
          Array.mapi(
            (idx, breakerTry) =>
              <CodePhrase key=(string_of_int(idx)) phrase=breakerTry />,
            breakerTries,
          ),
        )
      )
      <CodePhrase phrase=codeToBreak />
    </ul>,
};