-- Title: Auto Ding
-- Version: 1.0.1
-- Description: Automatically sends a message to guild chat when you level up.
-- Author: Ghost Wolf
-- Reworked from the original "Ding" by VJain

local AutoDing = {}
_G.AutoDing = AutoDing
local frame = _G.AutoDing_Frame
local addonName = "AutoDing"
local addonVersion = "v1.0.1"

--Message will be selected from this list.
local AutoDingMsg = {}
AutoDingMsg[1] = "DING!"
AutoDingMsg[2] = "Woot! Level Up!"
AutoDingMsg[3] = "Ding Ding Ding!"
AutoDingMsg[4] = "Booya - Ding!"
AutoDingMsg[5] = "Ding-a-Ling!"
AutoDingMsg[6] = "Ding Dong!"
AutoDingMsg[7] = "I cyk lvl!"

frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("PLAYER_LEVEL_UP")

function AutoDing:OnEvent(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	self[event](self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

function AutoDing:PLAYER_LEVEL_UP()
	--Determine Levels
		primaryLevel, secondaryLevel = UnitLevel("player")
	
	--Determine Classes
		primaryClass, secondaryClass = UnitClass("player")

	--Send the message to guild chat.
		if IsInGuild(player) then
			i = math.random(table.getn(AutoDingMsg))
			sendMsg = "" .. AutoDingMsg[i] .. " My levels are: " .. primaryClass .. " - " .. primaryLevel .. " / " .. secondaryClass .. " - " .. secondaryLevel .. ""
			SendChatMessage(sendMsg, "GUILD")
		end
end

function AutoDing:VARIABLES_LOADED()

--Load into Addon Manager if fully loaded.
	if AddonManager then
		local addon = {
			name = addonName,
			version = addonVersion,
			author = "Ghost Wolf",
			description = "Automatically sends a message to guild chat when you level up.",
			icon = "Interface/Addons/AutoDing/bell.tga",
			category = "Social",
					}

		if AddonManager.RegisterAddonTable then
			AddonManager.RegisterAddonTable(addon)
		else
			AddonManager.RegisterAddon(addon.name, addon.description, addon.icon, addon.category, 
			addon.configFrame, addon.slashCommand, addon.miniButton, addon.version, addon.author)
		end    

		DEFAULT_CHAT_FRAME:AddMessage(addonName .. " " .. addonVersion .. " loaded successfully!")
	end
end