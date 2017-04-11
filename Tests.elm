module Tests exposing (..)

import Test exposing (..)
import Expect

import Prolog exposing (..)

all : Test
all =
    describe "Suite"
        [ describe "Unit tests"
            [ {- test "shortcut totalfunction" <|
              \() ->
                let 
                  pathlist = [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]
                in
                  pathlist
                    |> totalfunction
                    |> Expect.equal
                      [(1,2),(2,4),(4,5)]

            , -} test "shortcut fromlasttofirst" <|
              \() ->
                let 
                  pathlist = [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]
                in
                  pathlist
                    |> fromlasttofirst
                    |> Expect.equal
                      [(1,2),(2,3),(3,4),(4,5)]

            , test "shortcut listfilter" <|
              \() ->
                let 
                  pathlist = [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]
                  filteredlist = [(1,2),(2,3),(3,4),(4,5)]
                in
                  filteredlist
                    |> listfilter pathlist
                    |> Expect.equal
                      [(2,4)]

            , test "shortcut shortpath" <|
              \() ->
                let 
                  pathlist = [(1,2),(2,3),(3,4),(4,5)]
                  shortvalue = [(2,4)]
                in
                  shortpath pathlist shortvalue []
                    |> Expect.equal
                      [(1,2),(4,5)]

            , test "shortcut shortpath2" <|
              \() ->
                let 
                  pathlist = [(1,2),(4,5)]
                  shortvalue = [(2,4)]
                in
                  pathlist
                    |> shortpath2 shortvalue
                    |> Expect.equal
                      [(1,2),(2,4),(4,5)]

            {-, test "shortcut full shortpath" <|
              \() ->
                let 
                  pathlist = [(1,2),(2,3),(3,4),(4,5)]
                  shortvalue = [(2,4)]
                in
                  shortvalue
                    |> shortpath pathlist
                    |> shortpath2 shortvalue
                    |> Expect.equal
                      [(1,2),(2,4),(4,5)] -}

            , test "tupleswithzero" <|
                \() ->
                    let
                        mdl = [(1,2), (2,3),(3,0)
                              ,(3,4),(4,5),(5,6),(6,0)
                              ,(7,8),(8,9),(9,0)
                              ]
                    in
                        mdl
                            |> tupleswithzero
                            |> Expect.equal
                               [(3,0),(6,0),(9,0)]

            
            , test "tuplestolist" <|
                \() ->
                    let
                        mdl = [(3,0),(6,0),(9,0)]
                    in
                        mdl
                            |> tuplestolist
                            |> Expect.equal
                               [3,6,9]

            , test "tuplesfromlist" <|
                \() ->
                    let
                        mdl = [3,6,9,11,14]
                    in
                        mdl
                            |> tuplesfromlist
                            |> Expect.equal
                               [(3,6),(6,9),(9,11),(11,14)]

            
            , test "addinititaltuple" <|
                \() ->
                    let
                        mdl = [(3,6),(6,9),(9,11),(11,14)]
                    in
                        mdl
                            |> addinitialtuple
                            |> Expect.equal
                               [(0,3),(3,6),(6,9),(9,11),(11,14)]
            
            , test "integration tuplesfromlistfull" <|
                \() ->
                    let
                        mdl = [3,6,9,11,14]
                    in
                        mdl
                            |> tuplesfromlist
                            |> addinitialtuple
                            |> Expect.equal
                               [(0,3),(3,6),(6,9),(9,11),(11,14)]
            
            , test "featurelist" <|
                \() ->
                    let
                        mdl = [(1,2), (2,3),(3,0)
                              ,(3,4),(4,5),(5,6),(6,0)
                              ,(7,8),(8,9),(9,0)]
                        mdl2 = [(0,3),(3,6),(6,9)]
                    in
                        mdl2
                            |> splitlist mdl
                            |> Expect.equal
                               [[(1,2), (2,3)]
                               ,[(3,4),(4,5),(5,6)]
                               ,[(7,8),(8,9)]]

            , test "integration fullfeature" <|
                \() ->
                    let
                      reflist = 
                            [(1,2), (2,3),(3,0)
                            ,(3,4),(4,5),(5,6),(6,0)
                            ,(7,8),(8,9),(9,0)]
                    in
                      reflist
                          |> tupleswithzero
                          |> tuplestolist
                          |> tuplesfromlist
                          |> addinitialtuple
                          |> splitlist reflist
                          |> Expect.equal
                             [[(1,2), (2,3)]
                             ,[(3,4),(4,5),(5,6)]
                             ,[(7,8),(8,9)]]

            , test "Tuples to List" <|
                \() ->
                    let
                        mdl = [(1,2), (2,3), (3,4)]
                        concatfunct list = List.concatMap (\ (a,b) -> [a,b]) list
                    in
                        concatfunct mdl
                        |> Expect.equal
                        [1,2,2,3,3,4]
            ]
            |> Test.filter (String.contains "shortcut")
        ]
