--variables: Level to ignore invites from
local NoNoobs = 1

--sounds
sndBlocked = "Interface\\Addons\\FuckOffNoob\\blocked.mp3";

-- Set up frame
local frame = CreateFrame("Frame", "FuckOffNoobFrame")
frame:RegisterEvent("PARTY_INVITE_REQUEST")
frame:RegisterEvent("ADDON_LOADED")

-- Party Invite Monitor
frame:SetScript("OnEvent", function(self, event, sender)
	if event == "ADDON_LOADED" then
		--probably dont need this
	end			
	if event == "PARTY_INVITE_REQUEST" then
		SendWho(sender)
		local WhoThisName, WhoThisGuild, WhoThisLevel = GetWhoInfo(1)
		if WhoThisLevel <= NoNoobs then
			StaticPopup_Hide("PARTY_INVITE")
			AddIgnore(sender)
			PlaySoundFile(sndBlocked)
		end
	end
end)

-- Filter Whispers
local function myChatFilter(self, event, msg, author, ...)
	SendWho(author)
	local WhoThisName, WhoThisGuild, WhoThisLevel = GetWhoInfo(1)
		if WhoThisLevel <= NoNoobs then
		PlaySoundFile(sndBlocked)
		AddIgnore(author)
		return true
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", myChatFilter)

--[[

THINGS TO DO:
	Suppress /who info.
	Count noobs ignored.
	Allow noob invites from friends.
]]--