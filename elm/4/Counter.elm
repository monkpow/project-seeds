module CounterWithRemoveButton (Model, init, Action, update, view, viewWithRemoveButton) where

import Html exposing (..)
import Html exposing (div, button, text)
import Html.Events exposing (onClick)

-- MODEL
type alias Model = Int

init : Int -> Model
init count = count

type alias Context =
    { actions : Signal.Address Action
    , remove : Signal.Address ()
    }

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

viewWithRemoveButton : Context -> Model -> Html
viewWithRemoveButton context model =
  div []
    [ button [ onClick context.actions Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick context.actions Increment ] [ text "+" ]
    , div [] []
    , button [ onClick context.remove () ] [ text "X" ]
    ]

