module Prolog exposing (..)

import Html exposing (text, div, br)
import List exposing (..)
import List.Extra exposing (..)


--import String exposing (toInt)
--import Debug
--import String exposing (join,toInt)


main : Html.Html a
main =
    div []
        [ text <| toString <| tasklist
        , br [] []
        , text ("Tasks number = " ++ toString tasksnumber)
          --, br [] []
          --, text ("Feature = " ++ toString feature)
          --, br [] []
          --, text ("Feature2 = " ++ toString feature2)
        , br [] []
        , text ("Fibonacci = " ++ toString (fibonacci [ 0, 1 ]))
        , br [] []
        , text ("Fib= " ++ toString (fib))
        ]



--fibolist : List number
--fibolist = [0,1,2, 3]


xxx : List number
xxx =
    [ 0, 1 ]


fibonacci_ : List number -> Maybe (List number)
fibonacci_ fibolist =
    if (List.length fibolist < 15) then
        let
            lastlistelm =
                Maybe.withDefault 0 (List.Extra.last fibolist)

            beforelastlistelm =
                Maybe.withDefault 0 (List.Extra.getAt ((List.length fibolist) - 2) fibolist)
        in
            Just
                (List.singleton (lastlistelm + beforelastlistelm)
                    |> List.append fibolist
                )
    else
        Nothing


fibonacci : List Int -> List Int
fibonacci initlist =
    List.Extra.unique (List.concat (List.Extra.iterate fibonacci_ initlist))


fib : List Int
fib =
    fib_ [ 1, 0 ]


fib_ : List Int -> List Int
fib_ ints =
    case ints of
        hd :: nxt :: tl ->
            if 10 <= List.length ints then
                ints
            else
                fib_ <| (hd + nxt) :: ints

        _ ->
            ints



{-
   **********************************
   fibonacci : Int -> List Int
   fibonacci n =
       let
           iterator : ( Int, Int, Int ) -> Maybe ( Int, Int, Int )
           iterator ( i, a, b ) =
               if i < n then
                   Just ( i + 1, b, a + b )
               else
                   Nothing
       in
           ( 1, 0, 1 )
               |> List.Extra.iterate iterator
               |> List.map (\( i, a, b ) -> b)

-}


tasklist : List ( Int, Int )
tasklist =
    [ ( 1, 4 ), ( 4, 5 ), ( 4, 8 ), ( 5, 8 ), ( 7, 8 ), ( 8, 9 ) ]


tasksnumber : Int
tasksnumber =
    List.length tasklist



{- feature : List (Int, Int) -> List (List ( Int, Int ))
   feature valueslist =
     List.filter (\
         (a, b)  -> Tuple.second (a, b) == (Tuple.first (a, b) + 1) || b == 0)
          valueslist
     |> List.sort
     |> List.Extra.groupWhileTransitively  (\x y -> Tuple.second x == Tuple.first y)
-}


feature : List ( number, number1 ) -> List (List ( number, number1 ))
feature featurelist =
    List.Extra.groupsOfVarying (indexfunction featurelist) featurelist


emptylist : List a
emptylist =
    []


filling : List ( a, number ) -> List (List ( a, number ))
filling featurelist =
    (List.Extra.groupWhileTransitively
        (\x y -> Tuple.second y == (Tuple.second x + 1) || Tuple.first y == Tuple.first x)
        featurelist
    )


indexfunction : List ( number, number1 ) -> List Int
indexfunction valuelist =
    List.Extra.findIndices (\tuple -> Tuple.second tuple == 0) valuelist


dependencieslist : List ( Int, Int ) -> List (List ( Int, Int ))
dependencieslist list_ =
    List.filter (\sublist -> List.length sublist > 1)
        (List.Extra.groupWhile (\x y -> Tuple.second x == Tuple.second y) list_)


ordereddependencieslist : List (List ( Int, Int )) -> List (List ( Int, Int ))
ordereddependencieslist x =
    List.sortBy List.length x


prednumber : List a -> List Int -> List Int
prednumber x y =
    (List.length x) :: y
