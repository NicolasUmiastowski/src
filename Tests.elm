module Tests exposing (..)

import Test exposing (..)
import Expect


--import Fuzz exposing (..)
--import String

import Prolog exposing (..)


--import Random.Pcg as Random exposing (Generator)
--import Shrink exposing (..)


all : Test
all =
    describe "Suite"
        [ describe "Unit tests"
            [ test "Feature : (1,2), (2,3), (3,0), (3,4), (4,5), (5,6), (7,8)" <|
                \() ->
                    let
                        mdl =
                            [(1,2), (2,3), (3,0), (3,4), (4,5), (5,6), (7,8)]
                    in
                        mdl
                            |> Prolog.feature
                            |> Expect.equal
                                [[(1,2), (2,3), (3,0)], [(3,4), (4,5), (5,6)], [(7,8)]]

            , test "FeatureStories : (1,2), (2,3), (3,0), (4,5) == (1,2,3)" <|
                \() ->
                    let
                        mdl =
                            [[(1,2), (2,3), (3,0)], [(3,4), (4,5), (5,6), (6,0)], [(7,8),(8,0)]]
                    in
                        mdl
                            |> Prolog.featurestories
                            |> Expect.equal
                                [[1,2,3], [3,4,5,6],[7,8]]

            , test "FeatureLength : (1,2,3,4) == 4" <|
                \() ->
                    let
                        mdl =
                            [[1,2,3], [3,4,5,6], [7,8]]
                    in
                        mdl
                            |> Prolog.featurelength
                            |> Expect.equal
                                [3,4,2]

            , test "storypredecessor : [[1,2,3], [3,4,5,6], [7,8]] == 4" <|
                \() ->
                    let
                        mdl =
                            [(1,2), (2,3), (3,0), (4,3), (4,5), (5,6), (7,8)]
                    in
                        mdl
                            |> Prolog.storypredecessor
                            |> Expect.equal
                               [0,2,3,3,5,6,8]

            , test "mytest : [0,2,3,3,5,6,8]" <|
                \() ->
                    let
                        mdl =
                            [0,2,3,3,5,6,8]
                    in
                        mdl
                            |> Prolog.mytest
                            |> Expect.equal
                               [[0], [2], [3,3], [5], [6], [8]]
            
            , test "mytest2 : [[0], [2], [3,3], [5], [6], [8]]" <|
                \() ->
                    let
                        mdl =
                            [[0], [2], [3,3], [5], [6], [8]]
                    in
                        mdl
                            |> Prolog.mytest2
                            |> Expect.equal
                               [[3,3]]

            , test "mytest3 : [(1,4),(4,5), (4,8), (5,8), (7,8), (8,9)]" <|
                \() ->
                    let
                        mdl =
                            [(1,4),(4,5), (4,8), (5,8), (7,8), (8,9)]
                    in
                        mdl
                            |> Prolog.mytest3
                            |> Expect.equal
                               [[8,8,8]]

            {-, test "storypred2 : [[1,2,3], [3,4,5,6], [7,8]] == 4" <|
                \() ->
                    let
                        mdl =
                            [(1,2), (2,3), (3,0), (4,3), (4,5), (5,6), (7,8)]
                    in
                        mdl
                            |> Prolog.storypred2
                            |> Expect.equal
                               [1,2,3,4,4,5,7] -}
            
            {-, test "storypred3 : [[1,2,3], [3,4,5,6], [7,8]] == 4" <|
                \() ->
                    let
                        mdl =
                            [(1,2), (2,3), (3,0), (4,3), (4,5), (5,6), (7,8)]
                    in
                        mdl
                            |> Prolog.storypred3
                            |> Expect.equal
                               [(1,2), (5,6)]

            , test "storypred4 : [[1,2,3], [3,4,5,6], [7,8]] == 4" <|
                \() ->
                    let
                        mdl =
                            [(1,2), (2,3), (3,0), (4,3), (4,5), (5,6), (7,8)]
                    in
                        mdl
                            |> Prolog.storypred4
                            |> Expect.equal
                               [(1,2), (5,6)]
            -}


            {-, test "Feature2Pure : (1,2), (2,3), (3,4), (4,0), (4,5)" <|
                \() ->
                    let
                        mdl =
                            [(1,2), (2,3), (3,4), (4,0), (4,5)]
                    in
                        mdl
                            |> Prolog.feature2
                            |> Expect.equal
                                [(1,2), (2,3), (3,4), (4,5)] -}
               
             {-, test "if Player1 wins two sets" <|
                \() ->
                    let
                        mdl =
                            Model (MatchInProgress { player1UpToThree = Two, player2UpToThree = Three })
                    in
                        mdl
                            |> Tennismodel1612.update Player1WonSet
                            |> Tuple.first
                            |> .setstowin
                            |> Expect.equal
                                (MatchInProgress { player1UpToThree = One, player2UpToThree = Three })

             , test "if Player1 wins three sets" <|
                \() ->
                    let
                        mdl =
                            Model (MatchInProgress { player1UpToThree = One, player2UpToThree = Three })
                    in
                        mdl
                            |> Tennismodel1612.update Player1WonSet
                            |> Tuple.first
                            |> .setstowin
                            |> Expect.equal
                                (PlayerTwoLost Three)

             , test "if Player2 wins 1 set" <|
                \() ->
                    let
                        mdl =
                            Model (MatchInProgress { player1UpToThree = Three, player2UpToThree = Three })
                        --progress p model = Tennismodel.update p model |> Tuple.first
                    in
                        mdl
                            |> Tennismodel1612.update Player2WonSet
                            |> Tuple.first
                            |> .setstowin
                            |> Expect.equal
                                (MatchInProgress { player1UpToThree = Three, player2UpToThree = Two })

            , test "if Player2 wins 2 sets" <|
                \() ->
                    let
                        mdl =
                            Model (MatchInProgress { player1UpToThree = Three, player2UpToThree = Two })
                        --progress p model = Tennismodel.update p model |> Tuple.first
                    in
                        mdl
                            |> Tennismodel1612.update Player2WonSet
                            |> Tuple.first
                            |> .setstowin
                            |> Expect.equal
                                (MatchInProgress { player1UpToThree = Three, player2UpToThree = One })

            , test "if Player2 wins 3 sets" <|
                \() ->
                    let
                        mdl =
                            Model (MatchInProgress { player1UpToThree = Three, player2UpToThree = One })
                        --progress p model = Tennismodel.update p model |> Tuple.first
                    in
                        mdl
                            |> Tennismodel1612.update Player2WonSet
                            |> Tuple.first
                            |> .setstowin
                            |> Expect.equal
                                (PlayerOneLost Three)

            , test "if Player1 wins three sets" <|
                \() ->
                    let
                        mdl =
                            Model (MatchInProgress { player1UpToThree = One, player2UpToThree = Three })
                    in
                        mdl
                            |> List.foldl (\msg model -> update msg model |> Tuple.first) mdl
                            |> .setstowin
                            |> Expect.equal
                                (PlayerTwoLost Three) -}
            ]
        ]
