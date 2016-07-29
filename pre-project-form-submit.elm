import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick, onCheck)
import Dict exposing (..)


main : Program Never
main =
  Html.program
    { init = init
    , view = view
    , subscriptions = subscriptions
    , update = update
    }


  -- MODEL


type alias Model =
  { myScoreList : Dict Int Int
    ,myTotalScore : Int
    ,myQuestion1 : String
    ,myAnswer1 : String
    ,myAnswer2 : String
    ,myAnswer3 : String
    ,myAnswer4 : String
    ,myQuestion2 : String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model Dict.empty 0 "Is the business co-located with the developers?" "Fully agree" "Agree" "Neutral" "Don't agree" "Is the scope flexible?", Cmd.none)

calculateTotalScore : Dict comparable number -> number
calculateTotalScore scorelist = Dict.foldl (\_ v sum -> v + sum) 0 scorelist

--MESSAGES
type Msg = 
    QuestionAnswered Int Int

--VIEW
view : Model -> Html Msg
view model =
  div []
      [div [] [ text (model.myQuestion1) ]
      , text (model.myAnswer1) 
      , input [ type' "radio", name "myChoice1", onCheck (\_ -> QuestionAnswered 1 4)] []
      , text (model.myAnswer2) 
      , input [ type' "radio", name "myChoice1", onCheck (\_ -> QuestionAnswered 1 3)] []
      , text (model.myAnswer3) 
      , input [ type' "radio", name "myChoice1", onCheck (\_ -> QuestionAnswered 1 0)] []
      , text (model.myAnswer4) 
      , input [ type' "radio", name "myChoice1", onCheck (\_ -> QuestionAnswered 1 -1)] []
      , br [] []
      , text (model.myQuestion2)
      , br [] []
      , text (model.myAnswer1) 
      , input [ type' "radio", name "myChoice2", onCheck (\_ -> QuestionAnswered 2 4)] []
      , text (model.myAnswer2) 
      , input [ type' "radio", name "myChoice2", onCheck (\_ -> QuestionAnswered 2 3)] []
      , text (model.myAnswer3) 
      , input [ type' "radio", name "myChoice2", onCheck (\_ -> QuestionAnswered 2 0)] []
      , text (model.myAnswer4) 
      , input [ type' "radio", name "myChoice2", onCheck (\_ -> QuestionAnswered 2 -1)] []
      , br [] []
      , button [] [ text "Send"]
      , br [] []
      , br [] []
      , if not (Dict.isEmpty model.myScoreList) then 
            text <| "Total score: " ++    (toString <| calculateTotalScore model.myScoreList)
          else 
            text ""
     {- , br [] []
      , text <| let totalScore = List.sum model.myScoreList
            in if totalScore == 100 then "bravo"
            else if totalScore >= 75 then "not so bad"
            else "very bad"-}
      ]

     

--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of 
        QuestionAnswered  questionId answerId ->
          let 
            newScoreList = Dict.insert questionId answerId model.myScoreList
        
          in 
          ({ model |  myScoreList = newScoreList }, Cmd.none )

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
