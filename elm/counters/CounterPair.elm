module CounterPair (Model, init, Action, update, view) where

import Counter
import Html exposing (div, button, text)
import Html.Events exposing (onClick)

-- MODEL

type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }

init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }

-- UPDATE

type Action = Reset | Top Counter.Action | Bottom Counter.Action

update : Action -> Model -> Model
update action model =
  case action of
    Reset -> init 0 0

    Top act ->
      { model |
          topCounter <- Counter.update act model.topCounter
      }

    Bottom act ->
      { model |
          bottomCounter <- Counter.update act model.bottomCounter
      }

-- VIEW

view : Signal.Address Action -> Model -> Html.Html
view address model =
  div []
    [ Counter.view (Signal.forwardTo address Top) model.topCounter
    , Counter.view (Signal.forwardTo address Bottom) model.bottomCounter
    , button [ onClick address Reset ] [ text "RESET" ]
    ]
