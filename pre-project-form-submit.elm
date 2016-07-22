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
  { myScore : Int
    ,myQuestion1 : String
    ,myAnswer1 : String
    ,myAnswer2 : String
    ,myAnswer3 : String
    ,myAnswer4 : String
    ,myQuestion2 : String
    ,myAnswer21 : String
    ,myAnswer22 : String
  }
  

init :  (Model, Cmd Msg)
init =
  (Model 0 "Do you have a Product Owner?" "Fully agree" "Agree" "Neutral" "Don't agree" "Do you have a Scrum Master?" "Yes" "No", Cmd.none)


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
      , input [ type' "radio", name "myChoice1", onClick (Questionanswered 1 1)] []
      , text (model.myAnswer2) 
      , input [ type' "radio", name "myChoice1", value "2"] []
      , text (model.myAnswer3) 
      , input [ type' "radio", name "myChoice1", value "1"] []
      , text (model.myAnswer4) 
      , input [ type' "radio", name "myChoice1", value "0"] []
      , text (model.myAnswer4) 
      , br [] []
      , button[ onClick Send ] [ text "Send" ]
      , br [] []
      , text (toString model.myScore) 
      ]



--UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        Questionanswered  questionid answerid ->
            ({ model | myScore = model.myScore + answerid }, Cmd.none )
        Send->
            (model, Cmd.none )
        

--SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.none
