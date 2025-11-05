local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Harmony/refs/heads/main/src/init.luau"))();

local Window = Library.new({
	Title = "Dinas Hub Op "..Library.Version,
})

-- Tabs
local MainTab = Window:AddTab({
	Title = "Main",
	Icon = "home"
});

local BoatsTab = Window:AddTab({
	Title = "Boats",
	Icon = "anchor"
});

local PetsTab = Window:AddTab({
	Title = "Pets",
	Icon = "bone"
});

local EggsTab = Window:AddTab({
	Title = "Eggs",
	Icon = "egg"
});

local TrainersTab = Window:AddTab({
	Title = "Trainers",
	Icon = "medal"
});

local BoostTab = Window:AddTab({
	Title = "Boosts",
	Icon = "rocket"
});

local SettingsTab = Window:AddTab({
	Title = "Settings",
	Icon = "settings"
});

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EandF = ReplicatedStorage["E&F"]

-- Variables for storing selected values
local SelectedBoat = "1"
local SelectedTrainer = "T1"
local SelectedPet = "Online_1"
local SelectedEgg = "Egg1"
local SelectedSpinReward = 2
local SelectedBoost = "Coin"

-- Auto toggle variables
local AutoCoins = false
local AutoSpins = false
local AutoSpinReward = false
local AutoBoats = false
local AutoTrainers = false
local AutoPets = false
local AutoEggs = false
local AutoClimb = false
local AutoWin = false
local AutoCandy = false
local AutoBoost = false

-- Main tab
do
	local EconomySection = MainTab:AddSection({
		Title = "Economy"
	});
	
	local SpinSection = MainTab:AddSection({
		Title = "Spin"
	});
	
	local OtherSection = MainTab:AddSection({
		Title = "Money"
	});
	
	local WinAmount = 15
	EconomySection:AddTextbox({
		Title = "Win Amount",
		Placeholder = "15",
		Callback = function(value)
			WinAmount = tonumber(value) or 15
		end,
	});
	
	EconomySection:AddButton({
		Title = "Add Win",
		Callback = function()
			local Event = EandF.Eco.AddEcoRE
			Event:FireServer("win", WinAmount)
		end,
	});
	
	EconomySection:AddToggle({
		Title = "Auto Add Win",
		Default = false,
		Callback = function(value)
			AutoWin = value
			if value then
				spawn(function()
					while AutoWin do
						local Event = EandF.Eco.AddEcoRE
						Event:FireServer("win", WinAmount)
						task.wait(1)
					end
				end)
			end
		end,
	});
	
	local CandyAmount = 1
	EconomySection:AddTextbox({
		Title = "Candy Amount",
		Placeholder = "1",
		Callback = function(value)
			CandyAmount = tonumber(value) or 1
		end,
	});
	
	EconomySection:AddButton({
		Title = "Add Candy",
		Callback = function()
			local Event = EandF.Eco.AddEcoRE
			Event:FireServer("candy", CandyAmount)
		end,
	});
	
	EconomySection:AddToggle({
		Title = "Auto Add Candy",
		Default = false,
		Callback = function(value)
			AutoCandy = value
			if value then
				spawn(function()
					while AutoCandy do
						local Event = EandF.Eco.AddEcoRE
						Event:FireServer("candy", CandyAmount)
						task.wait(1)
					end
				end)
			end
		end,
	});
	
	local ClimbPercent = 0.15
	OtherSection:AddTextbox({
		Title = "Money",
		Placeholder = "0.15",
		Callback = function(value)
			ClimbPercent = tonumber(value) or 0.15
		end,
	});
	
	OtherSection:AddButton({
		Title = "Add Money Percent",
		Callback = function()
			local Event = EandF.Reward.ClaimRewardRE
			Event:FireServer({
				Number = ClimbPercent,
				Type = "ClimbPercent",
				ID = ""
			})
		end,
	});
	
	OtherSection:AddToggle({
		Title = "Auto Add Money Percent",
		Default = false,
		Callback = function(value)
			AutoClimb = value
			if value then
				spawn(function()
					while AutoClimb do
						local Event = EandF.Reward.ClaimRewardRE
						Event:FireServer({
							Number = ClimbPercent,
							Type = "ClimbPercent",
							ID = ""
						})
						task.wait(1)
					end
				end)
			end
		end,
	});
	
	-- Spin Rewards
	local SpinRewardsList = {
		"Reward 1",
		"Reward 2", 
		"Reward 3",
		"Reward 4",
		"Reward 6"
	}
	
	SpinSection:AddDropdown({
		Title = "Select Spin Reward",
		Values = SpinRewardsList,
		Default = "Reward 2",
		Callback = function(value)
			if value == "Reward 1" then
				SelectedSpinReward = 1
			elseif value == "Reward 2" then
				SelectedSpinReward = 2
			elseif value == "Reward 3" then
				SelectedSpinReward = 3
			elseif value == "Reward 4" then
				SelectedSpinReward = 4
			elseif value == "Reward 6" then
				SelectedSpinReward = 6
			end
		end,
	});
	
	SpinSection:AddButton({
		Title = "Get Spin Reward",
		Callback = function()
			local Event = EandF.Spin.GetReward
			Event:InvokeServer(SelectedSpinReward)
		end,
	});
	
	SpinSection:AddToggle({
		Title = "Auto Get Spin Reward",
		Default = false,
		Callback = function(value)
			AutoSpinReward = value
			if value then
				spawn(function()
					while AutoSpinReward do
						local Event = EandF.Spin.GetReward
						Event:InvokeServer(SelectedSpinReward)
						task.wait(1)
					end
				end)
			end
		end,
	});
	
	local SpinAmount = 1
	SpinSection:AddTextbox({
		Title = "Spin Amount",
		Placeholder = "1",
		Callback = function(value)
			SpinAmount = tonumber(value) or 1
		end,
	});
	
	SpinSection:AddButton({
		Title = "Get Spins",
		Callback = function()
			for i = 1, SpinAmount do
				local Event = EandF.Reward.ClaimRewardRE
				Event:FireServer({
					Number = SpinAmount,
					Type = "Spin",
					ID = ""
				})
				task.wait(0.1)
			end
		end,
	});
	
	SpinSection:AddToggle({
		Title = "Auto Get Spins",
		Default = false,
		Callback = function(value)
			AutoSpins = value
			if value then
				spawn(function()
					while AutoSpins do
						local Event = EandF.Reward.ClaimRewardRE
						Event:FireServer({
							Number = SpinAmount,
							Type = "Spin",
							ID = ""
						})
						task.wait(1)
					end
				end)
			end
		end,
	});
end

-- Boosts tab
do
	local BoostList = {
		"Coin",
		"Luck", 
		"Speed",
		"Win",
		"Stamina",
		"Luckx2"
	}
	
	local BoostSection = BoostTab:AddSection({
		Title = "Boost Management"
	});
	
	local AutoBoostSection = BoostTab:AddSection({
		Title = "Automation"
	});
	
	BoostSection:AddDropdown({
		Title = "Select Boost",
		Values = BoostList,
		Default = "Coin",
		Callback = function(value)
			SelectedBoost = value
		end,
	});
	
	local BoostTime = 300
	BoostSection:AddTextbox({
		Title = "Boost Time (seconds)",
		Placeholder = "300",
		Callback = function(value)
			BoostTime = tonumber(value) or 300
		end,
	});
	
	local BoostValue = 0.5
	BoostSection:AddTextbox({
		Title = "Boost Value",
		Placeholder = "0.5",
		Callback = function(value)
			BoostValue = tonumber(value) or 0.5
		end,
	});
	
	BoostSection:AddButton({
		Title = "Activate Boost",
		Callback = function()
			local Event = EandF.Reward.ClaimRewardRE
			Event:FireServer({
				Number = BoostTime,
				Type = "Boost",
				ID = SelectedBoost
			})
		end,
	});
	
	AutoBoostSection:AddToggle({
		Title = "Auto Activate Boost",
		Default = false,
		Callback = function(value)
			AutoBoost = value
			if value then
				spawn(function()
					while AutoBoost do
						local Event = EandF.Reward.ClaimRewardRE
						Event:FireServer({
							Number = BoostTime,
							Type = "Boost",
							ID = SelectedBoost
						})
						task.wait(1)
					end
				end)
			end
		end,
	});
end

-- Boats tab
do
	local BoatsList = {
		"1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
		"11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
		"21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
		"31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41",
		"1001", "1002", "1101", "1102"
	}
	
	local BoatsSection = BoatsTab:AddSection({
		Title = "Boats Management"
	});
	
	local AutoBoatsSection = BoatsTab:AddSection({
		Title = "Automation"
	});
	
	BoatsSection:AddDropdown({
		Title = "Select Boat",
		Values = BoatsList,
		Default = "1",
		Callback = function(value)
			SelectedBoat = value
		end,
	});
	
	BoatsSection:AddButton({
		Title = "Buy Boat",
		Callback = function()
			local Event = EandF.Wings.TryBuyAndUseWingsRF
			Event:InvokeServer(SelectedBoat)
		end,
	});
	
	BoatsSection:AddButton({
		Title = "Equip Boat",
		Callback = function()
			local Event = EandF.Wings["[C-S]EquipPlayerWings"]
			Event:FireServer(SelectedBoat)
		end,
	});
	
	AutoBoatsSection:AddToggle({
		Title = "Auto Buy & Equip",
		Default = false,
		Callback = function(value)
			AutoBoats = value
			if value then
				spawn(function()
					while AutoBoats do
						local BuyEvent = EandF.Wings.TryBuyAndUseWingsRF
						local EquipEvent = EandF.Wings["[C-S]EquipPlayerWings"]
						
						BuyEvent:InvokeServer(SelectedBoat)
						task.wait(0.5)
						EquipEvent:FireServer(SelectedBoat)
						task.wait(1)
					end
				end)
			end
		end,
	});
end

-- Trainers tab
do
	local TrainersList = {
		"T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10",
		"T11", "T12", "T13", "T101", "T102"
	}
	
	local TrainersSection = TrainersTab:AddSection({
		Title = "Trainers Management"
	});
	
	local AutoTrainersSection = TrainersTab:AddSection({
		Title = "Automation"
	});
	
	TrainersSection:AddDropdown({
		Title = "Select Trainer",
		Values = TrainersList,
		Default = "T1",
		Callback = function(value)
			SelectedTrainer = value
		end,
	});
	
	TrainersSection:AddButton({
		Title = "Buy Trainer",
		Callback = function()
			local Event = EandF.Trainner.BuyTrainner
			Event:FireServer(SelectedTrainer)
		end,
	});
	
	AutoTrainersSection:AddToggle({
		Title = "Auto Buy Trainers",
		Default = false,
		Callback = function(value)
			AutoTrainers = value
			if value then
				spawn(function()
					while AutoTrainers do
						local Event = EandF.Trainner.BuyTrainner
						Event:FireServer(SelectedTrainer)
						task.wait(1)
					end
				end)
			end
		end,
	});
end

-- Pets tab
do
	local PetsList = {
		"Online_1", "Online_2", "Online_3",
		"Egg1_1", "Egg1_2", "Egg1_3", "Egg1_4", "Egg1_5",
		"Egg2_1", "Egg2_2", "Egg2_3", "Egg2_4", "Egg2_5",
		"Egg3_1", "Egg3_2", "Egg3_3", "Egg3_4", "Egg3_5",
		"Egg4_1", "Egg4_2", "Egg4_3", "Egg4_4", "Egg4_5",
		"Egg5_1", "Egg5_2", "Egg5_3", "Egg5_4", "Egg5_5",
		"Egg6_1", "Egg6_2", "Egg6_3", "Egg6_4", "Egg6_5",
		"Egg7_1", "Egg7_2", "Egg7_3", "Egg7_4", "Egg7_5",
		"Egg8_1", "Egg8_2", "Egg8_3", "Egg8_4", "Egg8_5",
		"Egg9_1", "Egg9_2", "Egg9_3", "Egg9_4", "Egg9_5",
		"Event_1", "Event_2", "Event_3", "Event_4", "Event_5",
		"Event_11", "Event_12", "Event_13", "Event_14", "Event_15",
		"Halloween_1", "Halloween_2", "Halloween_6", "Halloween_7", "Halloween_8", "Halloween_9", "Halloween_10",
		"GroupPet_1", "Pack_1", "Robux_1", "Robux_2", "Robux_3", "Robux_4", "Robux_5",
		"Robux_6", "Robux_7", "Robux_8", "Robux_9", "Robux_10",
		"Sell_1", "Sell_2", "Sell_3", "Sell_4", "Sell_5", "Sell_6",
		"Shop_1", "Shop_2", "Shop_3", "Shop_4",
		"Sign_1", "Sign_2", "Spin_1"
	}
	
	local PetsSection = PetsTab:AddSection({
		Title = "Pets Management"
	});
	
	local AutoPetsSection = PetsTab:AddSection({
		Title = "Automation"
	});
	
	PetsSection:AddDropdown({
		Title = "Select Pet",
		Values = PetsList,
		Default = "Online_1",
		Callback = function(value)
			SelectedPet = value
		end,
	});
	
	PetsSection:AddButton({
		Title = "Get Pet",
		Callback = function()
			local Event = EandF.Reward.ClaimRewardRE
			Event:FireServer({
				Number = 0,
				Type = "Pet",
				ID = SelectedPet
			})
		end,
	});
	
	AutoPetsSection:AddToggle({
		Title = "Auto Get Pets",
		Default = false,
		Callback = function(value)
			AutoPets = value
			if value then
				spawn(function()
					while AutoPets do
						local Event = EandF.Reward.ClaimRewardRE
						Event:FireServer({
							Number = 0,
							Type = "Pet",
							ID = SelectedPet
						})
						task.wait(1)
					end
				end)
			end
		end,
	});
end

-- Eggs tab
do
	local EggsList = {
		"Egg1", "Egg2", "Egg3", "Egg4", "Egg5", 
		"Egg6", "Egg7", "Egg8", "Egg9",
		"HalloweenEgg", "PetEvent_1", "PetEvent_2", "PetEvent_3",
		"Robux1", "Robux2"
	}
	
	local EggsSection = EggsTab:AddSection({
		Title = "Eggs Management"
	});
	
	local AutoEggsSection = EggsTab:AddSection({
		Title = "Automation"
	});
	
	EggsSection:AddDropdown({
		Title = "Select Egg",
		Values = EggsList,
		Default = "Egg1",
		Callback = function(value)
			SelectedEgg = value
		end,
	});
	
	local OpenAmount = 1
	EggsSection:AddTextbox({
		Title = "Open Amount",
		Placeholder = "1",
		Callback = function(value)
			OpenAmount = tonumber(value) or 1
		end,
	});
	
	EggsSection:AddButton({
		Title = "Open Eggs",
		Callback = function()
			for i = 1, OpenAmount do
				local Event = EandF.Luck["[C-S]DoLuck"]
				Event:InvokeServer(SelectedEgg, 1)
				task.wait(0.1)
			end
		end,
	});
	
	local AutoEggsCount = 1
	AutoEggsSection:AddToggle({
		Title = "Auto Open Eggs",
		Default = false,
		Callback = function(value)
			AutoEggs = value
			if value then
				spawn(function()
					while AutoEggs do
						local Event = EandF.Luck["[C-S]DoLuck"]
						Event:InvokeServer(SelectedEgg, AutoEggsCount)
						task.wait(1)
					end
				end)
			end
		end,
	});
	
	AutoEggsSection:AddTextbox({
		Title = "Amount per Open",
		Placeholder = "1",
		Callback = function(value)
			AutoEggsCount = tonumber(value) or 1
		end,
	});
end

-- Settings
do
	local InfoSection = SettingsTab:AddSection({
		Title = "Information"
	});
	
	InfoSection:AddParagraph({
		Title = 'Dinas Hub',
		Content = "Game automation script\nAll functions collected in convenient interface"
	});

	InfoSection:AddButton({
		Title = "Stop All Automation",
		Callback = function()
			AutoCoins = false
			AutoSpins = false
			AutoSpinReward = false
			AutoBoats = false
			AutoTrainers = false
			AutoPets = false
			AutoEggs = false
			AutoClimb = false
			AutoWin = false
			AutoCandy = false
			AutoBoost = false
			
			Library:Notification({
				Title = "Automation Stopped",
				Content = "All auto functions have been stopped",
				Duration = 3
			})
		end,
	});
end
