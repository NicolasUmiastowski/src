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
    , br [] []
    , text ("Feature = " ++ toString (feature_ (feature tasklist) ))
    --, br [] []
    --, text ("Feature2 = " ++ toString feature2)
    --, br [] []
    --, text ("Feature = " ++ toString (feature tasklist))

    ]

tasksnumber : Int
tasksnumber = List.length tasklist

recursive : Int -> Int
recursive x = 
  if x < 16 then
    recursive (x^2)
  else 
    x


newslist : List a
newslist = []



tasklist : List (Int, Int)
tasklist = [(1,2), (2,3),(3,0), (4,5), (3,0)]

feature : List ( number, number1 ) -> List (List ( number, number1 ))
feature tasklist = 
 
 List.map (\tuple -> 
  if tuple /= (3,0) then
    tuple ::  newslist
      
  else 
    newslist) tasklist

feature_ : List (List a) -> List (List a)
feature_ x = 
  case x of 
    hd :: nxt :: tl ->
      if nxt /= [] then
        (List.append hd nxt) :: tl
      else 
        hd :: nxt :: tl
    _ ->
      x


  {-(feature 
   (List.map (\tuple -> 
            if (Tuple.second tuple) /= 0 then
              tuple 
            else 
              (0,0) ) tasklist))  :: []-}
          

            
 
  
--featurestories : List (List ( Int, Int )) -> List (List Int)
--featurestories = 
--  List.map (List.map Tuple.first)

--featurelength : List (List Int) -> List Int
--featurelength = 
--  List.map List.length

{-prenumber : List ( Int, Int ) -> List Int
prenumber tasklist = 
  List.concat
    (List.Extra.group (List.sort (List.map (\tuple -> Tuple.second tuple) tasklist))
    |> List.filter (\listoftuple2nd-> List.length listoftuple2nd > 1)
    )
  
multiplepre : List (Int, Int) -> List ( Int, Int )
multiplepre tasklist = 
  List.filter (\ tuple -> List.member (Tuple.second tuple) (prenumber tasklist) ) 
  tasklist -}


dependencieslist : List (Int, Int) -> List (List (Int, Int))
dependencieslist list_ = 
  List.filter (\sublist -> List.length sublist > 1) (
  List.Extra.groupWhile (\x y -> Tuple.second x == Tuple.second y) list_)

ordereddependencieslist : List (List (Int, Int)) -> List (List (Int, Int))
ordereddependencieslist x = 
  List.sortBy List.length x

prednumber : List a -> List Int -> List Int
prednumber x y = 
  (List.length x) :: y 

{-
prenumber : List (Int, Int) -> List Int
prenumber tasklist = 
 List.concat (
  List.Extra.group (List.sort (List.map (\tuple -> Tuple.second tuple) tasklist))
  |> List.filter (\listoftuple2nd-> List.length listoftuple2nd > 1)
  )

multiplepre : List ( Int , Int ) -> List ( Int , Int )
multiplepre tasklist = 
 List.filter (\ a -> List.member (Tuple.second a) (prenumber tasklist)) 
 tasklist






storypredecessor : List ( a1, comparable ) -> List comparable
storypredecessor featurestorieslist = 
 List.sort (List.map (\x -> Tuple.second x) featurestorieslist)

mytest : List a -> List (List a)
mytest z = 
  List.Extra.group z

mytest2 : List (List a) -> List (List a)
mytest2 z = 
  List.filter (\x-> List.length x > 1) z



  
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
 List.concat <| List.map (\a -> (pre_ a)) (pre_ a)




  -}

 
