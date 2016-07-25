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
  { myTotalScore : List Int
    ,myQuestion1 : String
    ,myAnswer1 : String
    ,myAnswer2 : String
    ,myAnswer3 : String
    ,myAnswer4 : String
    ,myQuestion2 : String
  }
 

init :  (Model, Cmd Msg)
init =
  (Model [] "Is the business co-located with the developers?" "Fully agree" "Agree" "Neutral" "Don't agree" "Is the scope flexible?", Cmd.none)


--MESSAGES
type Msg 
    = Questionanswered Int Int

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
      , button[] [ text "Send" ]
      , br [] []
      , br [] []
      , text ("Total score: " ++  toString(List.sum model.myTotalScore))
      , br [] []
      , text <| let totalScore = List.sum model.myTotalScore
            in if totalScore == 100 then "bravo"
            else if totalScore >= 75 then "not so bad"
            else "very bad"
      ]



--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        Questionanswered  1 answerid ->
            ({ model | myTotalScore = [answerid] }, Cmd.none )
        Questionanswered  2 answerid ->
            ({ model | myTotalScore = model.myTotalScore ++ [answerid] }, Cmd.none )
        Questionanswered _  _ -> (model, Cmd.none)

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
