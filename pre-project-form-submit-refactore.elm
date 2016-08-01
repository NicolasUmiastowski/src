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
    ,answerScore : List Int
    ,myTotalScore : Int
    ,myQuestion1 : String
    ,myQuestion2 : String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model Dict.empty [3, 2, 1, 0] 0 "Is the business co-located with the developers?" "Is the scope flexible?", Cmd.none)

calculateTotalScore : Dict comparable number -> number
calculateTotalScore scorelist = Dict.foldl (\_ v sum -> v + sum) 0 scorelist


--MESSAGES
type Msg = 
    QuestionAnswered Int Int

--VIEW
view : { a | answerScore : List Int } -> Html Msg
view model =
  div []
        (List.map createAnswerButtons model.answerScore)
      
     {- , br [] []
      , text <| let totalScore = List.sum model.myScoreList
            in if totalScore == 100 then "bravo"
            else if totalScore >= 75 then "not so bad"-}
       

createAnswerButtons : Int -> Html Msg
createAnswerButtons valueOfTheScore = 
    div[]
    [ div[] [text (toString valueOfTheScore)] 
    , input [ type' "radio", name ("myChoice3"), onCheck (\_ -> QuestionAnswered 2 valueOfTheScore)] []
    ]
--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of 
        QuestionAnswered  questionId answerScore ->
          let 
            newScoreList = Dict.insert questionId answerScore model.myScoreList
        
          in 
          ({ model |  myScoreList = newScoreList }, Cmd.none )

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
