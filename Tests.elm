module Tests exposing (..)

import Test exposing (..)
import Expect

import Prolog exposing (..)

all : Test
all =
    describe "Suite"
        [ describe "Unit tests"
            [ test "tupleswithzero" <|
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
                      mdl = [(1,2), (2,3),(3,0)
                            ,(3,4),(4,5),(5,6),(6,0)
                            ,(7,8),(8,9),(9,0)
                            ]
                    in
                      mdl
                          |> tupleswithzero
                          |> tuplestolist
                          |> tuplesfromlist
                          |> addinitialtuple
                          |> splitlist mdl
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
            --|> Test.filter (String.contains "integration")
        ]
