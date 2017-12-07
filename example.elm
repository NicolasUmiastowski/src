module Lessons.Lesson3 exposing (..)

import Html exposing (Html, Attribute, text, div, input, br)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)

main : Program Never Model Msg
main =
 Html.program
  {init= initialModel
  ,view=viewModel
  ,update=updateModel
  ,subscriptions=(\_ -> Sub.none)
  }

promocodes : List {promocode : String, amount : Float}
promocodes =
  [{promocode = "abc", amount = 0.2}
  ,{promocode = "def", amount = 0.3}
  ,{promocode = "ghi", amount = 0.35}
  ]

totalPackPrice : Int -> Int -> Int
totalPackPrice quantity price =
 if quantity > 0 && price > 0 && not (isNaN (toFloat quantity))
                 && quantity <=(2^32-1) then
   let
     numberOfPacks = Debug.log "number of packs line 22" (quantity // 3)
     numberOfNotPacked = rem quantity 3
     paidQuantity = numberOfPacks * 2 + numberOfNotPacked
   in
     price * paidQuantity
 else
     0

pricereduced : Int -> String -> Float
pricereduced totalprice promocode =
 let 
  amount_ = List.filter (\x -> x.promocode == promocode) promocodes
 in
  case amount_ of
   [a] ->
    (toFloat totalprice) * a.amount
   _ ->
     toFloat totalprice
             


type alias Model =
   {quantity : Int
   ,price : Int
   ,promocode : String
   }


initialModel : (Model, Cmd Msg)
initialModel =
   ({quantity = 0
   ,price = 2
   , promocode = ""
    },Cmd.none)

type Msg = Sendquantity String 
        | Sendprice String
        | Sendpromo String




updateModel : Msg -> Model -> (Model, Cmd Msg)
updateModel msg model =
 case msg of
  Sendquantity quantity ->
    let
        quantity_ = Result.withDefault 0 (String.toInt quantity)
        totalPackPrice_ = totalPackPrice quantity_ model.price
    in
        ({model |  quantity = quantity_ }, Cmd.none)

  Sendprice price ->
   let
        price_ = Result.withDefault 0 (String.toInt price)
        totalPackPrice_ = totalPackPrice model.quantity price_
    in
        ({model | price = price_ }, Cmd.none)

  Sendpromo codepromo ->
    ({model | promocode = codepromo  }, Cmd.none)


viewModel : Model -> Html Msg
viewModel model =
 let 
   totalprice = totalPackPrice model.quantity model.price
   reducedprice = pricereduced totalprice model.promocode
 in
    div [ ]
     [Html.h1 [title "Promotion 3 pour le prix de 2"]
       [text (" le prix total est de " ++ toString totalprice)
       , br [] []
       , text (" le prix après réduction est de "
              ++ toString reducedprice)
       ,br [ ] [ ]
       ,input
        [type_ "Quantity"
       ,placeholder "Veuillez saisir votre quantité"
       ,onInput Sendquantity]
       [ ]

       ,br [ ] [ ]
       ,input
        [type_ "Price"
       ,placeholder "Veuillez saisir le prix"
       ,onInput Sendprice]
       [ ]

      ,br [ ] [ ]
       ,input
        [type_ "Promo"
       ,placeholder "Veuillez saisir le code promo"
       ,onInput Sendpromo]
       [ ]
     ]
   ]
