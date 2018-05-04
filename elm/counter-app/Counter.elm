-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html


module Main exposing (..)

import Html exposing (Html, program, div, button, text, h1)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { count : Int }


init : ( Model, Cmd Msg )
init =
    ( Model 0, Cmd.none )



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 } ! []

        Decrement ->
            { model | count = model.count - 1 } ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    Grid.container []
        -- Responsive fixed width container
        [ CDN.stylesheet
          -- Interactive and responsive menu
        , mainContent model
        ]


mainContent : Model -> Html Msg
mainContent model =
    div [ class "container jumbotron" ]
        [ Grid.row []
            [ Grid.col [ Col.md12 ]
                [ h1 [ class "text-center" ]
                    [ text "This is a simple counter"
                    ]
                ]
            ]
        , Grid.row [ Row.attrs [ class "mt-5" ] ] []
        , Grid.row []
            [ Grid.col [ Col.md3, Col.attrs [ class "text-center" ] ]
                [ Button.button [ Button.danger, Button.attrs [ onClick Decrement ] ] [ text "-" ]
                ]
            , Grid.col [ Col.md6 ]
                [ h1 [ class "text-center" ] [ text <| toString model.count ]
                ]
            , Grid.col [ Col.md3, Col.attrs [ class "text-center" ] ]
                [ Button.button [ Button.success, Button.attrs [ onClick Increment ] ] [ text "+" ]
                ]
            ]
        ]
