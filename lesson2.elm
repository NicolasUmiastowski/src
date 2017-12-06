module Lessons.Lesson2 exposing (..)

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

type alias Model =
   {quantity : Int
   ,price : Int}


initialModel : (Model, Cmd Msg)
initialModel =
   ({quantity = 0
   ,price = 2},Cmd.none)

type Msg = Sendquantity String | Sendprice String




updateModel : Msg -> Model -> (Model, Cmd Msg)
updateModel msg model =
 case msg of
  Sendquantity quantity ->
    let
        quantity_ = Result.withDefault 0 (String.toInt quantity)
    in
        ({model |  quantity = quantity_  }, Cmd.none)
 
  Sendprice price ->
   let
        price_ = Result.withDefault 0 (String.toInt price)
    in
        ({model | price = price_ }, Cmd.none)


viewModel : Model -> Html Msg
viewModel model =
  div [ ]
   [Html.h1 [title "Promotion 3 pour le prix de 2"]
     [text (" le prix total est de "
            ++ toString (totalPackPrice model.quantity model.price))
     ,br [ ] [ ]
     ,input
      [type_ "Quantity"
     ,placeholder "Veuillez saisir votre quantité !!!"
     ,onInput Sendquantity]
     [ ]

     ,br [ ] [ ]
     ,input
      [type_ "Price"
     ,placeholder "Veuillez saisir le prix"
     ,onInput Sendprice]
     [ ]
   ]
 ]
