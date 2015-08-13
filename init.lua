-- hail satan
local MoreVids = {
	_VERSION     = 'MoreVids v1.0.0',
	_DESCRIPTION = 'A library for showing preroll vids from other games.',
	_URL         = 'https://github.com/EntranceJew/MoreVids',
}
local weLiveHere = ...

local function tableContains(table, element)
	for _, value in pairs(table) do
		if value == element then
		  return true
		end
	end
	return false
end

local function contextScale(maxWidth, maxHeight, curWidth, curHeight)
	local scalex, scaley = 1, 1
	
	scalex = maxWidth/curWidth
	scaley = maxHeight/curHeight
	
	return scalex, scaley
end

-- == public stuff
function MoreVids:init()
	self.playlist = require(weLiveHere..".libraries.deck.deck")
	self.playlist:init()
	self.validAliases = {
		'-morevid',
		'-morevids',
		'morevid',
		'morevids',
		'-movid',
		'-movids',
		'movid',
		'movids',
	}
	-- how much of their time do we want to allow them to waste?
	self.allowSkip = true
end

function MoreVids:parse(launchArgs)
	if not launchArgs then
		return false
	end
	
	for k,v in pairs(self.validAliases) do
		if tableContains(launchArgs, v) then
			self:preparePreroll()
			return true
		end
	end
	
	return false
end

function MoreVids:preparePreroll()
	local live = string.gsub(weLiveHere, "%.", "/")
	self.playlist:insertDirectory(live.."/res")
	self.playlist:play()
end

function MoreVids:update(dt)
	self.playlist:update(dt)
end

function MoreVids:draw()
	if self:isActive() then
		local item = self.playlist:getCurrentItem()
		if item and item:typeOf("Drawable") then
			local scalex, scaley = contextScale(
				love.graphics.getWidth(),
				love.graphics.getHeight(),
				item:getWidth(),
				item:getHeight()
			)
			love.graphics.draw(item, 0, 0, 0, scalex, scaley)
		end
	end
end

function MoreVids:isActive()
	return self.playlist.playState == 'play'
end

function MoreVids:skip()
	if self.allowSkip then
		return self.playlist:next()
	else
		return false
	end
end

return MoreVids