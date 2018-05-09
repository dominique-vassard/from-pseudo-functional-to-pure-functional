import React from "react"
import { Panel } from "react-bootstrap";

const History = (props) =>
  <Panel>
    <Panel.Heading>
      Your moves
    </Panel.Heading>
    <Panel.Body>
      {props.history.map((move, index) =>
        <div key={"dh" + index} onClick={() => props.onClick(index)}>
          <span key={"sph" + index}>Move #{index}</span>
        </div>
      )
      }
    </Panel.Body>

  </Panel>

export default History