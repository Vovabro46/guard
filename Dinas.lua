local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- === НАСТРОЙКИ ===
local settings = {
    esp = {enabled = false, names = false, health = false, distance = 150, boxes = false, tracers = false, color = "Red"},
    chams = {enabled = false, color = "Red", transparency = 0.7, rainbow = false},
    aimbot = {
        enabled = true, 
        fov = 120, 
        smooth = 0.12, 
        targetPart = "Head", 
        fovCircle = false, 
        fovColor = "Red",
        autoShoot = false,
        autoWall = false,
        silentAim = false,
        prediction = false,
        predictionAmount = 0.1,
        teamCheck = false,
        visibilityCheck = false,
        triggerKey = Enum.KeyCode.Q,
        triggerDelay = 0.1,
        aimAtDead = false,
        lockOnTarget = false,
        shakeReduction = false,
        humanizer = false,
        humanizerDelay = 0.05
    },
    misc = {speed = 16, jump = 50, fly = false, noclip = false, flyspeed = 50, fps = true}
}

local espObjects = {}
local aimConnection = nil
local isTouchAiming = false
local touchStartTime = 0
local fovCircle = nil
local espConnection = nil
local currentTarget = nil
local triggerDown = false
local lastShotTime = 0

-- === ЦВЕТА ===
local colorMap = {
    Red = Color3.fromRGB(255, 0, 0),
    Green = Color3.fromRGB(0, 255, 0),
    Blue = Color3.fromRGB(0, 150, 255),
    Yellow = Color3.fromRGB(255, 255, 0),
    Pink = Color3.fromRGB(255, 0, 255),
    Cyan = Color3.fromRGB(0, 255, 255),
    White = Color3.fromRGB(255, 255, 255),
    Rainbow = "Rainbow"
}

-- === FOV КРУГ ===
local function createFOVCircle()
    if fovCircle then 
        fovCircle:Remove()
        fovCircle = nil
    end
    
    local circle = Drawing.new("Circle")
    circle.Visible = false
    circle.Radius = settings.aimbot.fov
    circle.Color = colorMap[settings.aimbot.fovColor] or Color3.fromRGB(255, 100, 100)
    circle.Thickness = 2
    circle.Transparency = 0.6
    circle.Filled = false
    circle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    fovCircle = circle
end

local function updateFOVColor()
    if fovCircle then
        if settings.aimbot.fovColor == "Rainbow" then
            fovCircle.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        else
            fovCircle.Color = colorMap[settings.aimbot.fovColor] or Color3.fromRGB(255, 100, 100)
        end
    end
end

-- === УНИВЕРСАЛЬНАЯ ФУНКЦИЯ ВЫСТРЕЛА ===
local function universalShoot()
    if UserInputService.TouchEnabled then
        -- Мобильная версия
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(0.5, 0.5))
    else
        -- ПК версия
        local mouse = player:GetMouse()
        if mouse then
            VirtualInputManager:SendMouseButtonEvent(
                mouse.X, mouse.Y, 0, true, game, 1
            )
            task.wait(0.03)
            VirtualInputManager:SendMouseButtonEvent(
                mouse.X, mouse.Y, 0, false, game, 1
            )
        else
            -- Резервный метод для ПК
            mouse1click()
        end
    end
end

-- === АВТОСТРЕЛЬБА ДЛЯ ПК И ТЕЛЕФОНОВ ===
local function autoShoot()
    if not settings.aimbot.autoShoot or not currentTarget then return end
    
    local now = tick()
    if now - lastShotTime < settings.aimbot.triggerDelay then return end
    
    -- Универсальный выстрел
    universalShoot()
    
    lastShotTime = now
end

-- === ПРОВЕРКА КОМАНДЫ ===
local function isEnemy(plr)
    if not settings.aimbot.teamCheck then return true end
    
    -- Проверка по цвету команды
    if player.Team and plr.Team then
        return player.Team ~= plr.Team
    end
    
    -- Проверка по неймтейгу
    if player:FindFirstChild("leaderstats") and plr:FindFirstChild("leaderstats") then
        return true -- В разных командах
    end
    
    return true -- По умолчанию считать врагом
end

-- === ПРОВЕРКА ВИДИМОСТИ ===
local function isVisible(targetPart)
    if not settings.aimbot.visibilityCheck then return true end
    
    local origin = camera.CFrame.Position
    local target = targetPart.Position
    local direction = (target - origin).Unit
    local ray = Ray.new(origin, direction * 1000)
    
    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character, targetPart.Parent})
    
    if hit then
        return hit:IsDescendantOf(targetPart.Parent)
    end
    
    return true
end

-- === ПРЕДСКАЗАНИЕ ДВИЖЕНИЯ ===
local function getPredictedPosition(targetPart, targetVelocity)
    if not settings.aimbot.prediction then return targetPart.Position end
    
    local distance = (targetPart.Position - camera.CFrame.Position).Magnitude
    local travelTime = distance / 1000 -- Примерная скорость пули
    local prediction = settings.aimbot.predictionAmount * travelTime
    
    return targetPart.Position + targetVelocity * prediction
end

-- === УМНЫЙ AIMBOT ===
local function findBestTarget()
    local bestTarget = nil
    local bestScore = math.huge
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            local hum = plr.Character.Humanoid
            
            -- Проверка условий
            if not settings.aimbot.aimAtDead and hum.Health <= 0 then continue end
            if not isEnemy(plr) then continue end
            
            local targetPart = plr.Character:FindFirstChild(settings.aimbot.targetPart)
            if not targetPart then continue end
            
            -- Проверка видимости
            if not isVisible(targetPart) then continue end
            
            -- Получаем позицию на экране
            local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
            if not onScreen then continue end
            
            -- Вычисляем дистанцию до центра
            local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
            local distToCenter = (screenPoint - screenCenter).Magnitude
            
            -- Вычисляем score (чем меньше - тем лучше)
            local distance3D = (targetPart.Position - camera.CFrame.Position).Magnitude
            local score = distToCenter * 0.7 + distance3D * 0.3 -- Весовые коэффициенты
            
            if distToCenter <= settings.aimbot.fov and score < bestScore then
                bestScore = score
                bestTarget = targetPart
            end
        end
    end
    
    return bestTarget
end

-- === ОСНОВНОЙ AIMBOT ===
local function startAimbot()
    if aimConnection then aimConnection:Disconnect() end

    aimConnection = RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        if not settings.aimbot.enabled then 
            if fovCircle then fovCircle.Visible = false end
            currentTarget = nil
            return 
        end

        -- Поиск цели
        local targetPart = findBestTarget()
        currentTarget = targetPart

        if targetPart then
            -- Получаем предсказанную позицию
            local targetPosition = targetPart.Position
            if settings.aimbot.prediction then
                local targetVelocity = targetPart.Velocity or Vector3.new(0, 0, 0)
                targetPosition = getPredictedPosition(targetPart, targetVelocity)
            end
            
            -- Humanizer задержка
            if settings.aimbot.humanizer then
                wait(settings.aimbot.humanizerDelay)
            end
            
            -- Плавное наведение
            local targetCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
            
            -- Уменьшение тряски
            local smoothness = settings.aimbot.smooth
            if settings.aimbot.shakeReduction then
                smoothness = smoothness * 0.8
            end
            
            camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
            
            -- Автострельба для ПК и телефонов
            if settings.aimbot.autoShoot then
                autoShoot()
            end
        end

        -- FOV круг
        if settings.aimbot.fovCircle and fovCircle then
            fovCircle.Radius = settings.aimbot.fov
            fovCircle.Visible = true
            updateFOVColor()
        else
            if fovCircle then fovCircle.Visible = false end
        end
    end)
end

-- === TRIGGERBOT ДЛЯ ПК И ТЕЛЕФОНОВ ===
local function startTriggerbot()
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        
        if input.KeyCode == settings.aimbot.triggerKey or 
           (UserInputService.TouchEnabled and input.UserInputType == Enum.UserInputType.Touch) then
            
            triggerDown = true
            
            while triggerDown and settings.aimbot.enabled do
                if currentTarget then
                    autoShoot()
                end
                wait(settings.aimbot.triggerDelay)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gp)
        if gp then return end
        
        if input.KeyCode == settings.aimbot.triggerKey or 
           (UserInputService.TouchEnabled and input.UserInputType == Enum.UserInputType.Touch) then
            triggerDown = false
        end
    end)
end

-- === SILENT AIM ===
local function setupSilentAim()
    if settings.aimbot.silentAim then
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "FindPartOnRayWithIgnoreList" and currentTarget then
                -- Подмена ray для silent aim
                local origin = camera.CFrame.Position
                local targetPos = currentTarget.Position
                local direction = (targetPos - origin).Unit
                
                args[1] = Ray.new(origin, direction * 1000)
            end
            
            return oldNamecall(self, unpack(args))
        end)
        
        setreadonly(mt, true)
    end
end

-- === ОПТИМИЗИРОВАННЫЙ ESP ===
local function cleanupAllESP()
    for plr, obj in pairs(espObjects) do
        for _, drawing in pairs(obj.drawings) do
            pcall(function()
                drawing.Visible = false
                drawing:Remove()
            end)
        end
    end
    espObjects = {}
end

local function createESP(plr)
    if espObjects[plr] then return end
    
    local drawings = {
        boxOutline = Drawing.new("Square"),
        boxFill = Drawing.new("Square"),
        tracer = Drawing.new("Line"),
        nameText = Drawing.new("Text"),
        distanceText = Drawing.new("Text"),
        healthBarOutline = Drawing.new("Square"),
        healthBarFill = Drawing.new("Square"),
        healthText = Drawing.new("Text")
    }
    
    for _, drawing in pairs(drawings) do
        drawing.Visible = false
    end
    
    drawings.boxOutline.Color = Color3.new(0, 0, 0)
    drawings.boxOutline.Thickness = 3
    drawings.boxOutline.Filled = false
    
    drawings.boxFill.Thickness = 1
    drawings.boxFill.Filled = true
    drawings.boxFill.Transparency = 0.2
    
    drawings.tracer.Thickness = 2
    drawings.tracer.Transparency = 0.7
    
    drawings.nameText.Color = Color3.new(1, 1, 1)
    drawings.nameText.Size = 16
    drawings.nameText.Center = true
    drawings.nameText.Outline = true
    drawings.nameText.OutlineColor = Color3.new(0, 0, 0)
    drawings.nameText.Font = 2
    
    drawings.distanceText.Color = Color3.fromRGB(100, 200, 255)
    drawings.distanceText.Size = 14
    drawings.distanceText.Center = true
    drawings.distanceText.Outline = true
    drawings.distanceText.OutlineColor = Color3.new(0, 0, 0)
    drawings.distanceText.Font = 2
    
    drawings.healthBarOutline.Color = Color3.new(0, 0, 0)
    drawings.healthBarOutline.Thickness = 2
    drawings.healthBarOutline.Filled = false
    
    drawings.healthBarFill.Thickness = 1
    drawings.healthBarFill.Filled = true
    
    drawings.healthText.Color = Color3.new(1, 1, 1)
    drawings.healthText.Size = 12
    drawings.healthText.Center = true
    drawings.healthText.Outline = true
    drawings.healthText.OutlineColor = Color3.new(0, 0, 0)
    drawings.healthText.Font = 2
    
    espObjects[plr] = {
        drawings = drawings,
        character = nil,
        valid = false
    }
end

local function removeESP(plr)
    if espObjects[plr] then
        for _, drawing in pairs(espObjects[plr].drawings) do
            pcall(function()
                drawing.Visible = false
                drawing:Remove()
            end)
        end
        espObjects[plr] = nil
    end
end

local function updateESP()
    if not settings.esp.enabled then
        cleanupAllESP()
        return
    end

    local currentColor = colorMap[settings.esp.color]
    if settings.esp.color == "Rainbow" then
        currentColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end

    for plr, obj in pairs(espObjects) do
        if not plr or not plr.Parent or not plr.Character then
            removeESP(plr)
        end
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            if not espObjects[plr] then
                createESP(plr)
            end
            
            local obj = espObjects[plr]
            local char = plr.Character
            local valid = char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid")
            
            obj.character = char
            obj.valid = valid
            
            if valid then
                local root = char.HumanoidRootPart
                local hum = char.Humanoid
                
                if hum.Health <= 0 then
                    for _, drawing in pairs(obj.drawings) do
                        drawing.Visible = false
                    end
                else
                    local dist = (player.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    local rootPos, onScreen = camera:WorldToViewportPoint(root.Position)
                    
                    if onScreen and dist <= settings.esp.distance then
                        local boxSize = Vector2.new(2000 / rootPos.Z, 3000 / rootPos.Z)
                        local boxPosition = Vector2.new(rootPos.X - boxSize.X / 2, rootPos.Y - boxSize.Y / 2)
                        
                        obj.drawings.boxFill.Color = currentColor
                        obj.drawings.tracer.Color = currentColor
                        
                        obj.drawings.boxOutline.Visible = settings.esp.boxes
                        obj.drawings.boxFill.Visible = settings.esp.boxes
                        obj.drawings.boxOutline.Size = boxSize
                        obj.drawings.boxFill.Size = boxSize
                        obj.drawings.boxOutline.Position = boxPosition
                        obj.drawings.boxFill.Position = boxPosition
                        
                        obj.drawings.tracer.Visible = settings.esp.tracers
                        obj.drawings.tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                        obj.drawings.tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                        
                        obj.drawings.nameText.Visible = settings.esp.names
                        obj.drawings.nameText.Text = plr.Name
                        obj.drawings.nameText.Position = Vector2.new(rootPos.X, boxPosition.Y - 20)
                        
                        obj.drawings.distanceText.Visible = settings.esp.names
                        obj.drawings.distanceText.Text = math.floor(dist) .. "m"
                        obj.drawings.distanceText.Position = Vector2.new(rootPos.X, boxPosition.Y - 40)
                        
                        local healthPercent = hum.Health / hum.MaxHealth
                        local healthBarWidth = boxSize.X
                        local healthBarHeight = 4
                        local healthBarY = boxPosition.Y + boxSize.Y + 5
                        
                        obj.drawings.healthBarOutline.Visible = settings.esp.health
                        obj.drawings.healthBarFill.Visible = settings.esp.health
                        obj.drawings.healthText.Visible = settings.esp.health
                        
                        obj.drawings.healthBarOutline.Size = Vector2.new(healthBarWidth, healthBarHeight)
                        obj.drawings.healthBarOutline.Position = Vector2.new(boxPosition.X, healthBarY)
                        
                        obj.drawings.healthBarFill.Size = Vector2.new(healthBarWidth * healthPercent, healthBarHeight)
                        obj.drawings.healthBarFill.Position = Vector2.new(boxPosition.X, healthBarY)
                        
                        if healthPercent > 0.7 then
                            obj.drawings.healthBarFill.Color = Color3.fromRGB(50, 255, 50)
                        elseif healthPercent > 0.3 then
                            obj.drawings.healthBarFill.Color = Color3.fromRGB(255, 255, 0)
                        else
                            obj.drawings.healthBarFill.Color = Color3.fromRGB(255, 50, 50)
                        end
                        
                        obj.drawings.healthText.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                        obj.drawings.healthText.Position = Vector2.new(boxPosition.X + healthBarWidth / 2, healthBarY + 8)
                    else
                        for _, drawing in pairs(obj.drawings) do
                            drawing.Visible = false
                        end
                    end
                end
            else
                for _, drawing in pairs(obj.drawings) do
                    drawing.Visible = false
                end
            end
        end
    end
end

-- === УПРАВЛЕНИЕ ESP ===
local function startESP()
    if espConnection then
        espConnection:Disconnect()
    end
    
    espConnection = RunService.RenderStepped:Connect(function()
        updateESP()
    end)
end

local function stopESP()
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    cleanupAllESP()
end

-- === CHAMS ===
local function applyChams(char, enabled)
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            if enabled then
                part.Transparency = settings.chams.transparency
                local col = colorMap[settings.chams.color]
                if settings.chams.rainbow then col = Color3.fromHSV(tick() % 5 / 5, 1, 1) end
                part.Color = col
                part.Material = Enum.Material.ForceField
            else
                part.Transparency = 0
                part.Material = Enum.Material.Plastic
            end
        end
    end
end

-- === PLAYER HANDLER ===
local function onCharacterAdded(char, plr)
    if plr == player then return end
    if settings.chams.enabled then 
        applyChams(char, true) 
    end
end

local function onPlayerRemoving(plr)
    removeESP(plr)
end

-- Инициализация игроков
for _, plr in pairs(Players:GetPlayers()) do
    if plr.Character then onCharacterAdded(plr.Character, plr) end
    plr.CharacterAdded:Connect(function(char) onCharacterAdded(char, plr) end)
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char) onCharacterAdded(char, plr) end)
end)

Players.PlayerRemoving:Connect(onPlayerRemoving)

-- === GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateDevMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 720, 0, 600)
mainFrame.Position = UDim2.new(0.5, -360, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.ZIndex = 10
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(70, 150, 255)
stroke.Thickness = 2.5
stroke.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 55)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
gradient.Rotation = 135
gradient.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundTransparency = 1
header.ZIndex = 11
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "DINAS SCRIPTS"
title.TextColor3 = Color3.fromRGB(100, 180, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 11
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -50, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.ZIndex = 11
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- === СКРОЛЛИНГ КОЛОНКИ ===
local function createScrollingColumn(parent, posX)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, -20, 1, -70)
    frame.Position = UDim2.new(posX, 0, 0, 60)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 11
    frame.Parent = parent

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.ScrollBarImageColor3 = Color3.fromRGB(70, 150, 255)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    scroll.ScrollBarImageTransparency = 0.5
    scroll.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 14)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 5)
    pad.PaddingLeft = UDim.new(0, 5)
    pad.PaddingRight = UDim.new(0, 5)
    pad.Parent = scroll

    local function updateCanvas()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
    updateCanvas()

    return scroll
end

local leftCol = createScrollingColumn(mainFrame, 0)
local rightCol = createScrollingColumn(mainFrame, 0.5)

-- === СЕКЦИЯ ===
local function createSection(parent, title)
    local secTitle = Instance.new("TextLabel")
    secTitle.Size = UDim2.new(1, 0, 0, 28)
    secTitle.BackgroundTransparency = 1
    secTitle.Text = " " .. title
    secTitle.TextColor3 = Color3.fromRGB(100, 180, 255)
    secTitle.Font = Enum.Font.GothamBold
    secTitle.TextSize = 16
    secTitle.TextXAlignment = Enum.TextXAlignment.Left
    secTitle.ZIndex = 11
    secTitle.Parent = parent

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -10, 0, 2)
    line.Position = UDim2.new(0, 5, 1, -2)
    line.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
    line.ZIndex = 11
    line.Parent = secTitle

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.ZIndex = 11
    container.Parent = parent

    local cl = Instance.new("UIListLayout")
    cl.Padding = UDim.new(0, 8)
    cl.Parent = container

    local cp = Instance.new("UIPadding")
    cp.PaddingLeft = UDim.new(0, 15)
    cp.PaddingRight = UDim.new(0, 15)
    cp.Parent = container

    cl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.Size = UDim2.new(1, 0, 0, cl.AbsoluteContentSize.Y)
    end)

    return container
end

-- === TOGGLE ===
local function createToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 11
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "  " .. text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 11
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 56, 0, 28)
    toggle.Position = UDim2.new(1, -60, 0.5, -14)
    toggle.BackgroundColor3 = default and Color3.fromRGB(70, 180, 70) or Color3.fromRGB(55, 55, 55)
    toggle.Text = ""
    toggle.ZIndex = 12
    toggle.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 14)
    tCorner.Parent = toggle

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 22, 0, 22)
    circle.Position = default and UDim2.new(0, 30, 0.5, -11) or UDim2.new(0, 4, 0.5, -11)
    circle.BackgroundColor3 = Color3.new(1,1,1)
    circle.ZIndex = 12
    circle.Parent = toggle

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(toggle, TweenInfo.new(0.25), {BackgroundColor3 = state and Color3.fromRGB(70, 180, 70) or Color3.fromRGB(55, 55, 55)}):Play()
        TweenService:Create(circle, TweenInfo.new(0.25), {Position = state and UDim2.new(0, 30, 0.5, -11) or UDim2.new(0, 4, 0.5, -11)}):Play()
        callback(state)
    end)
end

-- === SLIDER ===
local function createSlider(parent, text, min, max, default, step, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 11
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -100, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = "  " .. text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 11
    label.Parent = frame

    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0, 60, 0, 22)
    valLabel.Position = UDim2.new(1, -70, 0, 0)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = tostring(default)
    valLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    valLabel.Font = Enum.Font.GothamBold
    valLabel.TextSize = 15
    valLabel.ZIndex = 11
    valLabel.Parent = frame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -10, 0, 8)
    track.Position = UDim2.new(0, 5, 0, 32)
    track.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    track.ZIndex = 12
    track.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 4)
    tCorner.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
    fill.ZIndex = 12
    fill.Parent = track

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 4)
    fCorner.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new((default - min)/(max - min), -10, 0.5, -10)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.ZIndex = 13
    knob.Parent = track

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob

    local dragging = false

    local function update(val)
        val = math.clamp(math.round(val / step) * step, min, max)
        local p = (val - min) / (max - min)
        fill.Size = UDim2.new(p, 0, 1, 0)
        knob.Position = UDim2.new(p, -10, 0.5, -10)
        valLabel.Text = tostring(val)
        callback(val)
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mainFrame.Active = false
        end
    end)

    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            mainFrame.Active = true
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = input.Position.X - track.AbsolutePosition.X
            local size = track.AbsoluteSize.X
            if size > 0 then
                local val = min + (pos / size) * (max - min)
                update(val)
            end
        end
    end)

    update(default)
end

-- === ВЫБОР КЛАВИШИ ===
local function createKeybind(parent, text, defaultKey, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 11
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -100, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "  " .. text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 11
    label.Parent = frame

    local keyButton = Instance.new("TextButton")
    keyButton.Size = UDim2.new(0, 80, 0, 28)
    keyButton.Position = UDim2.new(1, -85, 0.5, -14)
    keyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    keyButton.Text = tostring(defaultKey):gsub("Enum.KeyCode.", "")
    keyButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    keyButton.Font = Enum.Font.GothamBold
    keyButton.TextSize = 13
    keyButton.ZIndex = 12
    keyButton.Parent = frame

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(0, 6)
    kCorner.Parent = keyButton

    local listening = false
    
    keyButton.MouseButton1Click:Connect(function()
        listening = true
        keyButton.Text = "..."
        keyButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    end)
    
    UserInputService.InputBegan:Connect(function(input, gp)
        if listening and not gp and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            keyButton.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
            keyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            callback(input.KeyCode)
        end
    end)
end

-- === ВЫБОР ЧАСТИ ТЕЛА ===
local function createPartSelector(parent, text, defaultPart, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 11
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -100, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "  " .. text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 11
    label.Parent = frame

    local partButton = Instance.new("TextButton")
    partButton.Size = UDim2.new(0, 80, 0, 28)
    partButton.Position = UDim2.new(1, -85, 0.5, -14)
    partButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    partButton.Text = defaultPart
    partButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    partButton.Font = Enum.Font.GothamBold
    partButton.TextSize = 13
    partButton.ZIndex = 12
    partButton.Parent = frame

    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(0, 6)
    pCorner.Parent = partButton

    local parts = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
    local currentIndex = 1
    for i, part in ipairs(parts) do
        if part == defaultPart then
            currentIndex = i
            break
        end
    end
    
    partButton.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #parts then currentIndex = 1 end
        partButton.Text = parts[currentIndex]
        callback(parts[currentIndex])
    end)
end

-- === СЕКЦИИ ===
local espSec = createSection(leftCol, "PLAYER VISUALS")
createToggle(espSec, "ESP Enabled", false, function(s) 
    settings.esp.enabled = s 
    if s then
        startESP()
    else
        stopESP()
    end
end)
createToggle(espSec, "Show Names", false, function(s) settings.esp.names = s end)
createToggle(espSec, "Health Bars", false, function(s) settings.esp.health = s end)
createToggle(espSec, "Boxes", false, function(s) settings.esp.boxes = s end)
createToggle(espSec, "Tracers", false, function(s) settings.esp.tracers = s end)
createSlider(espSec, "Max Distance", 10, 500, 150, 10, function(v) settings.esp.distance = v end)

local colorSec = createSection(leftCol, "ESP COLOR")
createToggle(colorSec, "Red", false, function(s) if s then settings.esp.color = "Red" end end)
createToggle(colorSec, "Green", false, function(s) if s then settings.esp.color = "Green" end end)
createToggle(colorSec, "Blue", false, function(s) if s then settings.esp.color = "Blue" end end)
createToggle(colorSec, "Rainbow", false, function(s) if s then settings.esp.color = "Rainbow" end end)

local chamsSec = createSection(leftCol, "CHAMS")
createToggle(chamsSec, "Chams Enabled", false, function(s)
    settings.chams.enabled = s
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then applyChams(plr.Character, s) end
    end
end)
createToggle(chamsSec, "Rainbow", false, function(s) settings.chams.rainbow = s end)
createSlider(chamsSec, "Transparency", 0, 100, 70, 5, function(v) settings.chams.transparency = v/100 end)

-- === РАСШИРЕННЫЙ AIMBOT ===
local aimSec = createSection(rightCol, "AIMBOT - MAIN")
createToggle(aimSec, "Aimbot Enabled", false, function(s) 
    settings.aimbot.enabled = s
    if s then 
        startAimbot() 
        createFOVCircle()
    end
end)
createToggle(aimSec, "FOV Circle", false, function(s) settings.aimbot.fovCircle = s end)
createSlider(aimSec, "FOV", 10, 300, 120, 10, function(v) settings.aimbot.fov = v end)
createSlider(aimSec, "Smoothness", 1, 50, 12, 1, function(v) settings.aimbot.smooth = v/100 end)
createPartSelector(aimSec, "Target Part", "Head", function(part) settings.aimbot.targetPart = part end)

local aimFeatures = createSection(rightCol, "AIMBOT - FUNCTIONS")
createToggle(aimFeatures, "Auto Shoot", false, function(s) settings.aimbot.autoShoot = s end)
createToggle(aimFeatures, "Silent Aim", false, function(s) 
    settings.aimbot.silentAim = s
    if s then setupSilentAim() end
end)
createToggle(aimFeatures, "Prediction", false, function(s) settings.aimbot.prediction = s end)
createSlider(aimFeatures, "Prediction Amount", 1, 50, 10, 1, function(v) settings.aimbot.predictionAmount = v/100 end)
createToggle(aimFeatures, "Team Check", false, function(s) settings.aimbot.teamCheck = s end)
createToggle(aimFeatures, "Visibility Check", false, function(s) settings.aimbot.visibilityCheck = s end)
createToggle(aimFeatures, "Aim at Dead", false, function(s) settings.aimbot.aimAtDead = s end)
createToggle(aimFeatures, "Shake Reduction", false, function(s) settings.aimbot.shakeReduction = s end)
createToggle(aimFeatures, "Humanizer", false, function(s) settings.aimbot.humanizer = s end)
createSlider(aimFeatures, "Humanizer Delay", 1, 20, 5, 1, function(v) settings.aimbot.humanizerDelay = v/100 end)

local triggerSec = createSection(rightCol, "TRIGGERBOT")
createToggle(triggerSec, "Triggerbot", false, function(s) 
    if s then startTriggerbot() end
end)
createKeybind(triggerSec, "Trigger Key", Enum.KeyCode.Q, function(key) settings.aimbot.triggerKey = key end)
createSlider(triggerSec, "Trigger Delay", 1, 50, 10, 1, function(v) settings.aimbot.triggerDelay = v/100 end)

local fovColorSec = createSection(rightCol, "FOV CIRCLE COLOR")
createToggle(fovColorSec, "Red", false, function(s) if s then settings.aimbot.fovColor = "Red"; updateFOVColor() end end)
createToggle(fovColorSec, "Green", false, function(s) if s then settings.aimbot.fovColor = "Green"; updateFOVColor() end end)
createToggle(fovColorSec, "Blue", false, function(s) if s then settings.aimbot.fovColor = "Blue"; updateFOVColor() end end)
createToggle(fovColorSec, "Yellow", false, function(s) if s then settings.aimbot.fovColor = "Yellow"; updateFOVColor() end end)
createToggle(fovColorSec, "Pink", false, function(s) if s then settings.aimbot.fovColor = "Pink"; updateFOVColor() end end)
createToggle(fovColorSec, "Cyan", false, function(s) if s then settings.aimbot.fovColor = "Cyan"; updateFOVColor() end end)
createToggle(fovColorSec, "Rainbow", false, function(s) if s then settings.aimbot.fovColor = "Rainbow" end end)

local miscSec = createSection(rightCol, "MOVEMENT")
createSlider(miscSec, "Walk Speed", 16, 200, 16, 5, function(v)
    settings.misc.speed = v
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = v
    end
end)
createSlider(miscSec, "Jump Power", 50, 200, 50, 5, function(v)
    settings.misc.jump = v
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = v
    end
end)
createToggle(miscSec, "Fly (WASD + Space/Shift)", false, function(s) settings.misc.fly = s; toggleFly(s) end)
createSlider(miscSec, "Fly Speed", 10, 200, 50, 5, function(v) settings.misc.flyspeed = v end)
createToggle(miscSec, "NoClip", false, function(s) settings.misc.noclip = s; toggleNoclip(s) end)

-- === FLY & NOCLIP ===
local flyConnection, noclipConnection
local function toggleFly(enabled)
    if flyConnection then flyConnection:Disconnect() end
    if not enabled then return end

    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(4000,4000,4000)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = root

    flyConnection = RunService.Heartbeat:Connect(function()
        local cam = camera.CFrame
        local vel = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0,1,0) end
        bv.Velocity = vel * settings.misc.flyspeed
    end)
end

local function toggleNoclip(enabled)
    if noclipConnection then noclipConnection:Disconnect() end
    if not enabled then return end

    noclipConnection = RunService.Stepped:Connect(function()
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

-- === FPS ===
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 100, 0, 30)
fpsLabel.Position = UDim2.new(1, -110, 0, 10)
fpsLabel.BackgroundTransparency = 0.7
fpsLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 16
fpsLabel.Text = "FPS: 60"
fpsLabel.Parent = screenGui

RunService.Heartbeat:Connect(function()
    if settings.misc.fps then
        local fps = math.floor(1 / RunService.Heartbeat:Wait())
        fpsLabel.Text = "FPS: " .. fps
        fpsLabel.Visible = true
    else
        fpsLabel.Visible = false
    end
end)

-- === ЗАКРЫТИЕ + РЕСПОНСИВНОСТЬ ===
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

local function updateSize()
    local size = screenGui.AbsoluteSize
    if size.X < 750 then
        mainFrame.Size = UDim2.new(0, size.X - 40, 0, 600)
        mainFrame.Position = UDim2.new(0.5, -(size.X - 40)/2, 0.5, -300)
    else
        mainFrame.Size = UDim2.new(0, 720, 0, 600)
        mainFrame.Position = UDim2.new(0.5, -360, 0.5, -300)
    end
end
screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
updateSize()

-- === ЗАПУСК ===
createFOVCircle()
startAimbot()
startESP()
startTriggerbot()
