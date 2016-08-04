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
    ,listOfAnswers : List {myText: String, myValue: Int}
    ,listOfQuestions :  List String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model Dict.empty [{myText = "Fully agree", myValue = 3}, {myText = "Agree", myValue = 2}, {myText = "Neutral", myValue = 1}, {myText = "Disagree", myValue=0}]  ["Is the business co-located with the developers?", "Is the scope flexible?"], Cmd.none)

--MESSAGES
type Msg = 
    QuestionAnswered Int Int

--VIEW
view
    : { b
          | listOfAnswers : List { a | myText : String, myValue : Int }
          , listOfQuestions : List String
          , myScoreList : Dict comparable number
    }
    -> Html Msg
view model =
  let
    helperForDisplayListOfQuestions answers questions =
       (text questions :: List.map createAnswerButtons answers) 

    displayListOfQuestions = 
         List.concatMap (helperForDisplayListOfQuestions model.listOfAnswers) model.listOfQuestions

    myTotalScore = List.sum <| Dict.values <| model.myScoreList

    scoreMessage =
      if myTotalScore  == 3 then "Bravo"
      else 
        if myTotalScore  <= 2 then "not so bad"
        else ""
  in
    div []
    <|displayListOfQuestions ++
      [ br [] []
      , text ("Your score is: " ++ toString myTotalScore)
      , br [] []
      , text scoreMessage
      ] 

myQuestionsDiv : String -> Html a
myQuestionsDiv listOfQuestions = 
  div []
  [ text <| listOfQuestions]

createAnswerButtons : { a | myText : String, myValue : Int } -> Html Msg
createAnswerButtons answersPairs = 
    div[]
    [ text (answersPairs.myText)
    , input [ type' "radio", name ("myChoice3"), onCheck (\_ -> QuestionAnswered 2 answersPairs.myValue)] []
    ]
--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of 
        QuestionAnswered  questionId answersPairs ->
          let 
            newScoreList = Dict.insert questionId answersPairs model.myScoreList
        
          in 
          ({ model |  myScoreList = newScoreList }, Cmd.none )

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
