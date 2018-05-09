import React from "react"
import { Panel, Glyphicon } from "react-bootstrap";

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
        if (index === props.currentHistory) {
          indic = <Glyphicon glyph="chevron-right" className="small" />
        }

        return (
          <div key={"dh" + index} onClick={() => props.onClick(index)}>
            {indic} <span key={"sph" + index}>{msg}</span>
          </div>

        )
      })
      }
    </Panel.Body>

  </Panel>

export default History