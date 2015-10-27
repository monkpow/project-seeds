module CounterList where

import CounterWithRemoveButton
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model =
    { counters : List ( ID, CounterWithRemoveButton.Model )
    , nextID : ID
    }

type alias ID = Int

init : Model
init =
    { counters = []
    , nextID = 0
    }

-- UPDATE

type Action
    = Insert
    | Remove ID
    | Modify ID CounterWithRemoveButton.Action

update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
      { model |
          counters <- (model.nextID, CounterWithRemoveButton.init 0) :: model.counters,
          nextId <- model.nextID + 1
      }

    Remove id ->
      { model | counters <- List.filter (\(counterID, _) -> counterID /= id) model.counters }

    Modify id counterAction ->
      let updateCounter (counterID, counterModel) =
            if counterID == id
                then (counterID, CounterWithRemoveButton.update counterAction counterModel)
                else (counterID, counterModel)
      in
          { model | counters <- List.map updateCounter model.counters }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let insert = button [ onClick address Insert ] [ text "Add" ]
  in
    div [] (insert :: List.map (viewCounter address) model.counters)

viewCounter : Signal.Address Action -> (ID, CounterWithRemoveButton.Model) -> Html
viewCounter address (id, model) =
  let context =
        CounterWithRemoveButton.Context
          (Signal.forwardTo address (Modify id))
          (Signal.forwardTo address (always (Remove id)))
  in
    CounterWithRemoveButton.viewWithRemoveButton context model
