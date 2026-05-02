# Notes



## Deck importing
remember that scryfall will not export a decks 13 Swamp land cards as separate lines.
there will be one line dedicated to the 13 Swamps. I must take that 13 and multiply that 
out so it creates 13 individual cards **BUT** also make sure that it doesnt load in 13 differnt
swamp land images. we must know that we're loading in a basic land and check if we already have 
that lands print already in ram or disk.




# To add/fix 
- need to add the ability to have two commanders
make single commander into a table any way 'normalization'

- [x] need to fix capturing of split cards
- [x] fix SLOP note at main.lua: 36
- [x] needs to have a more robust way of fetching images from api and loading them 
need to learn how coroutines work in lua before then

- [x] make a json api request function or redo original so it works with both
   the latter will likely require clever clode which I wane to to avoid function(name, age, height)
   **Make sure to NORMALIZE all data coming from the fetch function** if this is not done 
   the structure of the table will be different depending on if its coming from a json file, a 
   text file or a scryfall deck link

- [ ] need to reduce the size of functions in main.lua
   calls to load, update and draw need to handle be 
   handled in each entities respective [card.lua](./entities/card.lua)



## Session 5/1/26
- Deck class will be loaded when the game starts and the player selects the deck they want to use. 
we SHOULD NOT create a deck until the players have chosen one to load from A FILE ! YES decks will 
need to be preloaded BEFORE the game starts unlike tabletop sim. Since tabletop covers a wide range 
of card games it doesnt make sense for it to do it that way. 


The following code needs to not be in deck anymore, it does not make any sense for the deck, which will only be created 
when a game is started, to be responsible for downloading files. This function will be moved into the a standalone menu 
module which is where the player will choose there pre-downloaded decks from 

```lua
---@param deck_fp string
---@param deck_url? string scryfall support only (for now)
function Deck:download_new_deck(deck_fp, deck_url)
	if deck_fp then
		local f = io.open(deck_fp, "r")
		if not f then
			return nil, "That file does not exist"
		elseif deck_fp:find(".txt", -5) or deck_fp:find(".json, -5") then
			request.request_deck_from_file(deck_fp)
		end
	elseif deck_url then
		request.request_deck_from_url(deck_url)
	end
end


```


