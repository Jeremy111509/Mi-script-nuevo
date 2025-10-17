--[[
    ======================================
    Mi Primer Script para Delta Executor
    ======================================
    Este script crea una GUI simple para Roblox
    y añade algunas funcionalidades básicas como:
    - Speed Hack (Acelerar la velocidad del jugador)
    - Jump Hack (Aumentar la altura de salto del jugador)
    - Noclip (Atravesar paredes, esto es más complejo y a menudo requiere bypasses)
    - Teletransporte a coordenadas fijas
    - Botón para ocultar/mostrar la GUI

    ¡Importante! Los exploits pueden ser detectados y tu cuenta de Roblox puede ser suspendida.
    Úsalo bajo tu propio riesgo y con fines educativos.
]]

-- 1. CREACIÓN DE LA GUI (Interfaz Gráfica de Usuario)

-- Creamos el contenedor principal invisible para nuestra GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiScriptExecutorGUI"
ScreenGui.ResetOnSpawn = false -- Muy importante para que la GUI no desaparezca al morir

-- Creamos el Frame (la ventana principal de nuestra GUI)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 350) -- Ancho 250, Alto 350
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175) -- Posiciona en el centro de la pantalla
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Color de fondo oscuro
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Borde negro
MainFrame.BorderSizePixel = 1
MainFrame.Active = true -- Permite arrastrar
MainFrame.Draggable = true -- Permite arrastrar la ventana
MainFrame.Parent = ScreenGui

-- Creamos la cabecera del Frame
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 30) -- Ancho completo, Alto 30
Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "🔮 Mi Executor Básico"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Parent = Header

-- Botón para Ocultar/Mostrar la GUI
local ToggleButton = Instance.new("TextButton")
ToggleButton.Text = "X"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.Size = UDim2.new(0, 30, 1, 0)
ToggleButton.Position = UDim2.new(1, -30, 0, 0) -- Posiciona en la esquina superior derecha
ToggleButton.Parent = Header

local IsGUIVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    IsGUIVisible = not IsGUIVisible
    MainFrame.Visible = IsGUIVisible
    if IsGUIVisible then
        ToggleButton.Text = "X"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        ToggleButton.Text = "O" -- O de "mostrar" o un icono similar
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end)


-- 2. FUNCIONES DE LOS BOTONES (Comandos)

-- Función para añadir un botón con un texto y una acción
local function createButton(text, yPosition, clickFunction)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Font = Enum.Font.SourceSans
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Size = UDim2.new(0.9, 0, 0, 40) -- Ancho 90%, Alto 40px
    button.Position = UDim2.new(0.05, 0, 0, yPosition) -- Posición relativa
    button.Parent = MainFrame

    button.MouseButton1Click:Connect(clickFunction) -- Conecta la función al clic
    return button
end

-- Variables globales útiles
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid")

-- Creamos los botones y les asignamos funciones

-- Botón para Speed Hack
createButton("⚡ Speed x2 (32)", 45, function()
    if Humanoid then
        Humanoid.WalkSpeed = 32 -- Doble de la velocidad normal (16)
        Title.Text = "Speed: 32"
    end
end)

-- Botón para Speed Hack x4
createButton("⚡ Speed x4 (64)", 90, function()
    if Humanoid then
        Humanoid.WalkSpeed = 64 -- Cuatro veces la velocidad normal
        Title.Text = "Speed: 64"
    end
end)

-- Botón para Reset Speed
createButton("⚡ Reset Speed", 135, function()
    if Humanoid then
        Humanoid.WalkSpeed = 16 -- Velocidad normal de Roblox
        Title.Text = "Speed: 16 (Normal)"
    end
end)

-- Botón para Jump Hack
createButton("⬆️ Jump Power x2 (100)", 180, function()
    if Humanoid then
        Humanoid.JumpPower = 100 -- Doble de la potencia de salto normal (50)
        Title.Text = "Jump: 100"
    end
end)

-- Botón para Reset Jump Power
createButton("⬆️ Reset Jump Power", 225, function()
    if Humanoid then
        Humanoid.JumpPower = 50 -- Potencia de salto normal
        Title.Text = "Jump: 50 (Normal)"
    end
end)

-- Botón de Teletransporte (ejemplo a una posición fija)
createButton("🏠 Teleport to Base", 270, function()
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0) -- Teletransporta a X=0, Y=100, Z=0
        Title.Text = "Teleported!"
    end
end)


-- 3. INSERCIÓN DE LA GUI EN EL JUEGO (PARA EXECUTORS)

-- Este es el paso crucial. El executor inyecta el script y le da acceso a CoreGui.
ScreenGui.Parent = game:GetService("CoreGui")

-- Pequeña imagen para darle un toque visual
-- (Esto es opcional, solo para el ejemplo visual de un executor)
-- Puedes omitir esto si no quieres una imagen decorativa.
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Size = UDim2.new(0, 40, 0, 40)
ImageLabel.Position = UDim2.new(0.5, -20, 0.5, -20)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Image = "rbxassetid://6034176378" -- ID de una imagen de icono de herramienta de Roblox
ImageLabel.Parent = Header.Parent -- Asegúrate de que se muestre en alguna parte
