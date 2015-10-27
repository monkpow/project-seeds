module CounterNik where

import Html exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model = Int

init: Int -> Model
init count = count

-- UPDATE

type Action = Increment | Decrement | Reset | Make100

update : Action -> Model -> Model
update action model =
  case action of
    Increment -> model + 1
    Decrement -> model - 1
    Reset -> init 0
    Make100 -> init 100

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    ,div [] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    , button [ onClick address Reset ] [ text "reset" ]
    , button [ onClick address Make100 ] [ text "make100" ]
    ]



