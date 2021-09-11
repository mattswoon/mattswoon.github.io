module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Bulma.CDN exposing (..)

import Page.Welcome as Welcome

type Page =
    WelcomePage Welcome.Model

type alias Model = 
    { key: Nav.Key
    , url: Url.Url
    , page: Page
    }

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | WelcomeMsg Welcome.Msg


init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
    ( Model key url (WelcomePage Welcome.init), Cmd.none )


viewTitle : Model -> String
viewTitle model =
    case model.page of
        WelcomePage m -> Welcome.viewTitle


viewBody : Model -> List (Html Msg)
viewBody model =
    case model.page of
        WelcomePage m -> List.map (Html.map WelcomeMsg) (Welcome.viewBody m)


view : Model -> Browser.Document Msg
view model =
    { title = viewTitle model
    , body = List.append [stylesheet] (viewBody model)
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url -> 
            ( { model | url = url }
            , Cmd.none
            )
        _ -> updatePage msg model

updatePage : Msg -> Model -> ( Model, Cmd Msg )
updatePage msg model =
    case (msg, model.page) of  
        (WelcomeMsg m, WelcomePage p) -> Welcome.update m p
            |> updateWith WelcomePage WelcomeMsg model
        _ -> ( model, Cmd.none)

updateWith : (subpage -> Page) -> (submsg -> Msg) -> Model -> (subpage, Cmd submsg) -> (Model, Cmd Msg)
updateWith toPage toMsg model (subpage, subcmd) =
    ( Model model.key model.url (toPage subpage)
    , Cmd.map toMsg subcmd
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

main : Program () Model Msg
main = Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = LinkClicked
    , onUrlChange = UrlChanged
    }


