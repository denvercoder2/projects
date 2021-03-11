------------------------------------------------- Locals
local WS = game:GetService("Workspace")
local PLRS = game:GetService("Players")
local LIGHTING = game:GetService("Lighting")
local RF = game:GetService("ReplicatedStorage")
local RS = game:GetService("ReplicatedStorage")
local SSS = game:GetService("ServerScriptService")
local SS = game:GetService("ServerStorage")
local SG = game:GetService("StarterGui")
local SPack = game:GetService("StarterPack")
local SPlayer = game:GetService("StarterPlayer")
local SService = game:GetService("SoundService")
local Teamss = game:GetService("Teams")
------------------------------------------------- Weirder-Locals
local lightningBool = RS.Bools.LightningBool
local phaseOneBool = RS.Bools.Phase1_Day
local phaseTwoBool = RS.Bools.Phase2_Dusk
local phaseThreeBool = RS.Bools.Phase3_Night
local phaseFourBool = RS.Bools.Phase4_MidNight
local preLength = 5
local warnLength = 5
local inLength = 10
local postLength = 5
local mainGui = SG.MainGui
local Status = game.ReplicatedStorage.StringValues.Status
local bolt = game.ReplicatedStorage.Bools.LightningBool
local chadSurvivors = Teamss.Survivors
local virginiaLobby = Teamss.Lobby
local Remotes = RS.RESs
local fadeEvent = Remotes.roundFade
local soundS = RS.localSounds
local survivor_team = game.Teams.Survivors
local maps = game.ServerStorage.Maps:GetChildren()
local lightingModule = require(script.Parent.LightingModule)
local enValues = RS.Env_Values
local EAmbient = enValues.Ambient
local EBrightness = enValues.Brightness
local EColorShiftB = enValues.ColorShiftB
local EColorShiftT = enValues.ColorShiftT
local Eec = enValues.ExposureCompensation
local EFogColor = enValues.FogColor
local EFogEnd = enValues.FogEnd
local EFogStart = enValues.FogStart
local EOutdoorAmbience = enValues.OutdoorAmbient
local ESS = enValues.ShadowSoftness
local Etod = enValues.TimeOfDay

local lobbyCounter = game.Workspace.Timer.SurfaceGui.Frame.TextBox
local TPort1 
local TPort2 
local TPort3 
local TPort4 
local TPort5
local TPort6 
local TPort7 
local TPort8 
------------------------------------------------- Very Specific Locals
local tickNoise = soundS.Tick
local TSound = soundS.Teleport
local music = Instance.new("Sound", game.Workspace);music.Looped = true
local mainLobby = WS.Lobby
local returnSpot = mainLobby.LobbyReturn
-------------------------------------------------Tables
local LobbySounds = {
	"rbxassetid://2910358347"
}

local GameSounds = {
	"rbxassetid://155791979",
	"rbxassetid://245939390",
	"rbxassetid://4439690368"
}

local TPSound = {
	"rbxassetid://6460019977"

}
------------------------------------------------- Functions

local function placeTeam()
	for i, v in pairs(PLRS:GetChildren()) do
		if v.Team == virginiaLobby then
			v.Team = chadSurvivors
		else
			if v.Team ~= chadSurvivors then
				print("Idk how that happened")
			end
		end
	end
end

local function fixTeams()
	for i, v in pairs(PLRS:GetChildren()) do
		if v.Team == chadSurvivors then
			v.Team = virginiaLobby
		end
	end
end

local function playMusic(arr, count) 
	local id = arr[count]
	music.SoundId = id
end

local function TeleportPlayer(X,Y,Z)
	local target = CFrame.new(X,Y,Z) 
	for i, player in ipairs(game.Players:GetChildren()) do
		--Make sure the character exists and its HumanoidRootPart exists
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			--add an offset of 5 for each character
			player.Character.HumanoidRootPart.CFrame = target
		end
	end
end


local function returnPlayers()
	local lobbySpawn = game.Workspace.Lobby.LobbyReturn
	for i,v in pairs(PLRS:GetChildren()) do
		if v.Team == chadSurvivors then
			print("Returning player ", v, "To spawn")
			TeleportPlayer(lobbySpawn.Position.X,lobbySpawn.Position.Y,lobbySpawn.Position.Z)
		end
	end
end
------------------------------------------------- IFS

--------------------------------------------------MAP STUFF 


------------------------------------Logic
-- the ACTUAL function

local function PickTPortSpot(map)
	TPort1 = {map.TPort1.Position.X, map.TPort1.Position.Y, map.TPort1.Position.Z}
	TPort2 = {map.TPort2.Position.X, map.TPort2.Position.Y, map.TPort2.Position.Z}
	TPort3 = {map.TPort3.Position.X, map.TPort3.Position.Y, map.TPort3.Position.Z}
	TPort4 = {map.TPort4.Position.X, map.TPort4.Position.Y, map.TPort4.Position.Z}
	TPort5 = {map.TPort5.Position.X, map.TPort5.Position.Y, map.TPort5.Position.Z}
	TPort6 = {map.TPort6.Position.X, map.TPort6.Position.Y, map.TPort6.Position.Z}
	TPort7 = {map.TPort7.Position.X, map.TPort7.Position.Y, map.TPort7.Position.Z}
	TPort8 = {map.TPort8.Position.X, map.TPort8.Position.Y, map.TPort8.Position.Z}

	local player_count = game.Players:GetPlayers()
	local TPort_Str = "TPort"
	local TPort
	local hash_map = {}

	hash_map["TPort1"] = TPort1
	hash_map["TPort2"] = TPort2
	hash_map["TPort3"] = TPort3
	hash_map["TPort4"] = TPort4
	hash_map["TPort5"] = TPort5
	hash_map["TPort6"] = TPort6
	hash_map["TPort7"] = TPort7
	hash_map["TPort8"] = TPort8
	

	for i = 1, #player_count, 1 do
		print("Teleporting Players")
		TPort = string.gsub(TPort_Str, 'TPort' ,'TPort'..tostring(i))
		local spot = hash_map[TPort]
		for _, player in pairs(game.Players:GetChildren()) do
			if player.Team == survivor_team then
				TeleportPlayer(spot[1], spot[2], spot[3])
			end
		end
	end
end

local function pickMap(Maps)
	local map_choice = math.random(1, #Maps)
	round_map = Maps[map_choice]
	return round_map
end

local function roundLogic()
	while wait() do
		local music_Count = math.random(1, #LobbySounds)
		playMusic(LobbySounds, music_Count)
		music:Play()	
		for i = preLength, 0, -1 do
			phaseOneBool.Value = true
			phaseTwoBool.Value = false
			phaseThreeBool.Value = false
			phaseFourBool.Value = false
			wait(1)
			Status.Value = ""..i..""
			lobbyCounter.Text = "PreRound: "..i..""
		end
		for i = warnLength, 0, -1 do
			bolt.Value = true --REMEMBER TO CHANGE THIS
			phaseOneBool.Value = false
			phaseTwoBool.Value = true
			phaseThreeBool.Value = false
			phaseFourBool.Value = false
			wait(1)
			Status.Value = ""..i..""
			lobbyCounter.Text = "Warning: "..i..""
			if i <= 2 then
				music:Stop()
				fadeEvent:FireAllClients(i)
			end
		end
		wait(2)
		placeTeam()
		
		round_map = pickMap(maps)
		print(round_map)
--[[		
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local MapToClone = ReplicatedStorage.Maps:WaitForChild(round_map):Clone()
		MapToClone.Parent = game.Workspace

		local map
		if round_map == "NoEH" then
			map = game.Workspace.NoEH
			--CHANGE TO A FUNCTION/LIGHTING STUFF TOO
		elseif round_map == "Noeh2" then
			map = game.Workspace.NoEH2
			--CHANGE TO A FUNCTION/LIGHTING STUFF TOO
		end
		
		
		wait(4)
		--ReplicatedStorage.Maps:WaitForChild(round_map, 15)
]]

		for k,v in ipairs(round_map:GetChildren()) do
			v:Clone().Parent = game.Workspace.CurrentMap
			wait(0.1)						
		end
		
		print("Map loaded: ", round_map)

		PickTPortSpot(round_map)
		music_Count = math.random(1, #GameSounds)
		playMusic(GameSounds, music_Count)
		music:Play()
		for i = inLength, 0, -1 do
			phaseOneBool.Value = false
			phaseTwoBool.Value = false
			phaseThreeBool.Value = true
			phaseFourBool.Value = false
			wait(1)
			Status.Value = ""..i..""
			lobbyCounter.Text = "Round Time: "..i..""
			if i <= 2 then
				fadeEvent:FireAllClients(i)
			end
		end
		music:Stop()
		wait(1)
		returnPlayers()
		
		workspace.CurrentMap:ClearAllChildren()
		for i = postLength, 0, -1 do
			fixTeams()
			phaseOneBool.Value= false
			phaseTwoBool.Value = false
			phaseThreeBool.Value = false
			phaseFourBool.Value = true
			wait(1)
			Status.Value = ""..i..""
			lobbyCounter.Text = "Post Time: "..i..""
		end
	end
end

roundLogic()
