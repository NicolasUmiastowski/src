module Prolog exposing (..)

import Html exposing (text, div, br)
import List exposing (length, isEmpty, concat, concatMap)
import List.Extra exposing (groupWhileTransitively )
--import String exposing (toInt)
--import Debug
--import String exposing (join,toInt)


main : Html.Html a
main =
  div []
  [
    text <| toString <| tasklist
    , br [] []
    , text ("Tasks number = " ++ toString tasksnumber)
    --, br [] []
    --, text ("Feature = " ++ toString feature)
    --, br [] []
    --, text ("Feature2 = " ++ toString feature2)
    , br [] []
    , text ("Feature = " ++ toString (feature tasklist))

    ]



tasklist : List (Int, Int)
tasklist = [(1,4),(4,5), (4,8), (5,8), (7,8), (8,9)]

tasksnumber : Int
tasksnumber = List.length tasklist

feature : List (Int, Int) -> List (List ( Int, Int ))
feature valueslist = 
  List.filter (\ 
      (a, b)  -> Tuple.second (a, b) == (Tuple.first (a, b) + 1) || b == 0)
       valueslist
  |> List.sort
  |> List.Extra.groupWhileTransitively  (\x y -> Tuple.second x == Tuple.first y)

featurestories : List (List ( Int, Int )) -> List (List Int)
featurestories = 
  List.map (List.map Tuple.first)

featurelength : List (List Int) -> List Int
featurelength = 
  List.map List.length


storypredecessor : List ( a1, comparable ) -> List comparable
storypredecessor featurestorieslist = 
 List.sort (List.map (\x -> Tuple.second x) featurestorieslist)

mytest : List a -> List (List a)
mytest z = 
  List.Extra.group z

mytest2 : List (List a) -> List (List a)
mytest2 z = 
  List.filter (\x-> List.length x > 1) z

mytest3 : List (Int, Int) -> List (List Int)
mytest3 tasklist = 
  List.Extra.group (List.sort (List.map (\x -> Tuple.second x) tasklist))
  |> List.filter (\x-> List.length x > 1)

{-
mytest3 : List (Int, Int) -> List (List Int)
mytest3 tasklist = 
  List.filter (\x-> List.length x > 1) (List.Extra.group (List.sort (List.map (\x -> Tuple.second x) tasklist)))
-}

--storypred3 [(1,2), (2,3)] ->  [2,6] = [(1,2)]
{-storypred3 : List ( a1, number ) -> List ( a1, number )
storypred3 listoftuples = 
 List.filter (\ a -> List.member (Tuple.second a) [2,6]) 
 listoftuples


storypred4 listoftuples = 
  List.filter (\ a -> List.member (Tuple.second a) 
    (storypredecessor listoftuples) )
 listoftuples -}


  --[(1,2), (2,3), (4,3)] -> [(2,3), (4,3)]

{-featurestories : List (List ( Int, Int )) -> List (List Int)
featurestories listoflists = 
  List.map (List.map Tuple.first) listoflists

featurelength : List (List Int) -> List Int
featurelength listoflists = 
  List.map List.length listoflists -}

{-featurestoriestail : List (List (Int, Int)) -> List (List (Int, Int))
featurestoriestail x = Maybe.withDefault [[]] (List.tail x)

featurestorieshead : List (List ( Int, Int )) -> List ( Int, Int )
featurestorieshead x =
  Maybe.withDefault [(0,0)] (List.head
  (
  featurestoriestail x
  ))

featurestoriesrecursive x = List.map  (featurestorieshead x) x
-}
--feature2 =  List.filter (\[(a,b)] -> Tuple.second (a,b) > 0) (feature tasklist)




{-feature : List (Int, Int)
feature = 
  List.filter (\ 
      (a, b)  -> Tuple.second (a, b) == (Tuple.first (a, b) + 1) )
       tasklist



feature2 : List ( Int, Int )
feature2 = 
 List.concatMap (\x ->
  List.filter (\(a,b) -> a == Tuple.second x || b == Tuple.first x) feature)
   feature
  |> List.sort -}


{-feature2 : List ( Int, Int )
feature2 = 
 List.concatMap (
   \x ->
   List.append [x] ( List.filter (\(a,b) -> a == Tuple.second x ) feature)
  )feature -}




{-feature3 : List (List ( Int, Int ))
feature3 = 
  List.filter (\x -> not (isEmpty x)) feature2

feature4 : List ( Int, Int )
feature4 = concat feature3-}
{-isok (a,b) x =
  if a == Tuple.second x then
    Just (a,b)
  else
    Nothing -}


{-feature4 = 
  if Tuple.second feature2 == Tuple.first feature3
   then -}

--feature3 = if (Tuple.second (feature2) == Tuple.first 


{- post : number -> number
post a =
  a + 1

pre : number -> number
pre a = post <| post <| post a -}



{-recursion a = List.map (\a->(post a)) (List.range 0 (pre a))

post_ : Int -> Int -> Int
post_ a b = 
  a + b
 
pre_ : Int -> List Int
pre_ a  = 
  a :: (List.append [post a] [pre a] )

pres_ : Int -> List Int
pres_ a = 
 List.concat <| List.map (\a -> (pre_ a)) (pre_ a) -}

 
