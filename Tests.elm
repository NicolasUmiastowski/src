module Tests exposing (..)

import Test exposing (..)
import Expect
import Meetupavril exposing (..)

all : Test
all =
  let
    pathlist = [(1,2),(2,3),(2,4),(3,4),(4,5),(5,6),(5,7),(6,7),(7,8),(8,9)]
    pathlistshort = [(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9)]
  in
                
    describe "Suite"
        [ describe "Unit tests"
               [ test "removeshortcut" <|
                  \() ->
                    pathlist
                        |> removeshortcut
                        |> Expect.equal
                          [(5,7),(2,4)] 

                , test "valuestoreplace with 2 in a row" <|
                  \() ->
                    let 
                      extractshortcut = [(5,7),(2,4)] 
                    in
                      valuestoreplace pathlistshort  extractshortcut []
                        |> Expect.equal
                          [(1,2),(4,5),(7,8),(8,9)]

                , test "valuestoreplace with 3 in a row" <|
                  \() ->
                    let 
                      extractshortcut = [(5,8),(2,4)] 
                    in
                      valuestoreplace pathlistshort extractshortcut []
                        |> Expect.equal
                          [(1,2),(4,5),(8,9)]


                , test "Insertshortcuts" <|
                  \() ->
                    let 
                      pathlist1 = [(1,2),(4,5),(8,9)]
                      pathlist2 = [(2,4),(5,8)]
                    in
                      insertshortcuts pathlist1 pathlist2
                        |> Expect.equal
                          [(1,2),(2,4),(4,5),(5,8),(8,9)]

               , test "totalfunction" <|
                  \() ->
                    pathlist
                        |> totalfunction
                        |> Expect.equal
                          [(1,2),(2,4),(4,5),(5,7),(7,8),(8,9)]  
           ]
            --|> Test.filter (String.contains "meetup")
        ]
