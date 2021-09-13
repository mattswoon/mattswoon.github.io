module Elements exposing (hoverBox)

import Html exposing (..)
import Html.Attributes exposing (style)
import Bulma.Elements as E

hoverBox : Bool -> List (Attribute msg) -> List (Html msg) -> E.Box msg
hoverBox isHovered attrs html =
    case isHovered of
        False -> E.box (List.append attrs [style "transition" "0.1s ease-in"]) html
        True -> E.box (List.append attrs shadowAttrs) html

shadowAttrs : List (Attribute msg)
shadowAttrs =
    [ style "box-shadow" "5px 5px 10px #c4c4c4"
    , style "transition" "0.1s ease-in"
    , style "transform" "translate(-1px, -1px)"
    ]
    
