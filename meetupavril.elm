module Meetupavril exposing (..)

import Html exposing (text, div, br)
import List exposing (length, isEmpty, concat, concatMap)

main : Html.Html a
main =
  div []
  [
    --text <| toString <| tasklist
    br [] []
    , text ("Feature = " ++ toString (totalfunction [(1,2),(2,3),(3,4),(4,5)]))
    ]

pathlist : List (Int, Int)
pathlist = [(1,2),(2,3),(3,0),(2,4),(3,4),(4,5)]


totalfunction: List (Int, Int) -> List (Int, Int)
totalfunction pathlist = 
  (removeshortcut pathlist)
  |> insertshortcuts  (valuestoreplace pathlist  (removeshortcut pathlist) [] )

removeshortcut : List (Int, Int) -> List (Int, Int)
removeshortcut pathlist = 
  case pathlist of
    [] -> []
    hd :: [] -> []
    (a,b) :: (c,d) :: tl ->
      List.append 
        (removeshortcut tl)
        (if b == d then
            (a,b) :: []
         else
          []
        )
       
valuestoreplace : 
  List (Int, Int) 
  -> List (Int, Int) 
  -> List (Int, Int) 
  -> List (Int, Int)

valuestoreplace pathlist shortvalue accum = 
  case shortvalue of
    (a,b) :: (e,f) :: tl ->
      valuestoreplace pathlist ((e,f) :: tl)
        (accum ++ 
          (List.filter (\(c,d) ->  
             c >= b  || d <= a  ) pathlist))
    (e,f) :: [] ->
      List.filter (\(c,d) ->  
             (c < e || c >= f )) accum
    _ ->
      accum


insertshortcuts : List ( Int, Int ) -> List ( Int, Int ) -> List ( Int, Int )
insertshortcuts pathlist1 pathlist2 = 
  List.sort (List.append pathlist1 pathlist2)









     




























 
