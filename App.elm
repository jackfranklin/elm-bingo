module App where

import Html exposing (..)
import Html.Attributes exposing (..)
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

type Action =
  NoOp |
  Sort |
  Delete Int |
  Mark Int

update action model =
  case action of
    NoOp -> model
    Sort ->
      { model | entries <- List.sortBy .points model.entries }
    Delete id ->
      { model |  entries <- List.filter (\e -> e.id /= id) model.entries }
    Mark id ->
      let
        updateEntry e =
          if e.id == id then { e | wasSpoken <- (not e.wasSpoken) } else e
      in
        { model | entries <- List.map updateEntry model.entries }

entryItem address entry =
  li [
      classList [ ("highlight", entry.wasSpoken) ],
      onClick address (Mark entry.id)
     ]
     [
      span [] [text entry.phrase],
      span [] [text (" - " ++ (toString entry.points))],
      a [ href "#", onClick address (Delete entry.id) ] [text (" - " ++ "Delete")]
    ]

entryList address entries =
  ul [] (List.map (entryItem address) entries)

pageHeader =
  h2 [] [ text "Bingo" ]

pageFooter =
  p [] [ text "By Jack" ]

view address model =
  div []
    [
      pageHeader,
      entryList address model.entries,
      button [ onClick address Sort] [ text "Sort" ],
      pageFooter
    ]

main =
  StartApp.start
    { model = initialModel,
      view = view,
      update = update
    }
