-- Model


module Main exposing (..)

import Html exposing (Html, main_, header, h1, text, div, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { counters : List Int
    }


init : Model
init =
    { counters = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    }



-- Update


type Msg
    = Increment Int
    | Decrement Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment indexToChange ->
            let
                updateList index cnt =
                    if index == indexToChange then
                        cnt + 1
                    else
                        cnt
            in
                { model | counters = List.indexedMap updateList model.counters }

        Decrement indexToChange ->
            let
                updateList index cnt =
                    if index == indexToChange then
                        cnt - 1
                    else
                        cnt
            in
                { model | counters = List.indexedMap updateList model.counters }



-- View


view : Model -> Html Msg
view model =
    main_ []
        [ h1 [] [ text "Counters" ]
        , div [ class "counters" ]
            (List.indexedMap viewCounter model.counters)
        ]


viewCounter : Int -> Int -> Html Msg
viewCounter index count =
    div [ class "counter" ]
        [ button [ onClick (Increment index) ] [ text "+" ]
        , text (toString count)
        , button [ onClick (Decrement index) ] [ text "-" ]
        ]



-- Main


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
