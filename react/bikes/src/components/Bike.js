import { useState, useEffect } from 'react';
import { 
    Image, 
    Text, 
    Container, 
    Title,
    Card,
    Grid,
    Affix,
    Button,
} from '@mantine/core';
import { motion } from "framer-motion";
import { ArrowLeftIcon } from "@radix-ui/react-icons";

export const BikePage = () => {
    const [bikeIdx, setBikeIdx] = useState(null);

    const body = bikeIdx === null
        ? <BikeMenu setBikeIdx={setBikeIdx} />
        : <BikeArticle bikeData={data[bikeIdx]} setBikeIdx={setBikeIdx} />;

    return <BikeContainer>{body}</BikeContainer>
}

export const BikeContainer = ({children}) => {
    return <Container fluid>
        <Container style={{padding: "30px"}}>
            <Title order={1} align="center">My Bikes</Title>
        </Container>
        <Container fluid>
            {children}
        </Container>
        </Container>
}

export const BikeMenu = ({setBikeIdx}) => {
    return <Container fluid>
        <Grid grow cols={3} gutter="lg">
            {data.map((b, i) => <Grid.Col span={4} key={i}>
                <BikeCard
                    title={b.name} 
                    description={b.description} 
                    image={b.picture}
                    idx={i} 
                    setBikeIdx={setBikeIdx} />
            </Grid.Col>)}
        </Grid>
    </Container>
};

export const Bike = ({children, ...props}) => {
    return <div>
        <h1> Hello {props.name} </h1>
        {children}
    </div>
};

export const BikeArticleElement = ({element}) => {
    switch (element.element) {
        case "paragraph":
            return <p>{element.text}</p>
        case "image":
            return <Image src={element.src} alt={element.alt} radius="md" style={{ margin: "10px" }} />
    }
};

export const BikeArticle = ({bikeData, setBikeIdx}) => {
    return (
        <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
        >
            <Affix position={{ top: "50%", left: 20 }} >
                <Button leftIcon={<ArrowLeftIcon />} variant="subtle" onClick={() => setBikeIdx(null)}>Back</Button>
            </Affix>
            <Container 
                size="sm"
                padding="xs"
            >
                <Title>{bikeData.name}</Title>
                <Container padding="xs">
                    {bikeData.article.map((e, i) => <BikeArticleElement key={i} element={e} />)}
                </Container>
            </Container>
        </motion.div>
    )
};

export const BikeCard = ({title, description, image, idx, setBikeIdx}) => {
    const [hover, setHover] = useState(false);
    const shadow = hover ? "xl" : "sm";
    const style = {
        transition: "transform .2s ease-in-out",
        transform: hover
            ? `translate(-2px, -2px)`
            : `translate(0px, 0px)`,
    };

    return (
        <motion.div 
            animate={{ opacity: 1 }} 
            initial={{ opacity: 0 }} 
            style={{ width: 340, margin: 'auto', padding: 20 }}
        >
            <Card
                shadow={shadow}
                padding="lg"
                style={style}
                onMouseEnter={() => setHover(true)}
                onMouseLeave={() => setHover(false)}
                onClick={() => setBikeIdx(idx)}
            >
                <Card.Section>
                    <Image src={image.src} alt={image.alt} />
                </Card.Section>
                <Text size="lg">{title}</Text>
                <Text size="sm" lineClamp={3}>{description}</Text>
            </Card>
        </motion.div>
    )
};


export const data = [
    {
        name: "The blue eagle",
        description: "The first bike I started tinkering with.",
        picture: {
            src: "/content/blog/bikes/blue_eagle.jpg",
            alt: `A black, white and blue (an embarrassingly 2012 smartphone filter) picture of the Blue Eagle.
 It's covered in rust but has shiny new no-name cranks, VO left bank handlebars, and a rip-off Enfield leather saddle from eBay.`
        },
        article: [
            {
                element: "paragraph",
                text: `I originally bought the blue eagle for $20 because I needed a seatpost, 
but decided I liked it more than whatever other thing I was tinkering on.`
            },
            {
                element: "paragraph",
                text: `I read sheldonbrown.com from start to finish and bought cheap parts off ebay. 
I doubled downed and bought handlebars, long reach brakes and bar end brake
levers from velo-orange.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/blue_eagle.jpg",
                alt: "The Blue Eagle after a trip to K-Mart to buy some coat hangers."
            },
            {
                element: "paragraph",
                text: `The blue eagle lasted a few years and got an upgrade to a 6 speed cassette harvested from 
a bike left on a friends porch, which was donated to me and converted to a fixed gear.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/blue_eagle_20141126.jpg",
                alt: `A POV shot of the Blue Eagle in action. Clearly visible is the crappy job I did 
of using linseed oil as a rust protector on the stem, which has made it a gross yellow colour.`
            }
        ]
    },
    {
        name: "The Clament",
        description: "Salvaged from a friend's porch when left by a previous tenant, turned into a fixed gear just to try it out.",
        picture: {
            src: "/content/blog/bikes/clament_20120324.jpg",
            alt: "The Clament, converted to fixed gear, photgraphed in front of the ANZAC bridge"
        },
        article: [
            {
                element: "paragraph",
                text: `Fixed gears are dumb. I hated them. Don't be such a twat and just
get some gears.`
            },
            {
                element: "paragraph",
                text: `Everyone was saying that fixed gears are so great because they have
so little maintenance, or that they're cheap, or that you don't need brakes
because your thighs can crush a fuckin' watermelon, or that all the bike
messengers in new york use them so they must be super cool.`
            },
            {
                element: "paragraph",
                text: `It made me irrationally angry, so when a friend moved into a place with
an abandoned bike on the front porch, I took and converted it into a fixie.
Fuck, I even sawed the drops to make bullhorns, that's how hard I went.`
            },
            {
                element: "paragraph",
                text: `Turns out, fixies are really fun and there's no rational reason for it. They just
are. And maybe the watermelon thing has some merit.`
            }
        ]
    },
    {
        name: "KHS",
        description: "A proper fixed gear donated by an old housemate.",
        picture: {
            src: "/content/blog/bikes/khs_20180216.jpg",
            alt: "A teal KHS frame with swept back handlebars and a walk 137 basket"
        },
        article: [
            {
                element: "paragraph",
                text: `A former housemate of mine was pivotal in my descent into bike tinkerdom. Ironically, he 
 was also why I hated fixed gears so much, that is until I rode one.`
            },
            {
                element: "paragraph",
                text: `This bike started out as his, and I watched him replace every. single. part. on it, except
 the seat post. Some time around 2014/2015, after we'd both moved, he
 gave it to me - he was no longer riding it and didn't want to see it rust on the balcony
 of his coastal apartment.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/khs_20170108.jpg",
                alt: "The KHS fixed gear bike without the Walk basket, instead there's an old knapsack strapped to the seatpost"
            },
            {
                element: "paragraph",
                text: `I've not done much to it, except change the handlebars to something more
 my preferred style (VO porteur bars from the speedwell) and give it some
 luggage options depending on what was lying around at the time.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/khs_20171012.jpg",
                alt: `The KHS at night, very "urban".`
            }
        ]
    },
    {
        name: "Speedwell",
        description: "Quite an old bike. Donated by my grandparents' neighbour who bought it in 1951. I'm the second owner",
        picture: {
            src: "/content/blog/bikes/speedwell_20180526_full.jpg",
            alt: "A purple speedwell bike with chrome forks, swept back handlebars and a front porteur rack."
        },
        article: [
            { 
                element: "paragraph",
                text: `I had two bikes by now, and had bored my family enough with this new found interest
that I was becoming a "bike guy". My grandparents' neighbour was getting rid of his
old bike that had been sitting in his backyard shed for some time. So my grandparents
put me in touch and I went to have a look - I don't need a new bike, but I can have a look
right.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20130512_100606.jpg",
                alt: "Original Sturmey Archer shifter, mounted to the top tube."
            },
            {
                element: "paragraph",
                text: `When he said the bike had been sitting in the shed for a while, he meant since the mid-70s.
He bought it brand new in in 1952. At this time, this bike was more than twice my age
and I would be its second owner.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20130512_101429.jpg",
                alt: "Original Wrights saddle, worn and with rusty rivets."
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20130512_100722.jpg",
                alt: "Serial number of the Speedwell frame. Number reads 24875 which apparently indicates this was the 75th frame built in Feb, 1948."
            },
            {
                element: "paragraph",
                text: `Originally I did very little to this bike, and just got it running. When I almost crashed in the rain because steel rims are a
joke, I decided to the get the wheels re-built with aluminium rims. I added some flair with some velo-orange hammered fenders 
and porteur handlebars as well as a soma porteur rack.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20130702.jpg",
                alt: "The Speedwell with the wheels re-built into aluminium rims, VO porteur handlebars and Soma porteur front rack."
            },
            {
                element: "paragraph",
                text: `This setup lasted a few months until the old sturmey archer AW shat itself. My trusted bike mechanic told me they could open it up
but were unsure what they'd be able to do once they did. So I replaced it with a shimano nexus 8. I left the 3 speed shifter on though
because it was so cool.`
            },
            {
                element: "paragraph",
                text: "My main bike shifted to a touring bike in 2016 and the speedwell returned to a shed to await its rebirth. That came in 2018."
            },
            {
                element: "paragraph",
                text: `A colleague off-loaded a set of wheels to me with a sturmey archer hub from the late 70s, so again I bought parts to re-fit the
speedwell, this time as almost a time-capsule on wheels. This was no longer a bike from the 50s with some new parts on it, but a
trip through history itself - a frame imported from England in the 50s, some wheels from the 70s that weren't properly 
secured at university, some handlebars from the 2010s mimicing a style from Paris in 30s. Now it's just a nice bike.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20180526_shifter.jpg",
                alt: "A more modern Sturmey Archer AW shifter to match the hub from the 70s."
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20180526_hub.jpg",
                alt: "A Sturmey Archer AW 3-speed hub built in 1977."
            },
            {
                element: "image",
                src: "/content/blog/bikes/speedwell_20180526_security.jpg",
                alt: "A spoke card from University Security warning that the bike hadn't been secured in an approved rack."
            }
        ]
    },
    {
        name: "No Name Tourer",
        description: "A frame found in a back alley turned into my first touring bike and first bike built from the ground up.",
        picture: {
            src: "/content/blog/bikes/touring_20161104.jpg",
            alt: "A grey and black unbranded touring bike with two water bottles attached to the handlebars, handlebar bag and rear rack, fully loaded on tour."
        },
        article: [
            {
                element: "paragraph",
                text: `I'd long wanted to go on a bike tour, but it took a good excuse, like a 30th birthday, 
for me to actually do it.`
            },
            {
                element: "paragraph",
                text: `The first step was to a get touring bike. By now, you can probably understand that I can't 
just **buy** one and have some common, off-the-rack bike. No that would be contrary to whole
point of a coming-of-(an)-age bike tour. I had to build one, and of course I had to  
base the whole thing around some part that I'd gotten for free.`
            },
            {
                element: "paragraph",
                text: `That part was a frame, which I found discarded in a back alley, with a seized quill stem,
and a bottom bracket I'd never seen before or since. The stem came out with the help
of a hacksaw and a lack of emotional attachment to the fork, and the bottom bracket with wd40, a pipe wrench and eventually
by clamping the bottom bracket in a bench vice and turning the whole frame.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/touring_20160820.jpg",
                alt: "A bare frame hanging in a tree in my back yard, ready to painted."
            },
            {
                element: "image",
                src: "/content/blog/bikes/touring_20160828.jpg",
                alt: "A partially built no-name touring bike with wheels and handlebars attached."
            },
            {
                element: "paragraph",
                text: `I planned the tour conservatively. I scheduled 40km a day, and took a fortnight off work.
It took something like 5 days. 10/10 would do again.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/touring_20170714.jpg",
                alt: `The no-name touring bike leans against a cattle paddock gate. The handlebar bag has been replaced with a
 Soma porteur front rack with a Swift Industries Sugarloaf bag on top.`
            },
            {
                element: "paragraph",
                text: `A weekend away with friends in the Hunter Valley was organised and I decided to make my own way there.
I caught the train to Morrisset and rode the rest of the way through the Olney state forest, meeting
them at the Wollembi Tavern for lunch along the way.`
            },
            {
                element: "paragraph",
                text: `This was my longest ride ever and took me all day. I got on the train around 4am and arrived at the airbnb
  just before dark at about 5pm. The whole ride was about 100km, and I only shared about 10 of those with cars.`
            },
            {
                element: "image",
                src: "/content/blog/bikes/touring_20170714_train.jpg",
                alt: "The no-name touring bike hanging from a bike rack on a NSW Intercity train."
            },
            {
                element: "image",
                src: "/content/blog/bikes/touring_20170714_forest.jpg",
                alt: "The no-name touring bike leaning against a felled tree in the Olney State Forest."
            }
        ]
    },
    {
        name: "Surly Disc Trucker",
        description: "The No Name Tourer got turfed with the aquisition of a big boys frame.",
        picture: {
            src: "/content/blog/bikes/surly_20190630.jpg",
            alt: "Surly Disc Trucker with a Surly front rack with a wald 137 basket zip tied on top."
        },
        article: [
            {
                element: "paragraph",
                text: `The cost of a bike is a nebulous concept for me, because I've not really gone to shop and bought one
that was sitting there ready to go. The surly holds the record for most expensive bike mostly because
I actually bought everything that's on it, at some point, rather than having been donated bits and pieces.`
            },
            {
                element: "paragraph",
                text: `It came about because the scalveged frame on the touring bike wasn't quite doing it for me, and I wanted
something that actually had the bosses to attach the racks and accessories I wanted to attach. I also wanted
disc brakes.`
            },
            {
                element: "paragraph",
                text: `Most of the touring bike made its way across to the surly when the frame arrived, and all in all I ended up with...
basically a stock disc trucker - sora groupset, trp disc brakes (upraded from avid bb5s once I'd had enough of their
incessant harpy squealing), dia compe bar end shifters. So not only is this the most expensive bike I've ever owned,
it probably actually cost me more than buying one straight off the shop floor ¯\\_(ツ)_/¯ .`
            }
        ]
    },
    {
        name: "3sixty",
        description: "I wanted to try a folding bike but didn't want to commit to a brompton, so found a 3sixty second hand for cheap.",
        picture: {
            src: "/content/blog/bikes/folding_20200213.jpg",
            alt: "3sixty branded folding bike, very similar to a brompton."
        },
        article: [
            {
                element: "paragraph",
                text: "My new year's resolution for 2019 was to not buy a new bike. I failed."
            },
            {
                element: "paragraph",
                text: `I'd been curious as to whether I wanted to a Brompton for quite some time. Come October, during one of
my regular checks of gumtree, I came across a second hand one for $800. Heccin bargain, how could I pass up? Plus it was my birthday.`
            },
            {
                element: "paragraph",
                text: `Turns out, it wasn't so much a Brompton, but a near identical knock-off from a Korean brand 3sixty. Anyway, it was cheap and I
justified its purchase as way of trying the folding lifestyle before I make the $2k, full experience commitment.`
            },
            {
                element: "paragraph",
                text: `The seat post wasn't long enough, and was also bent, and crankset fell off while riding and I think the frame is slightly
bent. So definitely learnt some lessons: yes I do like
folding bikes, and yes it's probably  worth the cash to get a Brompton. They're just so damn convenient for combining with other forms
of transit. I can now also ride to the pub, and not have to leave my bike there overnight!`
            }
        ]
    },
    {
        name: "Carrera",
        description: "For going fast, it's good to have something light. This I bought on eBay while I was actually just looking for parts.",
        picture: {
            src: "/content/blog/bikes/carrera_1.jpg",
            alt: "A yellow and silver Carrera racing road bike with Gravity Zero carbon rims."
        },
        article: [
            {
                element: "image",
                src: "/content/blog/bikes/carrera_and_me.jpg",
                alt: "Myself and the Carrera after a ride through the Royal National Park"
            },
            {
                element: "paragraph",
                text: `Mid 2021 I started joining some friends on some longer road rides and was a bit scared I wouldn't be able to keep up on a 14kg touring bike.
 I had a 90s road bike in the shed which weighed about 11kg so I thought I should look around for some more contemporary parts and bring it into the 21st century.
 However, due to the Covid pandemic bike parts were hard to come buy (for a price that I wanted to spend), so I was searching on eBay/gumtree/facebook marketplace
 for second hand parts when I came across a rather garish listing of a yellow Carrera. It was an aluminium frame, carbon wheels, decent drivetrain (Ultegra cranks
 with microShift shifters and mechs) for $760.`
            },
            {
                element: "paragraph",
                text: `I thought I'll just put in a bid, surely it will go up a bit and I'll miss out, but whatever hey? Everything else I'd looked at that was remotely similar was about $1 200
     and a groupset alone was looking at $750-$900. Sure enough, no one else was particularly interested in frame brand that had fallen out of fashion and non-Shimano shifters.`
            },
            {
                element: "paragraph",
                text: `Picking up the bike was a wild experience in itself, the seller lived in what can only be described as a Bianchi museum.`
            }
        ]
    },
    {
        name: "Cargo",
        description: "I've always wanted a cargo bike, and new puppy made convincing myself really easy.",
        picture: {
            src: "/content/blog/bikes/cargo_20211012.jpg",
            alt: "A tribe bikes bakfiets, or box bike. It's a tricycle with two wheels at the front, supporting a large wooden box."
        },
        article: []
    },
]
