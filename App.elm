module App where

import Html exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp

newEntry phrase points id =
  { phrase = phrase,
    points = points,
    id = id,
    wasSpoken = False
  }

entries =
  [
    (newEntry "Context" 200 1),
    (newEntry "Coffee" 100 2)
  ]

initialModel =
  {
    entries = entries
  }

type Action = NoOp | Sort

update action model =
  case action of
    NoOp -> model
    Sort ->
      { model | entries <- List.sortBy .points model.entries }

entryItem entry =
  li [] [
    span [] [text entry.phrase],
    span [] [text (toString entry.points)]
  ]

entryList entries =
  ul [] (List.map entryItem entries)

pageHeader =
  h2 [] [ text "Bingo" ]

pageFooter =
  p [] [ text "By Jack" ]

view address model =
  div []
    [
      pageHeader,
      entryList model.entries,
      button [ onClick address Sort] [ text "Sort" ],
      pageFooter
    ]

main =
  StartApp.start
    { model = initialModel,
      view = view,
      update = update
    }
