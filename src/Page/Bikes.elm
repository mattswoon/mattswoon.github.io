module Page.Bikes exposing (main, Model, Msg, view, update, init)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Bulma.Components exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Modifiers as M exposing (..)
import Bulma.Modifiers.Typography as T exposing (..)
import Bulma.Elements exposing (..)
import Bulma.CDN exposing (..)

type Bike 
    = BlueEagle
    | Clament
    | Speedwell
    | NoNameTouring
    | Surly
    | Korean3Sixty
    | Carrerra
    | Cargo

type Model
    = Viewing Bike

type Msg
    = ChangeTo Bike

init : () -> (Model, Cmd Msg)
init _ = (Viewing BlueEagle, Cmd.none)

view : Model -> Browser.Document Msg
view model =
    case model of
        Viewing bike -> viewBike bike


viewBike : Bike -> Browser.Document Msg
viewBike bike =
    { title = "My bikes"
    , body = 
        [ stylesheet
        , Bulma.Layout.section Spaced [] 
            [ container [] 
                [ hero heroModifiers [] 
                    [ heroBody [] 
                        [ container []
                            [ Bulma.Elements.title H1 [] [ text "A brief history of (my) bikes" ] 
                            , em [ textColor Grey ] [text "last updated September 2021" ]
                            , p [] [ text "Here lies an almost complete chronicle of the bikes that made me the cyclist I am today." ]
                            ]
                        ]
                    ]
                , tileAncestor Auto []
                    [ tileParent Width4 [] [ tileChild Auto [] (viewMenu bike)]
                    , tileParent Auto [] 
                        [ tileChild Auto
                            [ class "box"
                            ]
                            (viewMainPanel bike)
                        ]
                    ]
                ]
            ]
        ]
    }

viewMenu : Bike -> List (Html Msg)
viewMenu bike =
    [ panel []
        [ panelHeading [] [ text "My Bikes" ]
        , panelLink (bike == BlueEagle) [ onClick (ChangeTo BlueEagle), href "#/bikes"] [ text "The Blue eagle (2012-2015ish)" ]
        , panelLink (bike == Clament) [ onClick (ChangeTo Clament), href "#/bikes"] [ text "Clament fixed gear (2012-2015ish)" ]
        , panelLink (bike == Speedwell) [ onClick (ChangeTo Speedwell), href "#/bikes"] [ text "1948 Speedwell (2013-current)" ]
        , panelLink (bike == NoNameTouring) [ onClick (ChangeTo NoNameTouring), href "#/bikes"] [ text "No-name touring bike (2016-2017)" ]
        , panelLink (bike == Surly) [ onClick (ChangeTo Surly), href "#/bikes" ] [ text "Surly Disc Trucker (2018-current)" ]
        , panelLink (bike == Korean3Sixty) [ onClick (ChangeTo Korean3Sixty), href "#/bikes" ] [ text "3Sixty (2019-current)"]
        , panelLink (bike == Carrerra) [ onClick (ChangeTo Carrerra), href "#/bikes" ] [ text "Carrerra (2021-current)" ]
        ]
    ]

viewMainPanel : Bike -> List (Html Msg)
viewMainPanel bike =
    case bike of
        BlueEagle -> [ content M.Standard [] [blueEagleArticle] ]
        Clament -> [ content M.Standard [] [clamentArticle] ]
        Speedwell -> [ content M.Standard [] [speedwellArticle] ]
        NoNameTouring -> [ content M.Standard [] [noNameTouringArticle] ]
        Surly -> [ content M.Standard [] [surlyArticle] ]
        Korean3Sixty -> [ content M.Standard [] [korean3SixtyArticle] ]
        Carrerra -> [ content M.Standard [] [carrerraArticle] ]
        Cargo -> [ content M.Standard [] [cargoArticle] ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (msg, model) of
        (ChangeTo bike, _) -> ( Viewing bike, Cmd.none )

main : Program () Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none 
    }

blueEagleArticle : Html Msg
blueEagleArticle = article []
    [ Bulma.Elements.title H1 [] [ text "The birth of tinkering, 2012-2015ish" ]
    , image Natural [] [ img 
        [ src "content/blog/bikes/blue_eagle.jpg" 
        , alt """A black, white and blue (an embarrassingly 2012 smartphone filter) picture of the Blue Eagle.
 It's covered in rust but has shiny new no-name cranks, VO left bank handlebars, and a rip-off Enfield leather saddle from eBay."""
        ] []]
    , p [] [ text """I originally bought the blue eagle for $20 because I needed a seatpost, 
but decided I liked it more than whatever other thing I was tinkering on."""]
    , p [] [ text """I read sheldonbrown.com from start to finish and bought cheap parts off ebay. 
I doubled downed and bought handlebars, long reach brakes and bar end brake
levers from velo-orange.""" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/blue_eagle_20141221.jpg"
        , alt "The Blue Eagle after a trip to K-Mart to buy some coat hangers."
        ] []]
    , p [] [ text """The blue eagle lasted a few years and got an upgrade to a 6 speed cassette harvested from 
a bike left on a friends porch, which was donated to me and converted to a fixed gear."""]
    , image Natural [] [ img
        [ src "content/blog/bikes/blue_eagle_20141126.jpg" 
        , alt """A POV shot of the Blue Eagle in action. Clearly visible is the crappy job I did 
of using linseed oil as a rust protector on the stem, which has made it a gross yellow colour."""
        ] []]
    ]

clamentArticle : Html Msg
clamentArticle = article []
    [ Bulma.Elements.title H1 [] [ text "A succumbening to hipster-dom, the fixed gear, 2012-2015ish" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/clament_20120324.jpg"
        , alt "The Clament, converted to fixed gear, photgraphed in front of the ANZAC bridge" 
        ] []]
    , p [] [ text """Fixed gears are dumb. I hated them. Don't be such a twat and just
get some gears."""]
    , p [] [ text """Everyone was saying that fixed gears are so great because they have
so little maintenance, or that they're cheap, or that you don't need brakes
because your thighs can crush a fuckin' watermelon, or that all the bike
messengers in new york use them so they must be super cool.""" ]
    , p [] [ text """It made me irrationally angry, so when a friend moved into a place with
an abandoned bike on the front porch, I took and converted it into a fixie.
Fuck, I even sawed the drops to make bullhorns, that's how hard I went.""" ]
    , p [] [ text """Turns out, fixies are really fun and there's no rational reason for it. They just
are. And maybe the watermelon thing has some merit.""" ]
    ]

speedwellArticle : Html Msg
speedwellArticle = article []
    [ Bulma.Elements.title H1 [] [ text "Actually this one is quite old, 2013-current" ]
    , image Natural [] [ img 
        [ src "content/blog/bikes/speedwell_20130512_100554.jpg" 
        , alt """A dark purple vintage Speedwell bicycle. The chain is rusty and the 
gears - a Sturmy Archer AW3 - aren't connected."""
        ] []]
    , p [] [ text """I had two bikes by now, and had bored my family enough with this new found interest
that I was becoming a "bike guy". My grandparents' neighbour was getting rid of his
old bike that had been sitting in his backyard shed for some time. So my grandparents
put me in touch and I went to have a look - I don't need a new bike, but I can have a look
right.""" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/speedwell_20130512_100606.jpg"
        , alt "Original Sturmey Archer shifter, mounted to the top tube." 
        ] []]
    , p [] [ text """When he said the bike had been sitting in the shed for a while, he meant since the mid-70s.
He bought it brand new in in 1952. At this time, this bike was more than twice my age
and I would be its second owner.""" ]
    , image Natural [] [ img 
        [ src "content/blog/bikes/speedwell_20130512_101429.jpg"
        , alt "Original Wrights saddle, worn and with rusty rivets."
        ] []]
    , image Natural [] [ img
        [ src "content/blog/bikes/speedwell_20130512_100722.jpg"
        , alt "Serial number of the Speedwell frame. Number reads 24875 which apparently indicates this was the 75th frame built in Feb, 1948."
        ] []]
    , p [] [ text """Originally I did very little to this bike, and just got it running. When I almost crashed in the rain because steel rims are a
joke, I decided to the get the wheels re-built with aluminium rims. I added some flair with some velo-orange hammered fenders 
and porteur handlebars as well as a soma porteur rack.""" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/speedwell_20130702.jpg"
        , alt "The Speedwell with the wheels re-built into aluminium rims, VO porteur handlebars and Soma porteur front rack."
        ] [] ]
    , p [] [ text """This setup lasted a few months until the old sturmey archer AW shat itself. My trusted bike mechanic told me they could open it up
but were unsure what they'd be able to do once they did. So I replaced it with a shimano nexus 8. I left the 3 speed shifter on though
because it was so cool.""" ]
    , Bulma.Elements.title H2 [] [ text "A 2018 refresh: Speedwell and the hottest hits from the 50s, 70s and now" ]
    , p [] [ text "My main bike shifted to a touring bike in 2016 and the speedwell returned to a shed to await its rebirth. That came in 2018." ]
    , p [] [ text """A colleague off-loaded a set of wheels to me with a sturmey archer hub from the late 70s, so again I bought parts to re-fit the
speedwell, this time as almost a time-capsule on wheels. This was no longer a bike from the 50s with some new parts on it, but a
trip through history itself - a frame imported from England in the 50s, some wheels from the 70s that weren't properly 
secured at university, some handlebars from the 2010s mimicing a style from Paris in 30s. Now it's just a nice bike.""" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/speedwell_20180526_shifter.jpg"
        , alt "A more modern Sturmey Archer AW shifter to match the hub from the 70s."
        ] []]
    , image Natural [] [ img
        [ src "content/blog/bikes/speedwell_20180526_hub.jpg"
        , alt "A Sturmey Archer AW 3-speed hub built in 1977."
        ] []]
    , image Natural [] [ img
        [ src "content/blog/bikes/speedwell_20180526_security.jpg"
        , alt "A spoke card from University Security warning that the bike hadn't been secured in an approved rack."
        ] []]
    ]

noNameTouringArticle : Html Msg
noNameTouringArticle = article []
    [ Bulma.Elements.title H1 [] [ text "Baby's first tour, 2016-2017" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/touring_20161104.jpg"
        , alt """A no-name touring bike, fully loaded while on tour. 
 Features a rear rack with two panniers and gear on top, a handlebar bag, and three stainless
 steel water bottles - two on the handlebars and one on the seat tube."""
        ] []]
    , p [] [ text """I'd long wanted to go on a bike tour, but it took a good excuse, like a 30th birthday, 
for me to actually do it.""" ]
    , p [] [ text """The first step was to a get touring bike. By now, you can probably understand that I can't 
just **buy** one and have some common, off-the-rack bike. No that would be contrary to whole
point of a coming-of-(an)-age bike tour. I had to build one, and of course I had to  
base the whole thing around some part that I'd gotten for free.""" ]
    , p [] [ text """That part was a frame, which I found discarded in a back alley, with a seized quill stem,
and a bottom bracket I'd never seen before or since. The stem came out with the help
of a hacksaw and a lack of emotional attachment to the fork, and the bottom bracket with wd40, a pipe wrench and eventually
by clamping the bottom bracket in a bench vice and turning the whole frame."""]
    , image Natural [] [ img
        [ src "content/blog/bikes/touring_20160820.jpg"
        , alt "A bare frame hanging in a tree in my back yard, ready to painted."
        ] []]
    , image Natural [] [ img 
        [ src "content/blog/bikes/touring_20160828.jpg"
        , alt "A partially built no-name touring bike with wheels and handlebars attached."
        ] []]
    , p [] [ text """I planned the tour conservatively. I scheduled 40km a day, and took a fortnight off work.
It took something like 5 days. 10/10 would do again.""" ]
    , Bulma.Elements.title H2 [] [ text "The hunge" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/touring_20170714.jpg"
        , alt """The no-name touring bike leans against a cattle paddock gate. The handlebar bag has been replaced with a
 Soma porteur front rack with a Swift Industries Sugarloaf bag on top."""
        ] []]
    , p [] [ text """A weekend away with friends in the Hunter Valley was organised and I decided to make my own way there.
I caught the train to Morrisset and rode the rest of the way through the Olney state forest, meeting
them at the Wollembi Tavern for lunch along the way.""" ]
    , p [] [ text """This was my longest ride ever and took me all day. I got on the train around 4am and arrived at the airbnb
  just before dark at about 5pm. The whole ride was about 100km, and I only shared about 10 of those with cars."""]
    , image Natural [] [ img 
        [ src "content/blog/bikes/touring_20170714_train.jpg"
        , alt """The no-name touring bike hanging from a bike rack on a NSW Intercity train."""
        ] []]
    , image Natural [] [ img
        [ src "content/blog/bikes/touring_20170714_forest.jpg"
        , alt """The no-name touring bike leaning against a felled tree in the Olney State Forest."""
        ] []]
    ]

surlyArticle : Html Msg
surlyArticle = article []
    [ Bulma.Elements.title H1 [] [ text "My most expensive bike to date, 2018-current" ]
    , image Natural [] [ img 
        [ src "content/blog/bikes/surly_20190630.jpg" 
        , alt """A fully loaded Surly Disc Trucker with leather VO saddle, red handlebar
tape and Dia Compe bar-end shifters. Attached the front is a Surly front rack with a Wald
137 basket on top holding a Swift Industries Sugarloaf bag. Hanging from the saddle is
Swift Industries Zeitgeist saddle bag. Two Aventir brand panniers hang from the front rack"""
        ] []]
    , p [] [ text """The cost of a bike is a nebulous concept for me, because I've not really gone to shop and bought one
that was sitting there ready to go. The surly holds the record for most expensive bike mostly because
I actually bought everything that's on it, at some point, rather than having been donated bits and pieces."""]
    , p [] [ text """It came about because the scalveged frame on the touring bike wasn't quite doing it for me, and I wanted
something that actually had the bosses to attach the racks and accessories I wanted to attach. I also wanted
disc brakes.""" ]
    , p [] [ text """Most of the touring bike made its way across to the surly when the frame arrived, and all in all I ended up with...
basically a stock disc trucker - sora groupset, trp disc brakes (upraded from avid bb5s once I'd had enough of their
incessant harpy squealing), dia compe bar end shifters. So not only is this the most expensive bike I've ever owned,
it probably actually cost me more than buying one straight off the shop floor ¯\\_(ツ)_/¯ .""" ]
    ]

korean3SixtyArticle : Html Msg
korean3SixtyArticle = article []
    [ Bulma.Elements.title H1 [] [ text "Into the fold, 2019-current" ]
    , image Natural [] [ img
        [ src "content/blog/bikes/folding_20200213.jpg"
        , alt """A 3Sixty folding bike leans against a post at the Glebe Light Rail station at dusk. In the background the historic Glebe rail tunnel is illuminated"""
        ] []]
    , p [] [ text """My new year's resolution for 2019 was to not buy a new bike. I failed.""" ]
    , p [] [ text """I'd been curious as to whether I wanted to a Brompton for quite some time. Come October, during one of
my regular checks of gumtree, I came across a second hand one for $800. Heccin bargain, how could I pass up? Plus it was my birthday."""]
    , p [] [ text """Turns out, it wasn't so much a Brompton, but a near identical knock-off from a Korean brand 3sixty. Anyway, it was cheap and I
justified its purchase as way of trying the folding lifestyle before I make the $2k, full experience commitment.""" ]
    , p [] [ text """The seat post wasn't long enough, and was also bent, and crankset fell off while riding and I think the frame is slightly
bent. So definitely learnt some lessons: yes I do like
folding bikes, and yes it's probably  worth the cash to get a Brompton. They're just so damn convenient for combining with other forms
of transit. I can now also ride to the pub, and not have to leave my bike there overnight!""" ]
    ]

carrerraArticle : Html Msg
carrerraArticle = article []
    [
    ]

cargoArticle : Html Msg
cargoArticle = article []
    [
    ]
