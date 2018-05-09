import React from 'react';

/**
 * Component: ColorPeg
 * Display a round peg with the given color
 *
 * @param       {object}        props           The required properties:
 *                                              {
 *                                                      "color": the peg color
 *                                              }
 *
 * @returns                                     The component
 */
const CodePeg = (props) =>
        <div className={"codepeg-" + props.color + " rounded-circle"} />

export default CodePeg