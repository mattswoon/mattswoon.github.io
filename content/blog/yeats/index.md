---
layout: post
title:  "Playing parlour games on discord during lockdown"
date:   2020-04-04 12:28 +1100
description: My circle of friends call this game irish, and seeing as we can't see each other during the lockdown, I wrote a discord bot so we can play it OL
categories: code
---

## Irish
This game probably has a lot of names, I've not met many who call it Irish.

Everyone puts clues into a bowl, they can be anything: a celebrity, a character, an event, an in-joke, a song, a lyric,
one of euclids axioms, an emotion...

Then there's three rounds where everyone takes at turn at pulling clues out of the bowl and performing them to some other people.
In each round the mode of performance changes
 1. use any words that aren't written on the clue
 2. use one word and and one word only
 3. charades

You can invent more rounds if you want, the point is that successful performances don't need to 
describe the clue precisely but you can use in-jokes and throw backs to the previous rounds to help the person guessing. Some suggestions
for playing this on discord include
 * Sound effects only (I guess this is the radio drama version of charades?)
 * Emojis only 👨💀🌯➡️✋ (["He Died with Felafel in His Hand"](https://www.imdb.com/title/tt0172543/?ref_=fn_al_tt_1) ??)

### Quarantine
With the global pandemic in full swing and all this talk of flattening the curve, 
gathering with a large enough group of friends to play is not possible. 
So I made a discord bot so we can play it virtually.

The bot, named Yeats because he was Irish and the special topic of one of my friends when she went on the hard quiz,
manages the bowl of clues, the turn order and showing clues to the person who's performing that turn.

Yeats is written in JavaScript and I've never written JavaScript before,
so while I'm showing you what I've done, this is 
not supposed to be a tutorial!

Those who don't care and just want to see the code, 
it's on my [GitHub](https://github.com/mattswoon/yeats).

### Yeats game state

To run the game there's a number of different classes I've used to record various aspects of the game state, they are
  
  * `Game`: Overall game state - what round we're in (many words, one word, charades...), who are the players, the current turn state, the bowl (where clues are kept) state, the channel to send messages to, 
  whether the game is locked or not (when locked you can't add new clues or players)
  * `Bowl`: The collection of clues, which ones have been solved and which ones remain unsolved
  * `Turn`: Info about the current turn - who's performing to whom, whether the turn is `READY`, `RUNNING` or `FINISHED`, which clues have been solved, which clue is currently being shown
  * `Players`: State of the turn order - who's playing, the turn queue, a map of who'll be performing and who'll be guessing

### Running turns
Most of the game runs by fairly simple game state transitions:
 * When a turn is prepped a player gets popped out of the turn queue, the bowl gets shuffled, the turn state is set to `READY` and a message gets sent to the channel
 notifying the performer and the guesser that they should be ready
 * When the turn ends the last shown clue (which is still unsolved) is put back into the bowl, the performer is pushed onto a "had turn" array, the clues that were solved during the turn
 get put into a "solved clues" array and the channel gets a recap of which clues were solved during the turn

The first difficulty I encountered was dealing with the two ways a turn can end
 * A turn ends 90s (or some defined time period) after it starts, or
 * When the bowl is empty of clues

The difficulty is with the way I implemented the first option, using async/await and a promise that resolves after some delay (the turn time). Those are javascript words, 
and I don't fully understand them, so don't worry if you don't either.

#### A problem :(
So the issue was this, when a turn is started the following happens
 1. The turn state is set to `RUNNING`
 2. A clue is shown to the performer
 3. await for the delay function to finish
 4. end the turn

While awaiting the delay function to finish, yeats listens for any message from the performer (either via dm or in the text channel) and takes that message to mean 
"we've solved this clue, give me the next please". Now what happens if there's no more clues? It'd be annoying to have to wait out the turn time for the turn to end, 
so we'd prefer to end the turn there, and get ready for the next round.

Now if we just fire off an `endTurn` directive when the bowl is emptied, we could end the turn. The problem being that the awaiting start turn function will also 
try to end the turn when the delay finishes, meaning we'll be trying to end the turn twice.

We could do a check on the turn state when we end the turn, to make sure the turn is still running first. But then the following is possible: 
  1. A turn starts
  2. The perfomer solves all the clues in the bowl, so the turn ends (and its state set to `FINISHED`)
  3. We start the next round and start the next turn (setting the turn state to `READY` and then `RUNNING`)
  4. The function from bullet 1. finishes awaiting and sends an `endTurn`, and now since the current turn has a `RUNNING` state, *it* becomes the turn to end.

This is clearly not how the game should work. How do we fix it?

#### A solution :)
There may be better ways, but here's what I did: When a turn is prepped, not only is its state set to `READY` but it is given a random identifier - I guess a plain old 
random number could do, but I used uuids because I like the way the look. Then, when we send an `endTurn`, we don't just say "end the current turn", we say 
"end the turn with identifier X". Now we still check the current turn is running, but we *also* check that the current turn has the same identifier as the turn 
we've asked yeats to end.

In the example above, when we try to end the turn from bullet 1. in bullet 4. yeats will notice that the turn we're trying to end isn't the same turn that's currently 
running, and so will do nothing (except log that an `endTurn` came in for an obselete turn, so we know it's working).

## Some more details
For those interested, here's a little bit more of "how".

### Make a discord bot

Creating a discord bot is pretty straightforward, just follow the instructions over [here](https://discordpy.readthedocs.io/en/latest/discord.html).

All we need is the  secret token, which I've saved to a file in my repository called `.profile` (which is in the `.gitignore` so I don't 
 commit it for all the world to see), which I can `source` to as an environment variable.

```shell
export YEATS_TOKEN="SoMeChArAcTeRsAnDPuNcTuaTioNandStuFf"
```

### Bot basics

I'd not really done any javascript programming before but some discord bot tutorials got me up and running. The process was something like

  1. Install [`node`](https://nodejs.org/en/download/) and [`npm`]([200~https://www.npmjs.com/get-npm) and whatever
  2. Run `npm init` and follow the instructions
  2. `npm install discordjs`
  3. Start coding

The basics of yeats is to connect using the above secret token, then listen for messages and update the game state accordingly. 
So it all started off looking something like

```javascript
const Discord = require('discord.js');
token = process.env.YEATS_TOKEN;
console.log(`Connecting with token=${token}`);
const client = new Discord.Client();

client.once('ready', () => {
  console.log('Connected and ready');
});

client.on('message', (message) => {
  if (message.channel.type == 'text' & message.content === 'Hello yeats') {
    message.reply(`Hello ${message.author}`)
  };
});

client.connect(token);
```

### Adding commands
To add commands to yeats's repertoire, we just need to add more `if` statements in the `'message'` event listener. 
I have three main blocks - one for commands (they start with `!`) DM'd to yeats, one for commands in the text channel, and one for the performer asking for a new clue. 
So the `'message'` listener looks more like 

```js
client.on('message', (message) => {
  if (message.channel.type === 'text' & message.content.startsWith('!')) {
    command = message.content.split(' ')[0];
    switch(command) {
      case '!add-players' 
        // stuff
        break;
      case '!start-game'
        // stuff
        break;
      case '!next-turn'
        // stuff
        break;
      case '!start-turn'
        // stuff
        break;
      // and so on
      default
        message.reply('Unknown command');
    };
  };
  if (message.channel.type === 'dm' & message.content.startsWith('!')) {
    command = message.content.split(' ')[0];
    switch(command) {
      case 'add-clue'
        // stuff
        break;
      default 
        message.reply('Unknown command');
    };
  };
  if (message.author === game.turn.performer & game.turn.isRunning()) {
    // give next clue as a DM
  };
});
```

## Thanks for reading
I won't go into detail about how I've coded all the game state transitions, but if you're interested you can check out all the code on [GitHub](https://github.com/mattswoon/yeats).

If you've got an improvement or find a bug, submit an issue or PR :)
