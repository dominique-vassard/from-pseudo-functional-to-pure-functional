module Main exposing (..)

import Html exposing (Html, program, div, header, h1, text)
import Html.Attributes exposing (class)
import Utils.ZipperList as ZipperList exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL


type PegColor
    = Blue
    | Green
    | Grey
    | Orange
    | Purple
    | Red
    | Yellow


type GameState
    = Start
    | Try
    | Win
    | Lose


type alias BreakerTry =
    { pegs : ZipperList PegColor
    , result : Maybe Bool
    }


type alias CodeToBreak =
    List PegColor


type alias Model =
    { breakerTries : ZipperList BreakerTry
    , codeToBreak : CodeToBreak
    , gameState : GameState
    }


nbMaxTries : Int
nbMaxTries =
    10


init : ( Model, Cmd Msg )
init =
    { breakerTries = initBreakerTries
    , codeToBreak = List.repeat 4 Grey
    , gameState = Start
    }
        ! []


initBreakerTries : ZipperList BreakerTry
initBreakerTries =
    ZipperList.init initBreakerTry <| List.repeat (nbMaxTries - 1) initBreakerTry


initBreakerTry : BreakerTry
initBreakerTry =
    { pegs = ZipperList.init Grey <| List.repeat 3 Grey
    , result = Nothing
    }



--- UPDATE


type Msg
    = NewGame
    | ChooseColor PegColor


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewGame ->
            model ! []

        ChooseColor color ->
            model ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


toColor : PegColor -> String
toColor pegColor =
    case pegColor of
        Blue ->
            "blue"

        Green ->
            "green"

        Grey ->
            "lightgrey"

        Orange ->
            "orange"

        Purple ->
            "purple"

        Red ->
            "red"

        Yellow ->
            "yellow"


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet
        , header []
            [ h1 [ class "text-center" ] [ text "Mastermind" ]
            ]
        , Grid.container [ class "container jumbotron" ]
            [ Grid.row []
                [ Grid.col [ Col.md1 ] []
                , Grid.col [ Col.md4 ]
                    [ viewBoard model.breakerTries model.codeToBreak
                    ]
                , Grid.col [ Col.md1 ] []
                , Grid.col [ Col.md5 ] []
                , Grid.col [ Col.md1 ] []
                ]
            ]
        ]


viewBoard : ZipperList BreakerTry -> CodeToBreak -> Html Msg
viewBoard breakerTries codeToBreak =
    ListGroup.ul
        [ viewCodeToBreak codeToBreak
        ]


viewCodeToBreak : CodeToBreak -> ListGroup.Item Msg
viewCodeToBreak codeToBreak =
    ListGroup.li [] [ div [ class "d-flex flex-row" ] <| List.map viewCodePeg codeToBreak ]


viewCodePeg : PegColor -> Html Msg
viewCodePeg pegColor =
    div [ class <| "codepeg-" ++ (toColor pegColor) ++ " rounded-circle" ] []
