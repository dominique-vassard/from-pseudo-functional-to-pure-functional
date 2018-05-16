module Main exposing (..)

import Html exposing (Html, program, div, header, h1, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Array
import Random
import Utils.ZipperList as ZipperList exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Button as Button
import Bootstrap.Alert as Alert
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import FontAwesome exposing (iconWithOptions, check, times, minus, Size)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



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
    , randomSeed : Random.Seed
    }


nbMaxTries : Int
nbMaxTries =
    10


choosableColors : List PegColor
choosableColors =
    [ Blue, Green, Orange, Purple, Red, Yellow ]


getColor : Int -> PegColor
getColor color_ =
    Maybe.withDefault Grey <|
        Array.get color_ <|
            Array.fromList choosableColors


randomColor : Random.Generator PegColor
randomColor =
    Random.map (\x -> getColor x)
        (Random.int 0 <|
            (List.length choosableColors - 1)
        )


generateCodeToBreak : Random.Seed -> ( CodeToBreak, Random.Seed )
generateCodeToBreak initSeed =
    List.foldl
        (\_ ( colorList, seed ) ->
            let
                ( res, newSeed ) =
                    Random.step randomColor seed
            in
                ( res :: colorList, newSeed )
        )
        ( [], initSeed )
        (List.range 0 3)


init : ( Model, Cmd Msg )
init =
    { breakerTries = initBreakerTries
    , codeToBreak = List.repeat 4 Grey
    , gameState = Start
    , randomSeed = Random.initialSeed 6546146466468
    }
        ! []


initBreakerTries : ZipperList BreakerTry
initBreakerTries =
    ZipperList.init initBreakerTry <|
        List.repeat (nbMaxTries - 1)
            initBreakerTry


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
            let
                ( newCode, newSeed ) =
                    generateCodeToBreak model.randomSeed
            in
                { model
                    | breakerTries = initBreakerTries
                    , codeToBreak = newCode
                    , gameState = Try
                    , randomSeed = newSeed
                }
                    ! []

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
            "grey"

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
        , FontAwesome.useSvg
        , header [ class "app-header" ]
            [ h1 [ class "text-center title" ] [ text "Mastermind" ]
            ]
        , Grid.container [ class "jumbotron" ]
            [ viewControlPanel model.gameState
            , Grid.row []
                [ Grid.col [ Col.md1 ] []
                , Grid.col [ Col.md4 ]
                    [ viewBoard model.breakerTries model.codeToBreak
                    ]
                , Grid.col [ Col.md1 ] []
                , Grid.col [ Col.md5 ]
                    [ viewColorChooser
                    ]
                , Grid.col [ Col.md1 ] []
                ]
            ]
        ]


viewControlPanel : GameState -> Html Msg
viewControlPanel gameState =
    Grid.row []
        [ Grid.col [ Col.md1 ]
            [ Button.button
                [ Button.primary
                , Button.attrs
                    [ onClick NewGame
                    ]
                ]
                [ text "NewGame" ]
            ]
        , Grid.col [ Col.md1 ] []
        , Grid.col [ Col.md10 ]
            [ viewGameStateMessage gameState
            ]
        ]


viewGameStateMessage : GameState -> Html Msg
viewGameStateMessage gameState =
    case gameState of
        Start ->
            Alert.simpleInfo [] [ text "Click 'New Game' to start." ]

        Try ->
            Alert.simpleWarning [] [ text "Try to break the code." ]

        Win ->
            Alert.simpleSuccess [] [ text "You won!" ]

        Lose ->
            Alert.simpleDanger [] [ text "You lose!" ]


viewBoard : ZipperList BreakerTry -> CodeToBreak -> Html Msg
viewBoard breakerTries codeToBreak =
    ListGroup.ul <|
        List.map
            viewBreakerTry
            (ZipperList.toList breakerTries)
            ++ [ viewCodeToBreak codeToBreak
               ]


viewCodeToBreak : CodeToBreak -> ListGroup.Item Msg
viewCodeToBreak codeToBreak =
    ListGroup.li []
        [ div [ class "d-flex flex-row" ] <|
            List.map viewCodePeg codeToBreak
        ]


viewBreakerTry : BreakerTry -> ListGroup.Item Msg
viewBreakerTry breakerTry =
    ListGroup.li []
        [ div [ class "d-flex flex-row" ] <|
            List.map viewCodePeg (ZipperList.toList breakerTry.pegs)
                ++ [ viewResult breakerTry.result ]
        ]


viewCodePeg : PegColor -> Html Msg
viewCodePeg pegColor =
    div [ class <| "codepeg-" ++ (toColor pegColor) ++ " rounded-circle" ] []


viewResult : Maybe Bool -> Html Msg
viewResult result =
    let
        glyph =
            case result of
                Just True ->
                    check

                Just False ->
                    times

                Nothing ->
                    minus

        style_ =
            case result of
                Just True ->
                    "text-success"

                Just False ->
                    "text-danger"

                Nothing ->
                    "text-muted"
    in
        div [ class "d-flex" ]
            [ iconWithOptions glyph
                FontAwesome.Solid
                [ FontAwesome.Size FontAwesome.Large ]
                [ class <| "glyphicon " ++ style_
                ]
            ]


viewColorChooser : Html Msg
viewColorChooser =
    Card.config []
        |> Card.headerH5 [] [ text "Choose a color" ]
        |> Card.block []
            [ Block.custom <| div [] <| List.map viewColorButton choosableColors
            ]
        |> Card.view


viewColorButton : PegColor -> Html Msg
viewColorButton pegColor =
    Button.button
        [ Button.outlineSecondary
        , Button.attrs
            [ class "color-button"
            , onClick <| ChooseColor pegColor
            ]
        ]
        [ viewCodePeg pegColor ]
