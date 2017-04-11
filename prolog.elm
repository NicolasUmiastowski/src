module Prolog exposing (..)

import Html exposing (text, div, br)
import List exposing (length, isEmpty, concat, concatMap)

main : Html.Html a
main =
  div []
  [
    text <| toString <| tasklist
    , br [] []
    , text ("Feature = " ++ toString (List.maximum [(5,8), (7,8), (8,9), (9,10)]))
    ]

pathlist : List (Int, Int)
pathlist = [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]

shortvalue : List (Int, Int) -> List (Int, Int)
shortvalue pathlist = 
  fromlasttofirst pathlist -- [(1,2),(2,3),(3,4),(4,5)]
  |> listfilter pathlist -- [(2,4)]


{-totalfunction : List (Int, Int) -> List (Int, Int)
totalfunction pathlist =  -- [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]
  shortvalue pathlist
  |> testnico pathlist --[(1,2),(2,4)]
  |> testnico2 pathlist --[(1,2),(2,4),(4,5)] -}
 
{-totalfunction : List (Int, Int) -> List (Int, Int)
totalfunction pathlist =  -- [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]
  shortvalue pathlist -- (2,4)
  |> shortpath (fromlasttofirst pathlist) --[(1,2),(2,4)]
  |> shortpath2 (shortvalue pathlist ) --[(1,2),(2,4),(4,5)]

-}

{-testnico : List ( Int, Int ) -> List ( Int, Int ) -> List ( Int, Int )
testnico = shortpath << fromlasttofirst

testnico2 : List ( Int, Int ) -> List ( Int, Int ) -> List ( Int, Int )
testnico2 = shortpath2 << shortvalue -}




fromlasttofirst : List (Int, Int) -> List (Int, Int)
fromlasttofirst pathlist = 
  case pathlist of
    [] -> []
    hd :: [] -> []
    (a,b) :: (c,d) :: tl ->
      List.append 
        (if b == c then
            (List.append ((a,b) :: []) ((c,d) :: []))
         else
          []
        )
        (fromlasttofirst tl)

replacetuple : x -> y -> (x,y) -> List (x, y)
replacetuple a b = 
  (\(c,d) -> 
        if (b == d) || (a == c) then
          []
        else
          (a,b) :: []
  )

replacetuple_ : x -> y -> (x,y) -> Maybe (x,y)
replacetuple_ a b = 
  (\(c,d) -> if (b == d) || (a == c) then
              Nothing
             else
              Just (a,b))

--shortpath : List ( Int, Int ) -> List ( Int, Int ) -> List ( Int, Int )
--shortpath pathlist shortvalue =
--    helper pathlist shortvalue []

shortpath : List (Int, Int) -> List (Int, Int) -> List (Int, Int) -> List (Int, Int)
shortpath pathlist shortvalue accum = 
  case pathlist of
    (a,b) :: tl ->
      shortpath tl shortvalue 
        (accum ++ (List.filterMap (replacetuple_ a b ) shortvalue))
       --(accum ++ (List.concatMap (replacetuple a b ) shortvalue))
    _ ->
      accum

shortpath2 : List (Int, Int) -> List (Int, Int) -> List (Int, Int)
shortpath2 shortvalue pathlist = 
  case pathlist of
    (a,b) :: tl ->
      tl
      |> shortpath2 shortvalue
      |> List.append (List.concatMap (\(c,d) ->
        (if (b == c) then
          (a,b) :: shortvalue
        else
          (a,b) :: []) ) shortvalue)
    [] ->
      []

listfilter : List (Int, Int) -> List (Int, Int) -> List (Int, Int)
listfilter pathlist filteredlist = 
  List.concat (List.map (\ (a,b) -> 
    List.filter (\ (c,d) -> b == d && a /= c ) pathlist ) filteredlist)



tasklist : List (Int, Int)
tasklist = [(1,2), (2,3), (2,4), (3,0)
            ,(3,4), (2,4), (4,5), (5,6), (6,0)
            ,(5,8), (7,8), (8,9), (9,10), (10,0)]

tupleswithzero : List (Int, Int) -> List (Int, Int)
tupleswithzero intlist = 
 List.filter (\(a,b) -> b == 0) intlist

tuplestolist : List (Int, Int) -> List Int
tuplestolist intlist = 
  List.map (\(a,b) -> a) intlist

tuplesfromlist : List Int -> List (Int, Int)
tuplesfromlist intlist = 
  case intlist of
    hd :: nxt :: tl ->
      



      tuplesfromlist (nxt :: tl)
    

    _ ->
      []


addinitialtuple : List (Int, Int) -> List (Int, Int)
addinitialtuple tasklist = 
  case tasklist of
    (a,b) :: tl ->
      (0,a) :: tasklist
    _ ->
      []

splitlist
    : List ( Int, Int )
    -> List (Int, Int)
    -> List (List ( Int, Int ))
splitlist reflist filterlist = 
  List.map (\(a,b) -> 
    List.filter
      (\(c,d) -> (c < 
        b) && (c >= 
        a) && d /= 0) 
      reflist) filterlist








     




























 
