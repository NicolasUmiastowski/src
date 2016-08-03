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
    ,answerScore : List {myText: String, myValue: Int}
    ,myTotalScore : Int
    ,myQuestion1 : String
    ,myQuestion2 : String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model Dict.empty [{myText = "Fully agree", myValue = 3}, {myText = "Agree", myValue = 2}, {myText = "Neutral", myValue = 1}, {myText = "Disagree", myValue=0}] 0 "Is the business co-located with the developers?" "Is the scope flexible?", Cmd.none)

calculateTotalScore : Dict comparable number -> number
calculateTotalScore scorelist = Dict.foldl (\_ v sum -> v + sum) 0 scorelist


--MESSAGES
type Msg = 
    QuestionAnswered Int Int

--VIEW
{-view model =
  div []
       ((List.map createAnswerButtons model.answerScore) ++
      [br [] []
      , text <| let totalScore = List.sum model.myScoreList
            in if totalScore == 100 then "bravo"
            else if totalScore >= 75 then "not so bad"
            else ""])  -}

view
    : { b
          | answerScore : List { a | myText : String, myValue : Int }
          , myScoreList : Dict comparable number
    }
    -> Html Msg
view model =
  let
    answerButtons =
      List.map createAnswerButtons model.answerScore
      
    scoreMessage =
      let total = List.sum <| Dict.values <| model.myScoreList in
      if total == 3 then "Bravo"
      else 
        if total <= 2 then "not so bad"
        else ""
  in
    div []
    <|answerButtons ++
      [ br [] []
      , text scoreMessage
      ]





createAnswerButtons : { a | myText : String, myValue : Int } -> Html Msg
createAnswerButtons valueOfTheScore = 
    div[]
    [ text (valueOfTheScore.myText)
    , input [ type' "radio", name ("myChoice3"), onCheck (\_ -> QuestionAnswered 2 valueOfTheScore.myValue)] []
    ]
--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of 
        QuestionAnswered  questionId valueOfTheScore ->
          let 
            newScoreList = Dict.insert questionId valueOfTheScore model.myScoreList
        
          in 
          ({ model |  myScoreList = newScoreList }, Cmd.none )

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none