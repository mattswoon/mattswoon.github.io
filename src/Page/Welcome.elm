module Page.Welcome exposing (viewTitle, viewBody, Msg, Model, init, update)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Modifiers exposing (..)

type Model 
    = Init
    | Hover MenuTile

type Msg
    = MouseOver MenuTile
    | MouseOut MenuTile

init : Model
init = Init

viewTitle : String
viewTitle = "mattswoon"

viewBody : Model -> List (Html Msg)
viewBody model = 
    [ Bulma.Layout.section NotSpaced [] 
        [ container []
            [ Bulma.Elements.title H1 [] [ text "mattswoon"] ]
        ]
    , Bulma.Layout.section NotSpaced [] 
        [ Bulma.Layout.tileAncestor Auto [] 
            [ viewTile Bikes model
            ]
        ]
    ]

type MenuTile
    = Bikes

viewBikesTile : List (Attribute Msg) -> Tile Msg
viewBikesTile attrs =
    tileParent Auto []
        [ tileChild Width3 [] 
            [ card (List.append attrs [onMouseOver (MouseOver Bikes), onMouseOut (MouseOut Bikes)])
                [ cardImage [] 
                    [ image FourByThree []
                        [ img 
                            [ src "content/blog/bikes/surly_20190630.jpg"
                            ] [] 
                        ]
                    ]
                , cardContent [] 
                    [ text "I'm all about bikes"
                    ]
                ]
            ]
        ]

viewTile : MenuTile -> Model -> Tile Msg
viewTile t model =
    case (t, model) of
        (Bikes, Init) -> viewBikesTile [ style "transition" "0.3s ease-in-out"]
        (Bikes, Hover Bikes) -> viewBikesTile cardShadow

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (msg, model) of 
        (MouseOver Bikes, Init) -> (Hover Bikes, Cmd.none)
        (MouseOver Bikes, Hover Bikes) -> (Hover Bikes, Cmd.none)
        (MouseOut Bikes, Init) -> (Init, Cmd.none)
        (MouseOut Bikes, Hover Bikes) -> (Init, Cmd.none)


cardShadow : List (Attribute msg)
cardShadow = 
    [ style "box-shadow" "5px 5px 10px #c4c4c4"
    , style "transition" "0.3s ease-out"
    , style "transform" "translate(-1px, -1px)"
    ]
