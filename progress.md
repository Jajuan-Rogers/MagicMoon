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

- need to fix capturing of split cards

- fix SLOP note at main.lua: 36
    - needs to have a more robust way of fetching images from api and loading them 
      need to learn how coroutines work in lua before then
