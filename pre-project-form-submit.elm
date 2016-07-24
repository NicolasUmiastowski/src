import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)

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
  { myTotalScore : Int
    ,myScore1 : Int
    ,myScore2 : Int
    ,myQuestion1 : String
    ,myAnswer1 : String
    ,myAnswer2 : String
    ,myAnswer3 : String
    ,myAnswer4 : String
    ,myQuestion2 : String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model 0 0 0 "Is the business co-located with the developers?" "Fully agree" "Agree" "Neutral" "Don't agree" "Is the scope flexible?", Cmd.none)


--MESSAGES
type Msg 
    = Questionanswered Int Int 
    | Send

--VIEW
view : Model -> Html Msg
view model =
  div []
      [div [] [ text (model.myQuestion1) ]
      , text (model.myAnswer1) 
      , input [ type' "radio", name "myChoice1", onClick (Questionanswered 1 4)] []
      , text (model.myAnswer2) 
      , input [ type' "radio", name "myChoice1", onClick (Questionanswered 1 3)] []
      , text (model.myAnswer3) 
      , input [ type' "radio", name "myChoice1", onClick (Questionanswered 1 0)] []
      , text (model.myAnswer4) 
      , input [ type' "radio", name "myChoice1", onClick (Questionanswered 1 -1)] []
      , br [] []
      , text (model.myQuestion2)
      , br [] []
      , text (model.myAnswer1) 
      , input [ type' "radio", name "myChoice2", onClick (Questionanswered 2 4)] []
      , text (model.myAnswer2) 
      , input [ type' "radio", name "myChoice2", onClick (Questionanswered 2 3)] []
      , text (model.myAnswer3) 
      , input [ type' "radio", name "myChoice2", onClick (Questionanswered 2 0)] []
      , text (model.myAnswer4) 
      , input [ type' "radio", name "myChoice2", onClick (Questionanswered 2 -1)] []
      , br [] []
      , button[ onClick Send ] [ text "Send" ]
      , br [] []
      , text ("Score question 1: " ++ toString model.myScore1)
      , br [] []
      , text ("Score question 2: " ++ toString model.myScore2) 
      , br [] []
      , text ("Total score: " ++  toString model.myTotalScore)
      , br [] []
      , text (if model.myTotalScore == 100 then "You have all necessary criterias to go Agile" else if ((model.myTotalScore >= 75) && (model.myTotalScore < 100)) then "You are lacking a small bunch of criterias to go agile" else "bouh")
      ]



--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        Questionanswered  1 answerid ->
            ({ model | myScore1 = answerid }, Cmd.none )
        Questionanswered  2 answerid ->
            ({ model | myScore2 = answerid }, Cmd.none )
        Questionanswered _  _ -> (model, Cmd.none)
        Send  ->
            ({ model | myTotalScore = ((model.myScore1 + model.myScore2) // 8) * 100 }, Cmd.none )

        

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
