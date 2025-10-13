local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tntmaster1385/ServerLib/refs/heads/main/Library/init.lua"))()

local Window = Lib:Window({
	Name = "Dinas Hub Best",
	CurrentTheme = "Ruby",
	Theme = {
		Dark = {
			BrandColor = Color3.fromRGB(255, 0, 0),
			
			TabItemBackgroundColor = Color3.fromRGB(35, 35, 35),
			TabItemHoverColor = Color3.fromRGB(50,50,50),
			Outline = Color3.fromRGB(50, 50, 50),
			Background = Color3.fromRGB(25, 25, 25),
			DropShadow = Color3.fromRGB(20, 20, 20),
			RegularTextColor = Color3.fromRGB(200, 200, 200),
			ShadedTextColor = Color3.fromRGB(150, 150, 150),
			CircularButtonRippleColor = Color3.fromRGB(255, 255, 255),
			NavigationBackgroundColor = Color3.fromRGB(36,36,36),
			SliderFillOutlineColor = Color3.fromRGB(71, 71, 71),
			ToggleBoxColor = Color3.fromRGB(50,50,50),
			CheckmarkColor = Color3.fromRGB(0, 0, 0),
			TopGradientColor = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(41, 41, 41)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(26, 26, 26))},
		},
		
		Midnight = {
			BrandColor = Color3.fromRGB(137, 80, 252),
			
			TabItemBackgroundColor = Color3.fromRGB(30, 30, 45),
			TabItemHoverColor = Color3.fromRGB(50, 45, 70),
			Outline = Color3.fromRGB(50, 45, 70),
			Background = Color3.fromRGB(20, 20, 35),
			DropShadow = Color3.fromRGB(10, 10, 25),
			RegularTextColor = Color3.fromRGB(220, 220, 240),
			ShadedTextColor = Color3.fromRGB(160, 160, 180),
			CircularButtonRippleColor = Color3.fromRGB(200, 180, 255),
			NavigationBackgroundColor = Color3.fromRGB(25, 25, 40),
			SliderFillOutlineColor = Color3.fromRGB(60, 55, 85),
			ToggleBoxColor = Color3.fromRGB(40, 35, 60),
			CheckmarkColor = Color3.fromRGB(20, 20, 35),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(35, 30, 55)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(20, 20, 35))},
			},
		
		Forest = {
			BrandColor = Color3.fromRGB(76, 175, 80),
			
			TabItemBackgroundColor = Color3.fromRGB(40, 50, 40),
			TabItemHoverColor = Color3.fromRGB(60, 80, 60),
			Outline = Color3.fromRGB(50, 70, 50),
			Background = Color3.fromRGB(25, 35, 25),
			DropShadow = Color3.fromRGB(15, 25, 15),
			RegularTextColor = Color3.fromRGB(200, 220, 200),
			ShadedTextColor = Color3.fromRGB(140, 160, 140),
			CircularButtonRippleColor = Color3.fromRGB(180, 220, 180),
			NavigationBackgroundColor = Color3.fromRGB(30, 40, 30),
			SliderFillOutlineColor = Color3.fromRGB(70, 90, 70),
			ToggleBoxColor = Color3.fromRGB(45, 65, 45),
			CheckmarkColor = Color3.fromRGB(25, 35, 25),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(45, 65, 45)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(25, 35, 25))},
			},
		
		Ocean = {
			BrandColor = Color3.fromRGB(33, 150, 243),
			
			TabItemBackgroundColor = Color3.fromRGB(30, 45, 55),
			TabItemHoverColor = Color3.fromRGB(45, 70, 85),
			Outline = Color3.fromRGB(40, 65, 80),
			Background = Color3.fromRGB(20, 35, 45),
			DropShadow = Color3.fromRGB(10, 25, 35),
			RegularTextColor = Color3.fromRGB(200, 230, 255),
			ShadedTextColor = Color3.fromRGB(140, 180, 210),
			CircularButtonRippleColor = Color3.fromRGB(170, 210, 255),
			NavigationBackgroundColor = Color3.fromRGB(25, 40, 50),
			SliderFillOutlineColor = Color3.fromRGB(55, 85, 105),
			ToggleBoxColor = Color3.fromRGB(35, 60, 75),
			CheckmarkColor = Color3.fromRGB(20, 35, 45),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(35, 65, 80)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(20, 35, 45))},
			},
		
		Sunset = {
			BrandColor = Color3.fromRGB(255, 87, 34),
			
			TabItemBackgroundColor = Color3.fromRGB(55, 35, 45),
			TabItemHoverColor = Color3.fromRGB(85, 50, 65),
			Outline = Color3.fromRGB(75, 45, 60),
			Background = Color3.fromRGB(40, 25, 35),
			DropShadow = Color3.fromRGB(30, 15, 25),
			RegularTextColor = Color3.fromRGB(255, 220, 200),
			ShadedTextColor = Color3.fromRGB(200, 160, 150),
			CircularButtonRippleColor = Color3.fromRGB(255, 200, 180),
			NavigationBackgroundColor = Color3.fromRGB(45, 30, 40),
			SliderFillOutlineColor = Color3.fromRGB(95, 60, 75),
			ToggleBoxColor = Color3.fromRGB(65, 40, 55),
			CheckmarkColor = Color3.fromRGB(40, 25, 35),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(70, 45, 60)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(40, 25, 35))},
			},
		
		Cyber = {
			BrandColor = Color3.fromRGB(0, 245, 255),
			
			TabItemBackgroundColor = Color3.fromRGB(20, 25, 45),
			TabItemHoverColor = Color3.fromRGB(30, 40, 70),
			Outline = Color3.fromRGB(0, 180, 255),
			Background = Color3.fromRGB(10, 15, 30),
			DropShadow = Color3.fromRGB(0, 100, 150),
			RegularTextColor = Color3.fromRGB(0, 245, 255),
			ShadedTextColor = Color3.fromRGB(0, 180, 210),
			CircularButtonRippleColor = Color3.fromRGB(0, 200, 255),
			NavigationBackgroundColor = Color3.fromRGB(15, 20, 35),
			SliderFillOutlineColor = Color3.fromRGB(0, 150, 200),
			ToggleBoxColor = Color3.fromRGB(25, 35, 60),
			CheckmarkColor = Color3.fromRGB(10, 15, 30),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(25, 35, 65)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(10, 15, 30))},
			},
		
		Royal = {
			BrandColor = Color3.fromRGB(156, 39, 176),
			
			TabItemBackgroundColor = Color3.fromRGB(45, 30, 55),
			TabItemHoverColor = Color3.fromRGB(65, 45, 80),
			Outline = Color3.fromRGB(70, 50, 85),
			Background = Color3.fromRGB(30, 20, 40),
			DropShadow = Color3.fromRGB(20, 10, 30),
			RegularTextColor = Color3.fromRGB(230, 200, 240),
			ShadedTextColor = Color3.fromRGB(180, 150, 190),
			CircularButtonRippleColor = Color3.fromRGB(210, 170, 230),
			NavigationBackgroundColor = Color3.fromRGB(35, 25, 45),
			SliderFillOutlineColor = Color3.fromRGB(80, 60, 95),
			ToggleBoxColor = Color3.fromRGB(55, 40, 70),
			CheckmarkColor = Color3.fromRGB(30, 20, 40),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(55, 40, 70)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(30, 20, 40))},
			},
		
		Crimson = {
			BrandColor = Color3.fromRGB(220, 20, 60),
			
			TabItemBackgroundColor = Color3.fromRGB(45, 25, 30),
			TabItemHoverColor = Color3.fromRGB(70, 35, 45),
			Outline = Color3.fromRGB(80, 40, 50),
			Background = Color3.fromRGB(30, 15, 20),
			DropShadow = Color3.fromRGB(20, 10, 15),
			RegularTextColor = Color3.fromRGB(255, 200, 200),
			ShadedTextColor = Color3.fromRGB(200, 140, 150),
			CircularButtonRippleColor = Color3.fromRGB(255, 180, 180),
			NavigationBackgroundColor = Color3.fromRGB(35, 20, 25),
			SliderFillOutlineColor = Color3.fromRGB(90, 45, 60),
			ToggleBoxColor = Color3.fromRGB(60, 30, 40),
			CheckmarkColor = Color3.fromRGB(30, 15, 20),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(60, 30, 40)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(30, 15, 20))},
			},
		
		Amber = {
			BrandColor = Color3.fromRGB(255, 193, 7),
			
			TabItemBackgroundColor = Color3.fromRGB(55, 45, 25),
			TabItemHoverColor = Color3.fromRGB(80, 65, 35),
			Outline = Color3.fromRGB(90, 75, 40),
			Background = Color3.fromRGB(40, 30, 15),
			DropShadow = Color3.fromRGB(30, 20, 10),
			RegularTextColor = Color3.fromRGB(255, 240, 200),
			ShadedTextColor = Color3.fromRGB(210, 190, 150),
			CircularButtonRippleColor = Color3.fromRGB(255, 230, 180),
			NavigationBackgroundColor = Color3.fromRGB(45, 35, 20),
			SliderFillOutlineColor = Color3.fromRGB(100, 85, 45),
			ToggleBoxColor = Color3.fromRGB(70, 55, 30),
			CheckmarkColor = Color3.fromRGB(40, 30, 15),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(70, 55, 30)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(40, 30, 15))},
			},
		
		Light = {
			BrandColor = Color3.fromRGB(114, 135, 253),

			TabItemBackgroundColor = Color3.fromRGB(230, 230, 230),
			TabItemHoverColor = Color3.fromRGB(150,150,150),
			Outline = Color3.fromRGB(150,150,150),
			Background = Color3.fromRGB(255, 255, 255),
			DropShadow = Color3.fromRGB(20, 20, 20),
			RegularTextColor = Color3.fromRGB(50, 50, 50),
			ShadedTextColor = Color3.fromRGB(100,100,100),
			CircularButtonRippleColor = Color3.fromRGB(0, 0, 0),
			NavigationBackgroundColor = Color3.fromRGB(255, 255, 255),
			SliderFillOutlineColor = Color3.fromRGB(100,100,100),
			ToggleBoxColor = Color3.fromRGB(255,255,255),
			CheckmarkColor = Color3.fromRGB(255, 255, 255),
			TopGradientColor = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(216, 216, 216))},
		},

		Neon = {
			BrandColor = Color3.fromRGB(0, 255, 128),
			
			TabItemBackgroundColor = Color3.fromRGB(15, 20, 30),
			TabItemHoverColor = Color3.fromRGB(25, 35, 50),
			Outline = Color3.fromRGB(0, 255, 128),
			Background = Color3.fromRGB(10, 15, 25),
			DropShadow = Color3.fromRGB(0, 100, 64),
			RegularTextColor = Color3.fromRGB(0, 255, 128),
			ShadedTextColor = Color3.fromRGB(0, 200, 100),
			CircularButtonRippleColor = Color3.fromRGB(0, 200, 255),
			NavigationBackgroundColor = Color3.fromRGB(12, 18, 28),
			SliderFillOutlineColor = Color3.fromRGB(0, 180, 90),
			ToggleBoxColor = Color3.fromRGB(20, 30, 45),
			CheckmarkColor = Color3.fromRGB(10, 15, 25),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(25, 35, 55)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(10, 15, 25))},
		},

		Lavender = {
			BrandColor = Color3.fromRGB(183, 132, 255),
			
			TabItemBackgroundColor = Color3.fromRGB(50, 40, 65),
			TabItemHoverColor = Color3.fromRGB(70, 55, 90),
			Outline = Color3.fromRGB(140, 100, 200),
			Background = Color3.fromRGB(35, 25, 50),
			DropShadow = Color3.fromRGB(25, 15, 40),
			RegularTextColor = Color3.fromRGB(230, 210, 255),
			ShadedTextColor = Color3.fromRGB(180, 150, 220),
			CircularButtonRippleColor = Color3.fromRGB(200, 170, 240),
			NavigationBackgroundColor = Color3.fromRGB(40, 30, 55),
			SliderFillOutlineColor = Color3.fromRGB(120, 80, 180),
			ToggleBoxColor = Color3.fromRGB(60, 45, 80),
			CheckmarkColor = Color3.fromRGB(35, 25, 50),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(65, 50, 85)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(35, 25, 50))},
		},

		Emerald = {
			BrandColor = Color3.fromRGB(0, 200, 83),
			
			TabItemBackgroundColor = Color3.fromRGB(25, 40, 30),
			TabItemHoverColor = Color3.fromRGB(35, 60, 45),
			Outline = Color3.fromRGB(0, 160, 67),
			Background = Color3.fromRGB(15, 30, 20),
			DropShadow = Color3.fromRGB(10, 20, 15),
			RegularTextColor = Color3.fromRGB(180, 255, 200),
			ShadedTextColor = Color3.fromRGB(120, 200, 150),
			CircularButtonRippleColor = Color3.fromRGB(150, 220, 180),
			NavigationBackgroundColor = Color3.fromRGB(20, 35, 25),
			SliderFillOutlineColor = Color3.fromRGB(0, 140, 58),
			ToggleBoxColor = Color3.fromRGB(30, 50, 35),
			CheckmarkColor = Color3.fromRGB(15, 30, 20),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(35, 55, 40)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(15, 30, 20))},
		},

		CottonCandy = {
			BrandColor = Color3.fromRGB(255, 150, 255),
			
			TabItemBackgroundColor = Color3.fromRGB(60, 40, 65),
			TabItemHoverColor = Color3.fromRGB(80, 55, 85),
			Outline = Color3.fromRGB(255, 180, 255),
			Background = Color3.fromRGB(45, 30, 50),
			DropShadow = Color3.fromRGB(35, 20, 40),
			RegularTextColor = Color3.fromRGB(255, 220, 255),
			ShadedTextColor = Color3.fromRGB(220, 170, 220),
			CircularButtonRippleColor = Color3.fromRGB(255, 200, 255),
			NavigationBackgroundColor = Color3.fromRGB(50, 35, 55),
			SliderFillOutlineColor = Color3.fromRGB(230, 150, 230),
			ToggleBoxColor = Color3.fromRGB(70, 45, 75),
			CheckmarkColor = Color3.fromRGB(45, 30, 50),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(75, 50, 80)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(45, 30, 50))},
		},

		Gold = {
			BrandColor = Color3.fromRGB(255, 215, 0),
			
			TabItemBackgroundColor = Color3.fromRGB(50, 45, 25),
			TabItemHoverColor = Color3.fromRGB(70, 65, 35),
			Outline = Color3.fromRGB(218, 165, 32),
			Background = Color3.fromRGB(35, 30, 15),
			DropShadow = Color3.fromRGB(25, 20, 10),
			RegularTextColor = Color3.fromRGB(255, 240, 180),
			ShadedTextColor = Color3.fromRGB(210, 190, 140),
			CircularButtonRippleColor = Color3.fromRGB(255, 230, 150),
			NavigationBackgroundColor = Color3.fromRGB(40, 35, 20),
			SliderFillOutlineColor = Color3.fromRGB(184, 134, 11),
			ToggleBoxColor = Color3.fromRGB(60, 55, 30),
			CheckmarkColor = Color3.fromRGB(35, 30, 15),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(65, 60, 35)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(35, 30, 15))},
		},

		Slate = {
			BrandColor = Color3.fromRGB(112, 128, 144),
			
			TabItemBackgroundColor = Color3.fromRGB(50, 55, 60),
			TabItemHoverColor = Color3.fromRGB(65, 70, 75),
			Outline = Color3.fromRGB(90, 100, 110),
			Background = Color3.fromRGB(35, 40, 45),
			DropShadow = Color3.fromRGB(25, 30, 35),
			RegularTextColor = Color3.fromRGB(220, 225, 230),
			ShadedTextColor = Color3.fromRGB(170, 175, 180),
			CircularButtonRippleColor = Color3.fromRGB(200, 205, 210),
			NavigationBackgroundColor = Color3.fromRGB(40, 45, 50),
			SliderFillOutlineColor = Color3.fromRGB(80, 90, 100),
			ToggleBoxColor = Color3.fromRGB(55, 60, 65),
			CheckmarkColor = Color3.fromRGB(35, 40, 45),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(60, 65, 70)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(35, 40, 45))},
		},

		Ruby = {
			BrandColor = Color3.fromRGB(224, 17, 95),
			
			TabItemBackgroundColor = Color3.fromRGB(50, 25, 35),
			TabItemHoverColor = Color3.fromRGB(70, 35, 45),
			Outline = Color3.fromRGB(200, 30, 80),
			Background = Color3.fromRGB(35, 15, 25),
			DropShadow = Color3.fromRGB(25, 10, 20),
			RegularTextColor = Color3.fromRGB(255, 200, 210),
			ShadedTextColor = Color3.fromRGB(220, 150, 165),
			CircularButtonRippleColor = Color3.fromRGB(255, 180, 190),
			NavigationBackgroundColor = Color3.fromRGB(40, 20, 30),
			SliderFillOutlineColor = Color3.fromRGB(180, 25, 70),
			ToggleBoxColor = Color3.fromRGB(60, 30, 40),
			CheckmarkColor = Color3.fromRGB(35, 15, 25),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(65, 35, 45)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(35, 15, 25))},
		},

		Arctic = {
			BrandColor = Color3.fromRGB(135, 206, 250),
			
			TabItemBackgroundColor = Color3.fromRGB(30, 45, 60),
			TabItemHoverColor = Color3.fromRGB(45, 65, 85),
			Outline = Color3.fromRGB(100, 180, 255),
			Background = Color3.fromRGB(20, 35, 50),
			DropShadow = Color3.fromRGB(15, 25, 40),
			RegularTextColor = Color3.fromRGB(200, 230, 255),
			ShadedTextColor = Color3.fromRGB(150, 190, 230),
			CircularButtonRippleColor = Color3.fromRGB(170, 210, 250),
			NavigationBackgroundColor = Color3.fromRGB(25, 40, 55),
			SliderFillOutlineColor = Color3.fromRGB(80, 160, 240),
			ToggleBoxColor = Color3.fromRGB(35, 55, 75),
			CheckmarkColor = Color3.fromRGB(20, 35, 50),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(40, 60, 80)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(20, 35, 50))},
		},

		Mint = {
			BrandColor = Color3.fromRGB(152, 255, 203),
			
			TabItemBackgroundColor = Color3.fromRGB(35, 50, 45),
			TabItemHoverColor = Color3.fromRGB(50, 70, 60),
			Outline = Color3.fromRGB(120, 220, 180),
			Background = Color3.fromRGB(25, 40, 35),
			DropShadow = Color3.fromRGB(20, 30, 25),
			RegularTextColor = Color3.fromRGB(220, 255, 235),
			ShadedTextColor = Color3.fromRGB(170, 220, 195),
			CircularButtonRippleColor = Color3.fromRGB(190, 240, 215),
			NavigationBackgroundColor = Color3.fromRGB(30, 45, 40),
			SliderFillOutlineColor = Color3.fromRGB(100, 200, 160),
			ToggleBoxColor = Color3.fromRGB(40, 60, 50),
			CheckmarkColor = Color3.fromRGB(25, 40, 35),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(45, 65, 55)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(25, 40, 35))},
		},

		Obsidian = {
			BrandColor = Color3.fromRGB(100, 100, 120),
			
			TabItemBackgroundColor = Color3.fromRGB(25, 25, 30),
			TabItemHoverColor = Color3.fromRGB(40, 40, 50),
			Outline = Color3.fromRGB(80, 80, 100),
			Background = Color3.fromRGB(15, 15, 20),
			DropShadow = Color3.fromRGB(10, 10, 15),
			RegularTextColor = Color3.fromRGB(180, 180, 200),
			ShadedTextColor = Color3.fromRGB(130, 130, 150),
			CircularButtonRippleColor = Color3.fromRGB(160, 160, 180),
			NavigationBackgroundColor = Color3.fromRGB(20, 20, 25),
			SliderFillOutlineColor = Color3.fromRGB(70, 70, 90),
			ToggleBoxColor = Color3.fromRGB(30, 30, 40),
			CheckmarkColor = Color3.fromRGB(15, 15, 20),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(35, 35, 45)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(15, 15, 20))},
		},

		Solar = {
			BrandColor = Color3.fromRGB(255, 140, 0),
			
			TabItemBackgroundColor = Color3.fromRGB(55, 40, 25),
			TabItemHoverColor = Color3.fromRGB(75, 55, 35),
			Outline = Color3.fromRGB(255, 165, 0),
			Background = Color3.fromRGB(40, 30, 15),
			DropShadow = Color3.fromRGB(30, 20, 10),
			RegularTextColor = Color3.fromRGB(255, 230, 180),
			ShadedTextColor = Color3.fromRGB(220, 190, 140),
			CircularButtonRippleColor = Color3.fromRGB(255, 210, 150),
			NavigationBackgroundColor = Color3.fromRGB(45, 35, 20),
			SliderFillOutlineColor = Color3.fromRGB(230, 145, 0),
			ToggleBoxColor = Color3.fromRGB(65, 50, 30),
			CheckmarkColor = Color3.fromRGB(40, 30, 15),
			TopGradientColor = ColorSequence.new{
				ColorSequenceKeypoint.new(0.000, Color3.fromRGB(70, 55, 35)),
				ColorSequenceKeypoint.new(1.000, Color3.fromRGB(40, 30, 15))},
		}
	},

	DragSnapping = false,
	TopMost = true,
})

local BuyWingEvent = game:GetService("ReplicatedStorage").Events.BuyWing
local EquipWingEvent = game:GetService("ReplicatedStorage").Events.EquipWing
local BuyEnergyEvent = game:GetService("ReplicatedStorage").Events.BuyEnergy
local EggHatchEvent = game:GetService("ReplicatedStorage").Remotes.Eggs.Hatch
local RouletteEvent = game:GetService("ReplicatedStorage").Remotes.Roulette.GiveOutReward
local LayerChangedEvent = game:GetService("ReplicatedStorage").Events.LayerChanged
local RebirthEvent = game:GetService("ReplicatedStorage").Events.Rebirth
local UpgradeEvent = game:GetService("ReplicatedStorage").Events.Upgrade

local AllWings = {
	"Wings1", "Wings2", "Wings3", "Wings4", "Wings5", 
	"Wings6", "Wings7", "Wings8", "Wings9", "Wings10",
	"Wings11", "Wings12", "Wings13", "Wings14", "Wings15",
	"Wings16", "Wings17", "Wings18", "WingsReward1", 
	"WingsRobux1", "WingsRobux2", "WingsRobux3"
}

local AllEnergies = {
	"Energy1", "Energy2", "Energy3", "Energy4", "Energy5",
	"Energy6", "Energy7", "Energy8", "Energy9", "Energy10",
	"Energy11", "Energy12", "Energy13", "Energy14", "Energy15",
	"Energy16", "Energy17", "Energy18", "Energy19", "Energy20",
	"Energy21", "Energy22", "Energy23", "Energy24", "Energy25",
	"Energy26", "Energy27", "Energy28", "Energy29", "Energy30",
	"Energy31", "Energy32", "Energy33", "Energy34", "EnergyReward1",
	"EnergyRobux1", "EnergyRobux2", "EnergyRobux3", "EnergyStarterPack"
}

local AllLayers = {
	"Layer1", "Layer2", "Layer3", "Layer4", "Layer5", "Layer6"
}

local AllEggs = {
	"Basic",
	"Troll", 
	"Crystal",
	"Dark",
	"DarkLava",
	"DarkFrozen",
	"DarkTwilight",
	"TestEgg",
	"GreenBlue",
	"Cactus",
	"DarkKraken",
	"PurpleEgg",
	"DesertThorns",
	"GreenOrange",
	"WhitePurpleBlue"
}

local AllUpgrades = {
	"ChewingPowerUpgrade",
	"ChewingSpeedUpgrade", 
	"DiamondMultUpgrade",
	"DiscountUpgrade",
	"JumpPowerUpgrade",
	"MoneyUpgrade",
	"PassiveChewingUpgrade",
	"RebirthUpgrade"
}

local SelectedEgg = AllEggs[1]

local AutoRebirthEnabled = false
local RebirthDelay = 1

local AutoUpgradeEnabled = false
local UpgradeDelay = 0.5 

local InfiniteMoneyEnabled = false

local function GetUpgradeButton(upgradeName)
	local success, result = pcall(function()
		return game:GetService("Players").LocalPlayer.PlayerGui.UpgradesGUI.Upgrades.Background.ScrollingFrame[upgradeName].Bg.UpgradeButton
	end)
	
	if success and result then
		return result
	end
	return nil
end

do
	local Tab = Window:Tab({
		Name = "Wings Auto Farm",
		Icon = 7733771217,
	})
	
	Tab:Section({Name = "Wings Management"})

	Tab:Button({
		Name = "Buy & Equip ALL Wings",
		Description = "Automatically purchase and equip all available wings",
		Action = function()
			for _, wingName in ipairs(AllWings) do
				BuyWingEvent:FireServer(wingName)
				EquipWingEvent:FireServer(wingName)
				wait(0.05)
			end
		end,
	})
	
	Tab:Button({
		Name = "Buy All Wings",
		Description = "Purchase all wings without equipping",
		Action = function()
			for _, wingName in ipairs(AllWings) do
				BuyWingEvent:FireServer(wingName)
				wait(0.03)
			end
		end,
	})
	
	Tab:Button({
		Name = "Equip All Wings", 
		Description = "Equip all owned wings",
		Action = function()
			for _, wingName in ipairs(AllWings) do
				EquipWingEvent:FireServer(wingName)
				wait(0.03)
			end
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Brainrot Auto Farm",
		Icon = 7733666258,
	})
	
	Tab:Section({Name = "Brainrot Management"})
	
	Tab:Button({
		Name = "Buy ALL Brainrot",
		Description = "Purchase all available brainrot types",
		Action = function()
			for _, energyName in ipairs(AllEnergies) do
				BuyEnergyEvent:FireServer(energyName)
				wait(0.03)
			end
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Eggs Auto Farm",
		Icon = 7743866529,
	})
	
	Tab:Section({Name = "Egg Hatching"})
	
	Tab:Button({
		Name = "Hatch ALL Eggs x3",
		Description = "Hatch 3 of each egg type",
		Action = function()
			for _, eggName in ipairs(AllEggs) do
				for i = 1, 3 do
					EggHatchEvent:InvokeServer(eggName, 1)
					wait(0.1)
				end
			end
		end,
	})
	
	Tab:Button({
		Name = "Hatch ALL Eggs x1",
		Description = "Hatch 1 of each egg type",
		Action = function()
			for _, eggName in ipairs(AllEggs) do
				EggHatchEvent:InvokeServer(eggName, 1)
				wait(0.1)
			end
		end,
	})
	
	Tab:Section({Name = "Individual Eggs"})
	
	local EggOptions = {}
	for _, egg in ipairs(AllEggs) do
		table.insert(EggOptions, {egg, egg})
	end
	
	Tab:Dropdown({
		Name = "Select Egg",
		Options = EggOptions,
		Action = function(Value)
			SelectedEgg = Value
		end,
	})
	
	Tab:Button({
		Name = "Hatch Selected Egg x3",
		Description = "Hatch 3 of the selected egg type",
		Action = function()
			for i = 1, 3 do
				EggHatchEvent:InvokeServer(SelectedEgg, 1)
				wait(0.1)
			end
		end,
	})
	
	Tab:Button({
		Name = "Hatch Selected Egg x1",
		Description = "Hatch 1 of the selected egg type",
		Action = function()
			EggHatchEvent:InvokeServer(SelectedEgg, 1)
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Trophies Auto Farm",
		Icon = 7734053495,
	})
	
	Tab:Section({Name = "Trophies Management"})
	
	Tab:Button({
		Name = "Unlock ALL Trophies",
		Description = "Unlock all 6 victory layers",
		Action = function()
			for _, layerName in ipairs(AllLayers) do
				LayerChangedEvent:FireServer(layerName)
				wait(0.05)
			end
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Auto Rebirth",
		Icon = 7734053495,
	})
	
	Tab:Section({Name = "Rebirth Settings"})
	
	Tab:Button({
		Name = "Single Rebirth",
		Description = "Perform one rebirth",
		Action = function()
			RebirthEvent:FireServer()
		end,
	})
	
	Tab:Toggle({
		Name = "Auto Rebirth",
		Description = "Automatically perform rebirths continuously",
		Toggled = false,
		Action = function(Value)
			AutoRebirthEnabled = Value
			
			if AutoRebirthEnabled then
				spawn(function()
					while AutoRebirthEnabled do
						RebirthEvent:FireServer()
						wait(RebirthDelay)
					end
				end)
			end
		end,
	})
	
	Tab:Slider({
		Name = "Rebirth Delay",
		Description = "Delay between rebirths in seconds",
		Range = {0.1, 10},
		CurrentValue = 1,
		Increment = 0.1,
		Action = function(Value)
			RebirthDelay = Value
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Auto Upgrade",
		Icon = 7734053495,
	})
	
	Tab:Section({Name = "Upgrade Settings"})
	
	Tab:Button({
		Name = "Upgrade ALL",
		Description = "Upgrade all available upgrades once",
		Action = function()
			for _, upgradeName in ipairs(AllUpgrades) do
				local upgradeButton = GetUpgradeButton(upgradeName)
				if upgradeButton then
					UpgradeEvent:FireServer(upgradeButton)
					wait(0.05)
				end
			end
		end,
	})
	
	Tab:Toggle({
		Name = "Auto Upgrade ALL",
		Description = "Continuously upgrade all upgrades automatically",
		Toggled = false,
		Action = function(Value)
			AutoUpgradeEnabled = Value
			
			if AutoUpgradeEnabled then
				spawn(function()
					while AutoUpgradeEnabled do
						for _, upgradeName in ipairs(AllUpgrades) do
							local upgradeButton = GetUpgradeButton(upgradeName)
							if upgradeButton then
								UpgradeEvent:FireServer(upgradeButton)
								wait(0.1)
							end
							
							if not AutoUpgradeEnabled then
								break
							end
						end
						wait(UpgradeDelay)
					end
				end)
			end
		end,
	})
	
	Tab:Slider({
		Name = "Upgrade Delay",
		Description = "Delay between upgrade cycles in seconds",
		Range = {0.1, 5},
		CurrentValue = 0.5,
		Increment = 0.1,
		Action = function(Value)
			UpgradeDelay = Value
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Roulette Rewards", 
		Icon = 7734053495,
	})
	
	Tab:Section({Name = "All Roulette Rewards"})
	
	-- Кнопка для получения ВСЕХ наград из рулетки
	Tab:Button({
		Name = "Claim ALL Roulette Rewards",
		Description = "Get every possible reward from the roulette",
		Action = function()
			print("Claiming all roulette rewards...")
			
			-- Получаем все денежные награды
			for _, reward in ipairs(AllRouletteRewards) do
				if reward.type == "Money" then
					RouletteEvent:FireServer({
						value = reward.value,
						type = "Money",
						chance = reward.chance
					})
					print("Money Reward: " .. reward.value)
					wait(0.05)
				end
			end
			
			-- Получаем все петомцы
			for _, reward in ipairs(AllRouletteRewards) do
				if reward.type == "Pet" then
					RouletteEvent:FireServer({
						type = "Pet",
						name = reward.name,
						rarity = reward.rarity,
						chance = reward.chance
					})
					print("Pet Reward: " .. reward.name)
					wait(0.05)
				end
			end
			
			-- Получаем все зелья
			for _, reward in ipairs(AllRouletteRewards) do
				if reward.type == "Potion" then
					RouletteEvent:FireServer({
						type = "Potion",
						name = reward.name,
						chance = reward.chance
					})
					print("Potion Reward: " .. reward.name)
					wait(0.05)
				end
			end
			
			print("All roulette rewards claimed!")
		end,
	})
	
	Tab:Section({Name = "Individual Rewards"})
	
	Tab:Button({
		Name = "Galactic Paladin Pet",
		Description = "Claim the exclusive Galactic Paladin pet (0.3% chance)",
		Action = function()
			RouletteEvent:FireServer({
				type = "Pet",
				name = "Galactic Paladin",
				rarity = "Exclusive", 
				chance = 0.003
			})
			print("Claimed Galactic Paladin Pet!")
		end,
	})
	
	Tab:Button({
		Name = "All Potions",
		Description = "Claim both ChewingPower and Money potions",
		Action = function()
			RouletteEvent:FireServer({
				type = "Potion",
				name = "ChewingPower",
				chance = 0.097
			})
			wait(0.1)
			RouletteEvent:FireServer({
				type = "Potion", 
				name = "Money",
				chance = 0.15
			})
			print("Claimed all potions!")
		end,
	})
	
	Tab:Button({
		Name = "All Money Rewards",
		Description = "Claim both 5K and 30K money rewards", 
		Action = function()
			RouletteEvent:FireServer({
				type = "Money",
				value = 5000,
				chance = 0.45
			})
			wait(0.1)
			RouletteEvent:FireServer({
				type = "Money",
				value = 30000, 
				chance = 0.3
			})
			print("Claimed all money rewards!")
		end,
	})
end

do
	local Tab = Window:Tab({
		Name = "Infinite Money", 
		Icon = 7734053495,
	})
	
	Tab:Section({Name = "Money Farm"})
	
	Tab:Toggle({
		Name = "Infinite Money",
		Description = "Get unlimited money from roulette (30K per second)",
		Toggled = false,
		Action = function(Value)
			InfiniteMoneyEnabled = Value
			
			if InfiniteMoneyEnabled then
				spawn(function()
					while InfiniteMoneyEnabled do
						RouletteEvent:FireServer({
							type = "Money",
							value = 9e925, 
							chance = 0.3
						})
						wait(0.01)
					end
				end)
			end
		end,
	})
	
	Tab:Button({
		Name = "Get 1 Million",
		Description = "Instantly get 1,000,000 coins",
		Action = function()
			for i = 1, 34 do
				RouletteEvent:FireServer({
					type = "Money",
					value = 30000, 
					chance = 0.3
				})
			end
		end,
	})
	
	Tab:Button({
		Name = "Get 5 Million", 
		Description = "Instantly get 5,000,000 coins",
		Action = function()
			for i = 1, 167 do
				RouletteEvent:FireServer({
					type = "Money",
					value = 30000, 
					chance = 0.3
				})
			end
		end,
	})
	
	Tab:Button({
		Name = "Get 10 Million",
		Description = "Instantly get 10,000,000 coins",
		Action = function()
			for i = 1, 334 do
				RouletteEvent:FireServer({
					type = "Money",
					value = 30000, 
					chance = 0.3
				})
			end
		end,
	})
end
