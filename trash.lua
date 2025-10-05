local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "My Theme",
    Accent = Color3.fromHex("#18181b"),
    Dialog = Color3.fromHex("#161616"),
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Background = Color3.fromHex("#101010"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a1a1aa")
})

local Window = WindUI:CreateWindow({
    Title = "Dinas Hub Best",
    Icon = "gamepad-2",
    Author = "by Dinas",
})

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Variables
local LocalPlayer = Players.LocalPlayer
local SelectedEgg = "Egg1"
local EggAmount = 1
local CoinAmount = 999999
local WinsAmount = 10

-- Main Tab
local MainTab = Window:Tab({
    Title = "Main Features",
    Icon = "zap",
    Locked = false,
})

-- Egg System
local EggList = {
    "Egg1", "Egg2", "Egg3", "Egg4", "Egg5", "Egg6", "Egg7", 
    "Egg8", "Egg9", "Egg20"
}

local EggDropdown = MainTab:Dropdown({
    Title = "Select Egg Type",
    Desc = "Choose which egg to open",
    Values = EggList,
    Value = "Egg1",
    Multi = false,
    AllowNone = false,
    Callback = function(value)
        SelectedEgg = value
    end
})

local EggAmountSlider = MainTab:Slider({
    Title = "Eggs To Open",
    Desc = "How many eggs to open at once",
    Step = 1,
    Value = {
        Min = 1,
        Max = 1000,
        Default = 1,
    },
    Callback = function(value)
        EggAmount = value
    end
})

local OpenEggButton = MainTab:Button({
    Title = "🎯 Open Selected Eggs",
    Desc = "Open chosen eggs with Luck function",
    Locked = false,
    Callback = function()
        local LuckFunction = ReplicatedStorage.Remote.Function.Luck["[C-S]DoLuck"]
        
        for i = 1, EggAmount do
            LuckFunction:InvokeServer(SelectedEgg, 1)
        end
        
        WindUI:Notify({
            Title = "🎯 Eggs Opened",
            Text = "Opened " .. EggAmount .. " " .. SelectedEgg .. " eggs using Luck function!",
            Duration = 5
        })
    end
})

local MaxCoinsButton = MainTab:Button({
    Title = "Inf Coins",
    Desc = "Get maximum possible coins",
    Locked = false,
    Callback = function()
        local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
        
        for i = 1, 50 do
            ClimbEvent:FireServer("coin", 999999999999999999999999)
        end
        
        WindUI:Notify({
            Title = "💎 Max Coins",
            Text = "Maximum coins added to your account!",
            Duration = 5
        })
    end
})

-- Quick Actions
local QuickOpenButton = MainTab:Button({
    Title = "⚡ Quick Open All Eggs",
    Desc = "Open 10 of every egg type quickly",
    Locked = false,
    Callback = function()
        local LuckFunction = ReplicatedStorage.Remote.Function.Luck["[C-S]DoLuck"]
        
        for _, eggName in pairs(EggList) do
            for i = 1, 10 do
                LuckFunction:InvokeServer(eggName, 1)
            end
        end
        
        WindUI:Notify({
            Title = "⚡ All Eggs Opened",
            Text = "Opened 10 of every egg type using Luck function!",
            Duration = 6
        })
    end
})

local WinTab = Window:Tab({
    Title = "Wins System",
    Icon = "trophy",
    Locked = false,
})

local WinsAmountSlider = WinTab:Slider({
    Title = "Wins Amount",
    Desc = "Set how many wins to get (will send multiple requests)",
    Step = 1,
    Value = {
        Min = 1,
        Max = 10000,
        Default = 100,
    },
    Callback = function(value)
        WinsAmount = value
    end
})

local GetWinsButton = WinTab:Button({
    Title = "🏆 Get Wins",
    Desc = "Get selected amount of wins",
    Locked = false,
    Callback = function()
        local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
        
        WindUI:Notify({
            Title = "🏆 Adding Wins...",
            Text = "Adding " .. WinsAmount .. " wins, please wait...",
            Duration = 5
        })
        
        -- Отправляем множественные запросы по 10 побед за раз
        local requestsNeeded = math.ceil(WinsAmount / 10)
        local winsAdded = 0
        
        for i = 1, requestsNeeded do
            local winsThisRequest = math.min(10, WinsAmount - winsAdded)
            if winsThisRequest > 0 then
                ClimbEvent:FireServer("wins", winsThisRequest)
                winsAdded = winsAdded + winsThisRequest
                wait(0.05) -- Небольшая задержка между запросами
            end
        end
        
        WindUI:Notify({
            Title = "🏆 Wins Added!",
            Text = "Successfully added " .. winsAdded .. " wins to your account!",
            Duration = 5
        })
    end
})

-- Quick Wins Actions
local QuickWins10Button = WinTab:Button({
    Title = "⚡ Quick 10 Wins",
    Desc = "Get 10 wins instantly",
    Locked = false,
    Callback = function()
        local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
        ClimbEvent:FireServer("wins", 10)
        WindUI:Notify({
            Title = "⚡ Quick Wins",
            Text = "10 wins added instantly!",
            Duration = 3
        })
    end
})

local QuickWins100Button = WinTab:Button({
    Title = "⚡ Quick 100 Wins",
    Desc = "Get 100 wins instantly",
    Locked = false,
    Callback = function()
        local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
        ClimbEvent:FireServer("wins", 100)
        WindUI:Notify({
            Title = "⚡ Quick Wins",
            Text = "100 wins added instantly!",
            Duration = 3
        })
    end
})

local QuickWins1000Button = WinTab:Button({
    Title = "⚡ Quick 1000 Wins",
    Desc = "Get 1000 wins instantly",
    Locked = false,
    Callback = function()
        local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
        ClimbEvent:FireServer("wins", 1000)
        WindUI:Notify({
            Title = "⚡ Quick Wins",
            Text = "1000 wins added instantly!",
            Duration = 3
        })
    end
})

-- Auto Farm Tab
local AutoTab = Window:Tab({
    Title = "Auto Farm",
    Icon = "repeat",
    Locked = false,
})

local AutoEggToggle = AutoTab:Toggle({
    Title = "Auto Open Eggs",
    Desc = "Continuously open selected eggs automatically",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        if state then
            spawn(function()
                local LuckFunction = ReplicatedStorage.Remote.Function.Luck["[C-S]DoLuck"]
                while AutoEggToggle:Get() do
                    LuckFunction:InvokeServer(SelectedEgg, 1)
                    wait(0.1)
                end
            end)
        end
    end
})

local AutoCoinsToggle = AutoTab:Toggle({
    Title = "Auto Get Coins",
    Desc = "Continuously get coins automatically",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        if state then
            spawn(function()
                local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
                while AutoCoinsToggle:Get() do
                    ClimbEvent:FireServer("coin", 999999)
                    wait(0.5)
                end
            end)
        end
    end
})

local AutoWinsToggle = AutoTab:Toggle({
    Title = "Auto Get Wins",
    Desc = "Continuously get wins automatically (10 per request)",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        if state then
            spawn(function()
                local ClimbEvent = ReplicatedStorage.Remote.Event.Climb.RE_GrantSlideReward
                while AutoWinsToggle:Get() do
                    ClimbEvent:FireServer("wins", 10)
                    wait(0.5)
                end
            end)
        end
    end
})

-- Advanced Tab
local AdvancedTab = Window:Tab({
    Title = "Advanced",
    Icon = "settings",
    Locked = false,
})

local UltraOpenButton = AdvancedTab:Button({
    Title = "🚀 Ultra Mass Open",
    Desc = "Open 5000+ eggs instantly (May cause lag)",
    Locked = false,
    Callback = function()
        local LuckFunction = ReplicatedStorage.Remote.Function.Luck["[C-S]DoLuck"]
        
        WindUI:Notify({
            Title = "🚀 Ultra Mass Open Started",
            Text = "Opening 5000 " .. SelectedEgg .. " eggs...",
            Duration = 10
        })
        
        for i = 1, 500 do
            LuckFunction:InvokeServer(SelectedEgg, 10)
            wait(0.01)
        end
    end
})

local StropsTab = Window:Tab({
    Title = "Strops System",
    Icon = "ellipsis",
    Locked = false,
})

-- All available strops
local StropList = {
    "strop1", "strop2", "strop3", "strop4", "strop5", "strop6", "strop7", "strop8", "strop9", "strop10",
    "strop11", "strop12", "strop13", "strop14", "strop15", "strop16", "strop17", "strop18", "strop19", "strop20",
    "strop21", "strop22", "strop23", "strop24", "strop25", "strop26", "strop27", "strop28", "strop29", "strop30",
    "strop31", "strop32", "strop33", "strop34", "strop35", "strop36", "strop37", "strop38", "strop39", "strop40",
    "strop41", "strop42", "strop43", "strop44", "strop45", "strop46", "strop47", "strop48", "strop49", "strop50",
    "strop51", "strop52", "strop53", "strop54", "strop55", "strop56", "strop57", "strop58", "strop59", "strop60"
}

local StropDropdown = StropsTab:Dropdown({
    Title = "Select Strop",
    Desc = "Choose which strop to purchase/equip",
    Values = StropList,
    Value = "strop1",
    Multi = false,
    AllowNone = false,
    Callback = function(value)
        SelectedStrop = value
    end
})

local SelectedStrop = "strop1"

local PurchaseStropButton = StropsTab:Button({
    Title = "🛒 Purchase Selected Strop",
    Desc = "Buy the selected strop for free",
    Locked = false,
    Callback = function()
        local PurchaseEvent = ReplicatedStorage.Remote.Event.Strop.RE_TryPurchaseStrop
        
        PurchaseEvent:FireServer(SelectedStrop)
        
        WindUI:Notify({
            Title = "🛒 Strop Purchased",
            Text = "Successfully purchased " .. SelectedStrop .. "!",
            Duration = 4
        })
    end
})

local EquipStropButton = StropsTab:Button({
    Title = "👕 Equip Selected Strop",
    Desc = "Equip the selected strop",
    Locked = false,
    Callback = function()
        local EquipEvent = ReplicatedStorage.Remote.Event.Strop.RE_EquipStrop
        
        EquipEvent:FireServer(SelectedStrop)
        
        WindUI:Notify({
            Title = "👕 Strop Equipped",
            Text = "Successfully equipped " .. SelectedStrop .. "!",
            Duration = 4
        })
    end
})

local PurchaseAndEquipButton = StropsTab:Button({
    Title = "⚡ Purchase & Equip Strop",
    Desc = "Buy and equip selected strop instantly",
    Locked = false,
    Callback = function()
        local PurchaseEvent = ReplicatedStorage.Remote.Event.Strop.RE_TryPurchaseStrop
        local EquipEvent = ReplicatedStorage.Remote.Event.Strop.RE_EquipStrop
        
        PurchaseEvent:FireServer(SelectedStrop)
        EquipEvent:FireServer(SelectedStrop)
        
        WindUI:Notify({
            Title = "⚡ Strop Purchased & Equipped",
            Text = "Successfully purchased and equipped " .. SelectedStrop .. "!",
            Duration = 5
        })
    end
})

-- Mass Strops Actions
local PurchaseAllStropsButton = StropsTab:Button({
    Title = "🎯 Purchase ALL Strops",
    Desc = "Buy every single strop available",
    Locked = false,
    Callback = function()
        local PurchaseEvent = ReplicatedStorage.Remote.Event.Strop.RE_TryPurchaseStrop
        
        WindUI:Notify({
            Title = "🛒 Purchasing All Strops...",
            Text = "Buying all 60 strops, please wait...",
            Duration = 8
        })
        
        for _, stropName in pairs(StropList) do
            PurchaseEvent:FireServer(stropName)
            wait(0.05)
        end
        
        WindUI:Notify({
            Title = "🎯 All Strops Purchased!",
            Text = "Successfully purchased all 60 strops!",
            Duration = 6
        })
    end
})

local EquipAllStropsButton = StropsTab:Button({
    Title = "👕 Equip ALL Strops",
    Desc = "Equip every strop one by one",
    Locked = false,
    Callback = function()
        local EquipEvent = ReplicatedStorage.Remote.Event.Strop.RE_EquipStrop
        
        WindUI:Notify({
            Title = "👕 Equipping All Strops...",
            Text = "Equipping all 60 strops, please wait...",
            Duration = 8
        })
        
        for _, stropName in pairs(StropList) do
            EquipEvent:FireServer(stropName)
            wait(0.05)
        end
        
        WindUI:Notify({
            Title = "👕 All Strops Equipped!",
            Text = "Successfully equipped all 60 strops!",
            Duration = 6
        })
    end
})

local AutoStropsButton = StropsTab:Button({
    Title = "🚀 AUTO: Purchase & Equip ALL",
    Desc = "Automatically purchase and equip every strop",
    Locked = false,
    Callback = function()
        local PurchaseEvent = ReplicatedStorage.Remote.Event.Strop.RE_TryPurchaseStrop
        local EquipEvent = ReplicatedStorage.Remote.Event.Strop.RE_EquipStrop
        
        WindUI:Notify({
            Title = "🚀 Auto Strops Started",
            Text = "Purchasing and equipping all strops...",
            Duration = 10
        })
        
        for _, stropName in pairs(StropList) do
            PurchaseEvent:FireServer(stropName)
            EquipEvent:FireServer(stropName)
            wait(0.03)
        end
        
        WindUI:Notify({
            Title = "🚀 Auto Strops Complete!",
            Text = "All strops purchased and equipped successfully!",
            Duration = 6
        })
    end
})

-- Player Tab
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user",
    Locked = false,
})

local WalkSpeedSlider = PlayerTab:Slider({
    Title = "Walk Speed",
    Desc = "Adjust player walk speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = 16,
    },
    Callback = function(value)
        getgenv().CustomWalkSpeed = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

local JumpPowerSlider = PlayerTab:Slider({
    Title = "Jump Power",
    Desc = "Adjust player jump power",
    Step = 1,
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        getgenv().CustomJumpPower = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end
})

local AntiAFKToggle = PlayerTab:Toggle({
    Title = "Anti-AFK",
    Desc = "Prevent being kicked for AFK",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        if state then
            LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

-- Auto-apply player modifications
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    
    if getgenv().CustomWalkSpeed then
        character.Humanoid.WalkSpeed = getgenv().CustomWalkSpeed
    end
    
    if getgenv().CustomJumpPower then
        character.Humanoid.JumpPower = getgenv().CustomJumpPower
    end
end)
