module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Url.Parser as P -- exposing((</>))
import Bulma.CDN exposing (..)

import Page.Welcome as Welcome
import Page.Bikes as Bikes

type Page
    = WelcomePage Welcome.Model
    | BikesPage Bikes.Model

type Route
    = Home
    | Bikes

routeParser : P.Parser (Route -> a) a
routeParser =
    P.oneOf
        [ P.map Home (P.top)
        , P.map Bikes (P.s "bikes")
        ]

type alias Model = 
    { key: Nav.Key
    , url: Url.Url
    , page: Page
    }

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | WelcomeMsg Welcome.Msg
    | BikesMsg Bikes.Msg

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
    pageMap WelcomePage WelcomeMsg (Welcome.init flags) |>
    \(p, c) -> (Model key url p, c)

pageMap : (m -> Page) -> (c -> Msg) -> (m, Cmd c) -> (Page, Cmd Msg)
pageMap toPage toMsg (m, c) =
    (toPage m, Cmd.map toMsg c)

view : Model -> Browser.Document Msg
view model =
    case model.page of
        WelcomePage p -> docMap WelcomeMsg (Welcome.view p)
        BikesPage p -> docMap BikesMsg (Bikes.view p)

docMap : (msg -> Msg) -> Browser.Document msg -> Browser.Document Msg
docMap toMsg doc =
    { title = doc.title
    , body = List.map (Html.map toMsg) doc.body 
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case (msg, model.page) of
        (LinkClicked urlRequest, _) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )
                Browser.External href ->
                    ( model, Nav.load href )

        (UrlChanged url, _) -> 
            case P.parse routeParser url of
                Just Home -> pageMap WelcomePage WelcomeMsg (Welcome.init ()) |>
                    \(p, c) -> (Model model.key url p, c)
                Just Bikes -> pageMap BikesPage BikesMsg (Bikes.init ()) |>
                    \(p, c) -> (Model model.key url p, c)
                Nothing -> ( model, Cmd.none )

        (WelcomeMsg m, WelcomePage p) -> pageMap WelcomePage WelcomeMsg (Welcome.update m p) |>
            \(x, c) -> (Model model.key model.url x, c)

        (BikesMsg m, BikesPage p) -> pageMap BikesPage BikesMsg (Bikes.update m p) |>
            \(x, c) -> (Model model.key model.url x, c)

        _ -> ( model, Cmd.none )


main : Program () Model Msg
main = Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    , onUrlRequest = LinkClicked
    , onUrlChange = UrlChanged
    }
