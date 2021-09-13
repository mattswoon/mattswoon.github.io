module Page.Discord exposing (main, Model, Msg, view, update, init)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Bulma.CDN exposing (stylesheet)
import Bulma.Layout as L
import Bulma.Components as C
import Bulma.Elements as E
import Bulma.Modifiers as M
import Bulma.Modifiers.Typography as T

import Elements as El


type DiscordBot
    = Yeats
    | Nancy
    | DiceyRoll

type HoverMenuItem
    = HoverYeats
    | HoverNancy
    | HoverDiceyRoll

type Model
    = Landing (Maybe HoverMenuItem)
    | Viewing DiscordBot

type Msg
    = ChangeTo DiscordBot
    | GoToLanding
    | Hover (HoverMenuItem)
    | UnHover (HoverMenuItem)

init : () -> (Model, Cmd Msg)
init _ = (Landing Nothing, Cmd.none)

view : Model -> Browser.Document Msg
view model = 
    { title = "Discord bots"
    , body = 
        [ stylesheet
        , L.section L.Spaced []
            [ viewHeader model
            , viewBody model
            ]
        ]
    }

viewHeader : Model -> Html Msg
viewHeader _ =
    L.container []
        [ L.hero L.heroModifiers []
            [ L.heroBody []
                [ L.container []
                    [ C.breadcrumb C.breadcrumbModifiers [] []
                        [ C.crumblet False [] [href "/"] [ text "Home" ]
                        , C.crumblet True [] [href "/#/discord-bots"] [ text "Discord Bots" ]
                        ]
                    , E.title E.H1 [] [ text "My Discord bots" ]
                    , em [ T.textColor T.Grey ] [ text "last updated September 2021" ]
                    , p [] [ text "Lockdowns inspired me to write some bots for making Discord chats with friends more fun" ]
                    ]
                ]
            ]
        ]


viewBody : Model -> Html Msg
viewBody model = 
    case model of
        Landing hover -> viewLandingBody hover
        _ -> text "hello"

viewLandingBody : Maybe HoverMenuItem -> Html Msg
viewLandingBody hover =
    L.container []
        [ El.hoverBox (hover == Just HoverYeats) [ onMouseOver (Hover HoverYeats), onMouseOut (UnHover HoverYeats)  ] 
            [ E.title E.H2 [] [ text "Yeats" ]
            , E.content M.Standard []
                [ article [] 
                    [ p [] [ text "I know it as Irish, maybe you know it as something else. A combination of charades, celebrity heads and those kinds of parlour games" ]
                    , p [] [ text """Yeats is a Discord bot that manages playing the game via Discord, with the help of either voice channels or video chat 
                    depending on how you want to play it.""" ]
                    ]
                ]
            ]
        , El.hoverBox (hover == Just HoverNancy) [ onMouseOver (Hover HoverNancy), onMouseOut (UnHover HoverYeats)] 
            [ E.title E.H2 [] [ text "Nancy" ]
            , E.content M.Standard []
                [ article [] 
                    [ p [] [ text """This is my Discord take on OnlyConnect, the game where you guess the connection between a bunch
                    of clues, or guess the last element in a sequence.""" ]
                    ]
                ]
            ]
        , El.hoverBox (hover == Just HoverDiceyRoll) [ onMouseOver (Hover HoverDiceyRoll), onMouseOut (UnHover HoverDiceyRoll)] 
            [ E.title E.H2 [] [ text "Dicey-roll" ]
            , E.content M.Standard []
                [ article [] 
                    [ p [] [ text """I don't really partake, but if you want to play table-top RPGs on discord, you'll need some dice to roll. 
                    Here they are!""" ]
                    ]
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case (msg, model) of
        (ChangeTo bot, _) -> ( Viewing bot, Cmd.none )
        (GoToLanding, _) -> ( Landing Nothing, Cmd.none )
        (Hover h, _) -> ( Just h |> Landing, Cmd.none )
        (UnHover _, _) -> ( Landing Nothing, Cmd.none )

main : Program () Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none }
