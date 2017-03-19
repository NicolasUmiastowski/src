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
      List.append ((hd,nxt) :: [])
        (tuplesfromlist (nxt :: tl))
-- ***refactoring
-- (hd,nxt) :: tuplesfromlist (nxt :: tl)
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








     




























 
