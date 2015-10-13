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

tests : Test
tests = suite "The Update Method"
        [ test "Addition" (assertEqual (3 + 7) 10),
          test "NoOp" (assertEqual (App.update App.NoOp model) model),
          test "Delete" (assertEqual (App.update (App.Delete 1) model) deletedModel)
        ]

main = runDisplay tests
