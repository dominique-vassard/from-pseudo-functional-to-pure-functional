open Types;

let codePhrase = ReasonReact.statelessComponent("CodePhrase");

let make = (~phrase: breakerTry, _children) => {
  ...codePhrase,
  render: _self =>
    <li className="list-group-item">
      <div className="d-flex flew-row">
        (
          ReasonReact.array(
            Array.mapi(
              (idx, phrase_color) =>
                <CodePeg key=(string_of_int(idx)) color=phrase_color />,
              phrase.pegs,
            ),
          )
        )
        <CodeResult result=phrase.result />
      </div>
    </li>,
};