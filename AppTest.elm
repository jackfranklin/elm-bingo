import String

import ElmTest.Test exposing (test, Test, suite)
import ElmTest.Assertion exposing (assert, assertEqual)
import ElmTest.Runner.Element exposing (runDisplay)

import App

entries =
  [
    (App.newEntry "Context" 200 1),
    (App.newEntry "Coffee" 100 2)
  ]

model =
  { entries = entries }

deletedModel =
  { entries = List.filter (\e -> e.id /= 1) model.entries }

sortedModel =
  { entries = List.sortBy .points model.entries }

markedModel =
  let
    markEntry e =
      if e.id == 1 then { e | wasSpoken <- True } else e
  in
    { entries = List.map markEntry model.entries }

tests : Test
tests = suite "The Update Method"
        [ test "Addition" (assertEqual (3 + 7) 10),
          test "NoOp" (assertEqual (App.update App.NoOp model) model),
          test "Delete" (assertEqual (App.update (App.Delete 1) model) deletedModel),
          test "Mark" (assertEqual (App.update (App.Mark 1) model) markedModel),
          test "Sort" (assertEqual (App.update App.Sort model) sortedModel)
        ]

main = runDisplay tests
