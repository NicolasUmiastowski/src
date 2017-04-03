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

tasklist2 : List (Int, Int)
tasklist2 = [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]

fromlasttofirst : List (Int, Int) -> List (Int, Int)
fromlasttofirst tasklist2 = 
  case tasklist2 of
    (a,b) :: (c,d) :: tl ->
      List.append 
        (if b == c then
            (List.append ((a,b) :: []) ((c,d) :: []))
         else
          []
        )
        (fromlasttofirst tl)
    _ ->
      tasklist2


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


{-tuplesfromlist : List Int -> List (Int, Int)
tuplesfromlist intlist = 
  case intlist of
    [] ->
      []
    hd :: [] ->
      []
    hd :: nxt :: tl ->
      (hd,nxt) :: tuplesfromlist (nxt :: tl) -}

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








     




























 
