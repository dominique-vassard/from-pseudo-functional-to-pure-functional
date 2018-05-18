module Main exposing (..)

import Html exposing (Html, program, div, header, h1, i, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Array
import Random
import Utils.ZipperList as ZipperList exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Button as Button
import Bootstrap.Alert as Alert
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block


main : Program Flags Model Msg
main =
    Html.programWithFlags
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


type alias History =
    ZipperList (ZipperList BreakerTry)


type alias Model =
    { breakerTries : ZipperList BreakerTry
    , codeToBreak : CodeToBreak
    , gameState : GameState
    , randomSeed : Random.Seed
    , history : History
    }


type alias Flags =
    { initSeed : Int
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


initHistory : History
initHistory =
    ZipperList.init initBreakerTries []


init : Flags -> ( Model, Cmd Msg )
init flags =
    { breakerTries = initBreakerTries
    , codeToBreak = List.repeat 4 Grey
    , gameState = Start
    , randomSeed = Random.initialSeed flags.initSeed
    , history = ZipperList.init initBreakerTries []
    }
        ! []



--- UPDATE


type Msg
    = NewGame
    | ChooseColor PegColor
    | MoveHistory Int


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
                    , history = initHistory
                }
                    ! []

        ChooseColor color_ ->
            let
                breakerTry =
                    ZipperList.current model.breakerTries

                newBreakerTry =
                    { breakerTry | pegs = ((ZipperList.update color_) << .pegs) breakerTry }

                breakerTries =
                    ZipperList.update newBreakerTry model.breakerTries

                gameState =
                    case ZipperList.hasNext breakerTries == False && (ZipperList.hasNext << .pegs << ZipperList.current) breakerTries == False of
                        True ->
                            Lose

                        False ->
                            model.gameState

                endGameState =
                    case (ZipperList.hasNext << .pegs << ZipperList.current) breakerTries == False && (checkTry (ZipperList.current breakerTries) model.codeToBreak) == Just True of
                        True ->
                            Win

                        False ->
                            gameState

                breakerTry_ =
                    ZipperList.current breakerTries

                newBreakerTry_ =
                    case (ZipperList.hasNext << .pegs << ZipperList.current) breakerTries of
                        False ->
                            { breakerTry_
                                | result = checkTry (ZipperList.current breakerTries) model.codeToBreak
                            }

                        _ ->
                            breakerTry_

                breakerTries_ =
                    ZipperList.update newBreakerTry_ breakerTries

                newBreakerTries =
                    case ZipperList.hasNext newBreakerTry_.pegs of
                        True ->
                            let
                                nTry =
                                    { newBreakerTry_
                                        | pegs = (ZipperList.forward << .pegs << ZipperList.current) breakerTries_
                                    }
                            in
                                ZipperList.update nTry breakerTries_

                        False ->
                            ZipperList.forward breakerTries_
            in
                { model
                    | breakerTries = newBreakerTries
                    , gameState = endGameState
                    , history = ZipperList.add newBreakerTries model.history
                }
                    ! []

        MoveHistory step ->
            let
                func =
                    if step > 0 then
                        ZipperList.forward
                    else
                        ZipperList.back

                history =
                    List.foldl (\_ acc -> func acc) model.history <| List.range 0 ((abs step) - 1)
            in
                { model | breakerTries = ZipperList.current history, history = history } ! []


checkTry : BreakerTry -> CodeToBreak -> Maybe Bool
checkTry breakerTry codeToBreak =
    Just <| ZipperList.toList breakerTry.pegs == codeToBreak


isEndOfTries : ZipperList BreakerTry -> Bool
isEndOfTries breakerTries =
    ZipperList.hasNext breakerTries == False && (ZipperList.hasNext << .pegs << ZipperList.current) breakerTries == False



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
                    [ viewColorChooser model.gameState
                    , viewHistory model.gameState model.history
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
                    "check"

                Just False ->
                    "times"

                Nothing ->
                    "minus"

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
            [ i
                [ class <| "glyphicon fas fa-" ++ glyph ++ " " ++ style_
                ]
                []
            ]


viewColorChooser : GameState -> Html Msg
viewColorChooser gameState =
    Card.config []
        |> Card.headerH5 [] [ text "Choose a color" ]
        |> Card.block []
            [ Block.custom <| div [] <| List.map (viewColorButton gameState) choosableColors
            ]
        |> Card.view


viewColorButton : GameState -> PegColor -> Html Msg
viewColorButton gameState pegColor =
    let
        supAttrs =
            case gameState of
                Try ->
                    [ onClick <| ChooseColor pegColor ]

                _ ->
                    []
    in
        Button.button
            [ Button.outlineSecondary
            , Button.attrs <|
                [ class "color-button"
                ]
                    ++ supAttrs
            ]
            [ viewCodePeg pegColor ]


toDisplayableHistories : History -> List ( Int, Int )
toDisplayableHistories history =
    let
        curIndex =
            List.length history.previous

        idxList =
            ZipperList.toList history |> (Array.fromList >> Array.toIndexedList)
    in
        List.foldl (\( idx, val ) acc -> acc ++ [ ( idx, idx - curIndex ) ]) [] idxList


viewHistory : GameState -> History -> Html Msg
viewHistory gameState history =
    let
        histories =
            case gameState of
                Start ->
                    div [] []

                _ ->
                    div [] <| List.map viewHistoryLine <| toDisplayableHistories history
    in
        Card.config []
            |> Card.headerH5 [] [ text "Your moves" ]
            |> Card.block []
                [ Block.custom histories
                ]
            |> Card.view


viewHistoryLine : ( Int, Int ) -> Html Msg
viewHistoryLine ( idx, step ) =
    div [ onClick (MoveHistory step) ]
        [ text <| "Move #" ++ (toString idx)
        ]
