import React from "react"
import { Panel, Glyphicon } from "react-bootstrap";

/**
 * Component: History
 * Display move list
 * Allow time travel through moves
 *
 * @param       {object}        props           The required properties:
 *                                              {
 *                                                      "history": {Array} the complete game history
 *                                                      "onClick": {function} the function to travel through moves
 *                                              }
 *
 * @returns                                     The component
 */
const History = (props) =>
  <Panel>
    <Panel.Heading>
      Your moves
    </Panel.Heading>
    <Panel.Body>
      {props.history.map((move, index) => {
        let msg = "Move #" + index
        if (index === 0) {
          msg = "Start"
        } else if (index === props.history.length - 1) {
          msg = "Resume"
        }

        let indic = ""
        let selected = ""
        if (index === props.currentHistory) {
          indic = <Glyphicon glyph="chevron-right" className="small" />
          selected = "selected-history"
        }


        return (
          <div key={"dh" + index} onClick={() => props.onClick(index)} className={"link rounded " + selected}>
            {indic} <span key={"sph" + index}>{msg}</span>
          </div>

        )
      })
      }
    </Panel.Body>

  </Panel>

export default History