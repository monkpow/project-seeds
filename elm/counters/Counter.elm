module Counter (Model, init, Action, update, view) where

import Html exposing (div, button, text)
import Html.Events exposing (onClick)

-- MODEL
type alias Model = Int

init : Int -> Model
init count = count

-- UPDATE

type Action = Increment | Decrement

update : Action -> Model -> Model
update action model =
  case action of
    Increment -> model + 1
    Decrement -> model - 1

-- VIEW
view : Signal.Address Action -> Model -> Html.Html
view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]
