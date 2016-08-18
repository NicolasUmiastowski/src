module Preprojectform exposing (Model,init,view,update,Msg(..),myVariable,myTotalScore2)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick, onCheck)
import Dict exposing (..)
import Debug
-- import Debug




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
    ,scoreMessage : String
    ,errrorMessage : String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model Dict.empty [{myText = "Fully agree", myValue = 3}, {myText = "Agree", myValue = 2}, 
    {myText = "Neutral", myValue = 1}, {myText = "Disagree", myValue=0}]  [{questionId = 1, 
    questionText = "Is the business co-located with the developers?"}, 
    {questionId = 2, questionText = "Is the scope flexible?"}] "" "", Cmd.none)

--MESSAGES
type Msg = 
    QuestionAnswered Int Int
    | Send Int

--VIEW
view
    : Model
    -> Html Msg


view model =


  let
    displayListOfQuestions = List.concatMap  (\question ->  text question.questionText :: List.map (createAnswerButtons question.questionId) model.listOfAnswers) model.listOfQuestions
    
    maxPointsPossible : Int
    maxPointsPossible = List.length model.listOfQuestions * 3

    myCurrentNumberofPoints = List.sum <| Dict.values <| model.myScoreList
    
    myTotalScore3 =   myTotalScore2 myCurrentNumberofPoints maxPointsPossible
   

  
  in
    div []
    <|displayListOfQuestions ++
      [ br [] []
      , button [onClick (Send <| myTotalScore3 ) ] [text "Send"]
      , br [] []
      , br [] []
      , text model.scoreMessage
      , text model.errrorMessage
      ] 

myTotalScore2 : Int -> Int -> Int
myTotalScore2 points maxPoints = 
    (points*100) // maxPoints

myVariable : number
myVariable = 10

createAnswerButtons : Int -> { a | myText : String, myValue : Int } -> Html Msg
createAnswerButtons questionId answersPair = 
    div[]
    [ text (answersPair.myText)
    , input [ type' "radio", name ("myChoice" ++ toString questionId), onCheck (\_ -> QuestionAnswered questionId answersPair.myValue)] []
    ]
--UPDATE
update
    : Msg
    -> Model
    -> ( Model, Cmd b)

update msg model = 
    case msg of 
        QuestionAnswered  questionId answersId ->
          let 
            newScoreList = Dict.insert questionId answersId model.myScoreList
     
          in 
          ({ model |  myScoreList = Debug.log "myscorelist" newScoreList }, Cmd.none )
        
        Send finalScore ->
            let 
            myAnsweredQuestions = List.length <| Dict.values <| model.myScoreList
            newScoreMessage =
                if  (myAnsweredQuestions == 2 && finalScore  >= 75) then 
                    "Your score is " ++ toString (finalScore) ++ "% " ++ "Bravo"
                else 
                    if (myAnsweredQuestions == 2 && finalScore  < 75) then
                     "Your score is " ++ toString finalScore ++ "% " ++  "Not so bad"
                else ""
            newErrorMessage = 
                if ((List.length <| Dict.values <| model.myScoreList) < 2) then
                    "You must answer all questions!"
                else
                    ""
            in 
            ({ model | scoreMessage = newScoreMessage , errrorMessage = newErrorMessage }, Cmd.none )


--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none