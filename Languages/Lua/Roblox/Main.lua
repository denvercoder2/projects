------------------------------------------------- Locals
local WS = game:GetService("Workspace")
local SP = game:GetService("StarterPack")
local SPLR = game:GetService("StarterPlayer")
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
local preLength = 10
local warnLength = 10
local inLength = 10
local postLength = 5
local mainGui = SG.MainGui
local Status = game.ReplicatedStorage.StringValues.Status
local bolt = game.ReplicatedStorage.Bools.LightningBool
local chadSurvivors = Teamss.Survivors
local virginiaLobby = Teamss.Lobby
local Remotes = RS.RESs
local fadeEvent = Remotes.roundFade
local warningEvent = game.ReplicatedStorage.RESs.WarningEvent
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
local monster_team = game.Teams.Monster
local lobbyCounter = game.Workspace.Timer.SurfaceGui.Frame.TextBox

local TPort1 
local TPort2 
local TPort3 
local TPort4 
local TPort5
local TPort6 
local TPort7 
local TPort8 
local KTort

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
	"rbxassetid://4902259058", -- One Winged Angel
	"rbxassetid://314056258", -- Cirno
	"rbxassetid://170955412",  -- Cursed Abbey
	"rbxassetid://191387304", -- TF2
	"rbxassetid://5535591768" -- Girei
}

local TPSound = {
	"rbxassetid://6460019977" -- Basher :]

}

local warningSounds ={
	"rbxassetid://154229993" --MVM Start
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



local function pickMonster()
	local PlayerTable = game:GetService("Players")
	local RandomPlayer = PlayerTable:GetPlayers()[math.random(#PlayerTable:GetPlayers())]
	local monster_name = RandomPlayer.Name
	local character = RS.Monsters.Monster:Clone()
	character.Name = "StarterCharacter"
	character.Parent = SPLR
	RandomPlayer.Team = monster_team
	wait(1)
	RandomPlayer:LoadCharacter()
	character.Parent = nil
	return monster_name	
end

local function destroyMonster()
	local players = game:GetService("Players")
	local checkPlayer = players:GetPlayers()
	if checkPlayer.Team == monster_team then
		checkPlayer:Destroy()
	end
end



local function format(Int)
	return string.format("%02i", Int)
end


local function ConvertTime(seconds)
	seconds = tonumber(seconds)
	local minutes = (seconds - seconds%60)/60
	seconds = seconds - minutes*60
	local hours = (minutes - minutes%60)/60
	minutes = minutes - hours*60
	return format(minutes)..":"..format(seconds)
end

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
	KTort  = {map.KTPort.Position.X, map.KTPort.Position.Y, map.KTPort.Position.Z}
	
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
	hash_map["KTPort"] = KTort

	for i = 1, #player_count, 1 do
		print("Teleporting Players")
		TPort = string.gsub(TPort_Str, 'TPort' ,'TPort'..tostring(i))
		local spot = hash_map[TPort]
		for _, player in pairs(game.Players:GetChildren()) do
			if player.Team == survivor_team then
				print("Chose spot "..spot)
				TeleportPlayer(spot[1], spot[2], spot[3])
			elseif player.Team == monster_team then
				TeleportPlayer(KTort[1], KTort[2], KTort[3])
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
		music:Stop()
		music_Count = math.random(1, #warningSounds)
		playMusic(warningSounds, music_Count)
		music:Play()
		for i = warnLength, 0, -1 do
			bolt.Value = true --REMEMBER TO CHANGE THIS
			phaseOneBool.Value = false
			phaseTwoBool.Value = true
			phaseThreeBool.Value = false
			phaseFourBool.Value = false
			wait(1)
			Status.Value = ""..i..""
			lobbyCounter.Text = "Warning: "..i..""
			if i == warnLength then
				local warningFrame = SG.WARNING.Frame
				warningFrame.Visible = true
				warningEvent:FireAllClients(i)
			end
			if i <= 2 then
				fadeEvent:FireAllClients(i)
				music:Stop()
			end
		end
		wait(2)
		placeTeam()
		
		round_map = pickMap(maps)
		print(round_map)

		for k,v in ipairs(round_map:GetChildren()) do
			v:Clone().Parent = game.Workspace.CurrentMap
			wait(0.1)						
		end		
		print("Map loaded: ", round_map)
		local monster_for_round = pickMonster()
		Status.Value = "Monster for round: " ..monster_for_round
		lobbyCounter.Text = "Monster for round: " ..monster_for_round
		wait(1)
		
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
		clone:Destroy()
		
		
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
