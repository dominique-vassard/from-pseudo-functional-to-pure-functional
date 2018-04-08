import React from 'react';
import ReactDom from 'react-dom';
import './index.css';

class Counter extends React.Component {
    renderCountDisplay(current_count) {
        return <CountDisplay count={current_count} />;
    }

    render() {
        return (
            <div >
                <h1>This a simple counter</h1>
                <Incrementer />
                {this.renderCountDisplay(0)}
                <Decrementer />
            </div>
        );
    }
}

class Incrementer extends React.Component {
    render() {
        return (
            <button className="count-updater" onClick={() => alert("+")}>
                +
            </button>
        );
    }
}

class Decrementer extends React.Component {
    render() {
        return (
            <button className="count-updater" onClick={() => alert("-")}>
                -
            </button>
        );
    }
}

class CountDisplay extends React.Component {
    render() {
        return (
            <div className="count-display">
                <span>{this.props.count}</span>
            </div>
        );
    }
}

ReactDom.render(
    <Counter />,
    document.getElementById("root")
);