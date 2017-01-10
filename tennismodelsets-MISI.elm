module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onCheck)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = \_ model -> model ! []
        , subscriptions = \_ -> Sub.none
        }


type GamesUpToFive
    = Zero
    | One
    | Two
    | Three
    | Four
    | Five


type Games
    = MaxFive GamesUpToFive
    | Six


type CurrentSet
    = UpToFive
        { player1 : GamesUpToFive
        , player2 : GamesUpToFive
        }
    | SixtoFive Player
    | TieBreak
    | Lost { loosergameswon : Games }


type Player
    = PlayerOne
    | PlayerTwo


type alias FirstSet =
    { setwinner : Player
    , looserscore : Games
    }


type alias SecondSet =
    { secondsetwinner : Player
    , alreadywonfirst : Bool
    , secondlooserscores : ( Games, Games )
    , thirdset : Maybe ThirdSet
    }


type alias ThirdSet =
    { wonthirdandsecond : Bool
    , thirdsetlooserscores : ( Games, Games, Games )
    , fourthset : Maybe FourthSet
    }


type alias FourthSet =
    { foursthsetlooserscores : ( Games, Games, Games, Games )
    }


type Previous
    = PlayedOne FirstSet
    | PlayedMore SecondSet


type alias Model =
    { previous : Maybe (Previous)
    , current : CurrentSet
    }


type Msg
    = PlayerOneWonPoint
    | PlayerTwoWonPoint


init : ( Model, Cmd Msg )
init =
    ( { previous =
            Just
                (PlayedMore
                    { secondsetwinner = PlayerOne
                    , alreadywonfirst = False
                    , secondlooserscores = ( MaxFive One, MaxFive One )
                    , thirdset =
                        Just
                            ({ wonthirdandsecond = True
                             , thirdsetlooserscores = ( MaxFive One, MaxFive One, MaxFive One )
                             , fourthset = Nothing
                             }
                            )
                    }
                )
      , current = SixtoFive PlayerOne
      }
    , Cmd.none
    )


view :
    Model
    -> Html Msg
view model =
    div []
        [ button [ onClick <| PlayerOneWonPoint ] [ text "Add" ]
        , div [] [ text <| toString model.previous ]
        , div [] [ text <| toString model.current ]
        , button [ onClick <| PlayerTwoWonPoint ] [ text "Add" ]
        ]


update :
    Msg
    -> Model
    -> ( Model, Cmd none )
update msg model =
    case msg of
        PlayerOneWonPoint ->
            let
                newCurrentSet =
                    case model.current of
                      UpToFive a ->
                        if a.player1 == Five then
                          Lost { loosergameswon = MaxFive Four }
                        else 
                          Lost { loosergameswon = MaxFive Four }
                      SixtoFive b ->
                        Lost { loosergameswon = MaxFive Four }
                      TieBreak ->
                        Lost { loosergameswon = MaxFive Four }
                      Lost c ->
                        Lost { loosergameswon = MaxFive Four }
            in
                ( { model | current = newCurrentSet }, Cmd.none )

        PlayerTwoWonPoint ->
            let
                newscore =
                    UpToFive
                        { player1 = Five
                        , player2 = Five
                        }
            in
                ( { model | current = newscore }, Cmd.none )
