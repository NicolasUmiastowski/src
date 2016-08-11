module Preprojectform exposing (Model,init,view,update,Msg)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick, onCheck)
import Dict exposing (..)
import Debug




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
    ,listOfAnswers : List { myText: String, myValue: Int}
    ,listOfQuestions : List { questionId: Int, questionText : String }
  }
 

init :  (Model, Cmd Msg)
init =
  (Model Dict.empty [{myText = "Fuly agree", myValue = 3}, {myText = "Agree", myValue = 2}, {myText = "Neutral", myValue = 1}, {myText = "Disagree", myValue=0}]  [{questionId = 1, questionText = "Is the business co-located with the developers?"}, {questionId = 2, questionText = "Is the scope flexible?"}], Cmd.none)

--MESSAGES
type Msg = 
    QuestionAnswered Int Int

--VIEW
view
    : Model
    -> Html Msg

view model =
  let
   --List.concatMap (\x -> text x :: List.map createAnswerButtons model.listOfAnswers) model.listOfQuestions

    displayListOfQuestions = List.concatMap  (\question ->  text question.questionText :: List.map (createAnswerButtons question.questionId) model.listOfAnswers) model.listOfQuestions
    
    maxPointsPossible : Int
    maxPointsPossible = List.length model.listOfQuestions * 3

    myCurrentNumberofPoints = List.sum <| Dict.values <| model.myScoreList
    _ = Debug.log "My current number of Points" myCurrentNumberofPoints
    myTotalScore : Int
    myTotalScore = (myCurrentNumberofPoints * 100) // maxPointsPossible
  

    scoreMessage =
      if myTotalScore  >= 75 then "Bravo"
      else 
        if myTotalScore  < 75 then "not so bad"
        else ""
  in
    div []
    <|displayListOfQuestions ++
      [ br [] []
      , text ("Your score is: " ++ toString myTotalScore ++ "%")
      , br [] []
      , text scoreMessage
      ] 

createAnswerButtons : Int -> { a | myText : String, myValue : Int } -> Html Msg
createAnswerButtons questionId answersPair = 
    div[]
    [ text (answersPair.myText)
    , input [ type' "radio", name ("myChoice" ++ toString questionId), onCheck (\_ -> QuestionAnswered questionId answersPair.myValue)] []
    ]
--UPDATE

update
    : Msg
    -> { a | myScoreList : Dict Int Int }
    -> ( { a | myScoreList : Dict Int Int }, Cmd b )
update msg model = 
    case msg of 
        QuestionAnswered  questionId answersId ->
          let 
            newScoreList = Dict.insert questionId answersId model.myScoreList
     
          in 
          ({ model |  myScoreList = newScoreList }, Cmd.none )

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
