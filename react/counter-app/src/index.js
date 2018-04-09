import React from 'react';
import ReactDom from 'react-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import {Grid, Col, Button, Row} from 'react-bootstrap';
import './index.css';

class Counter extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            current_count: 6
        };
    }

    udpateCount(is_increment) {
        const current_count = this.state.current_count;
        if (is_increment) {
            this.setState({current_count: current_count + 1});
        } else {
            this.setState({current_count: current_count - 1});
        }
    }

    renderCountDisplay(current_count) {
        return <CountDisplay count={current_count}/>;
    }

    render() {
        return (
            <div className="container jumbotron">
                <Grid>
                    <Row>
                        <Col md={12} className="mx-auto">
                            <center><h1>This a simple counter</h1></center>
                        </Col>
                    </Row>
                    <Row className="mt-5" />
                    <Row>
                        <Col md={3}>
                            <Decrementer  onClick={() => this.udpateCount(false)} />
                        </Col>
                        <Col md={6}>
                            <center>
                                <h1>{this.renderCountDisplay(this.state.current_count)}</h1>
                            </center>
                        </Col>
                        <Col md={3}>
                            <Incrementer  onClick={() => this.udpateCount(true)} />
                        </Col>
                    </Row>
                </Grid>
            </div>
        );
    }
}

function Incrementer(props) {
    return (
        <button className="btn btn-success btn-block" onClick={() => props.onClick()}>
            +
        </button>
    );
}

function Decrementer(props){
    return (
        <Button className="btn btn-danger btn-block" onClick={() => props.onClick()}>
            -
        </Button>
    );
}

function CountDisplay(props) {
    return (
        <div className="count-display">
            <span>{props.count}</span>
        </div>
    );
}

ReactDom.render(
    <Counter />,
    document.getElementById("root")
);