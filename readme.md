# MoreVids
A library for showing a score of preroll videos from other games if a given launch option is provided.
This implements [Deck](https://github.com/EntranceJew/Deck) internally.

# Functions
## MoreVids:init()
Set all the variables, call again to reset it.

## MoreVids:parse(launchArgs)
* **launchArgs** `table` A table of launch arguments, preferably directly from love.load(args)
Parse the provided launch arguments for anything inside `MoreVids.validAliases` and if found, kicks off the `MoreVids:preparePreroll()`.

## MoreVids:preparePreroll()
Checks `MoreVids/res` for any media and passes it to its internal playlist, then plays it.

## MoreVids:update(dt)
This is mainly for updating its internal playlist, but it's still necessary.

## MoreVids:draw()
Draws the current playlist item if it is drawable. If the playlist is over this does nothing.

## MoreVids:isActive()
Used to check if the internal playlist is still moving. Used internally by `MoreVids:draw()`.

## MoreVids:skip()
If `MoreVids.allowSkip` is set to true (default) then this will move the internal playlist forward.

# Example
```lua
function love.load(arg)
	movid = require("libraries.MoreVids")
	movid:init()
	movid.playlist.useDebugPrints = true
	
	love._openConsole()
	
	if movid:parse(arg) then
		print("prepare for tickles")
	else
		print("You forgot to specify a valid launch option, you goofball.")
		print("Here's what you did provide: ")
		for k,v in pairs(arg) do print(k,v) end
	end
end

function love.update(dt)
	movid:update(dt)
end

function love.draw()
	if movid:isActive() then
		movid:draw()
	else
		local width = love.graphics.getWidth()
		local height = love.graphics.getHeight()
		
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", 0, 0, width, height)
	end
end

-- skinner's box simulation
function love.keypressed(key, isrepeat)
	movid:skip()
end

function love.mousepressed(x, y, button)
	movid:skip()
end

function love.joystickpressed(joyno, button)
	movid:skip()
end
```

# Sources
I wrote out this section so I don't get sent to SuperJail, even though I'm pretty sure it's very obvious this is meant for parody purposes. I re-encoded these videos myself from their original formats.

Here's where all the videos come from:
* **3DRealmsLogo.ogv** [Duke Nukem Forever]
* **bethesda softworks HD720p.ogv** [Oblivion]
* **BGS_Logo.ogv** [Skyrim]
* **game studios.ogv** [Oblivion]
* **Legal.ogv** [Duke Nukem Forever]
* **LogoTrain.ogv** [F.E.A.R. 3]
* **Prism_Studios.ogv** [Portal Stories: Mel]
* **TriptychLogo.ogv** [Duke Nukem Forever]
* **UE3_logo.ogv** [Grimoire: Manastorm]
* **valve_xbox_legals.ogv** [Left 4 Dead 2]

[Duke Nukem Forever]: http://store.steampowered.com/app/57900/
[Oblivion]: http://store.steampowered.com/app/22330/
[Skyrim]: http://store.steampowered.com/app/72850/
[F.E.A.R. 3]: http://store.steampowered.com/app/21100/
[Portal Stories: Mel]: http://store.steampowered.com/app/317400/
[Grimoire: Manastorm]: http://store.steampowered.com/app/335430/
[Left 4 Dead 2]: http://store.steampowered.com/app/550/