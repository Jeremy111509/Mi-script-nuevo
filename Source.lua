--[[
    ======================================
    Script Mejorado: Velocidad, Salto Editable e Invisibilidad
    ======================================
]]

-- 1. CREACIÓN DE LA GUI (Interfaz Gráfica de Usuario)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiScriptExecutorGUI"
ScreenGui.ResetOnSpawn = false 

-- Variables de personaje globales (necesarias para las funciones)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
-- Esperamos a que el personaje exista y tenga el Humanoid (necesario para velocidad y salto)
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid")
local RootPart = Character:FindFirstChild("HumanoidRootPart")

-- Creamos el Frame (la ventana principal de nuestra GUI)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 480) -- Ventana un poco más grande
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 1
MainFrame.Active = true 
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Creamos la cabecera
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "✨ Executor Pro Editado"
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
ToggleButton.Position = UDim2.new(1, -30, 0, 0)
ToggleButton.Parent = Header

local IsGUIVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    IsGUIVisible = not IsGUIVisible
    MainFrame.Visible = IsGUIVisible
    if IsGUIVisible then
        ToggleButton.Text = "X"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        ToggleButton.Text = "O"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end)

-- 2. FUNCIONES DE EDICIÓN Y BOTONES

-- Estructura para crear una etiqueta y una caja de texto (para editar valores)
local function createInputGroup(label, yPosition, placeholderText)
    -- Etiqueta
    local Label = Instance.new("TextLabel")
    Label.Text = label
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.9, 0, 0, 20)
    Label.Position = UDim2.new(0.05, 0, 0, yPosition)
    Label.Parent = MainFrame

    -- Caja de texto (TextBox)
    local TextBox = Instance.new("TextBox")
    TextBox.Text = placeholderText -- Valor predeterminado
    TextBox.PlaceholderText = placeholderText
    TextBox.TextSize = 16
    TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    TextBox.Size = UDim2.new(0.9, 0, 0, 30)
    TextBox.Position = UDim2.new(0.05, 0, 0, yPosition + 25)
    TextBox.Parent = MainFrame
    
    return TextBox
end

-- Creamos los campos de entrada
local SpeedInput = createInputGroup("🏃 Velocidad (WalkSpeed):", 40, "16")
local JumpInput = createInputGroup("🚀 Potencia de Salto (JumpPower):", 120, "50")


-- Función para aplicar la Velocidad
local ApplySpeedButton = Instance.new("TextButton")
ApplySpeedButton.Text = "APLICAR VELOCIDAD"
ApplySpeedButton.Font = Enum.Font.SourceSansBold
ApplySpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplySpeedButton.TextSize = 16
ApplySpeedButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) -- Verde
ApplySpeedButton.Size = UDim2.new(0.9, 0, 0, 40)
ApplySpeedButton.Position = UDim2.new(0.05, 0, 0, 170)
ApplySpeedButton.Parent = MainFrame

ApplySpeedButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(SpeedInput.Text)
    if Humanoid and newSpeed and newSpeed > 0 then
        Humanoid.WalkSpeed = newSpeed
        Title.Text = "Velocidad establecida a: " .. newSpeed
    else
        Title.Text = "Error: Velocidad no válida"
    end
end)

-- Función para aplicar el Salto
local ApplyJumpButton = Instance.new("TextButton")
ApplyJumpButton.Text = "APLICAR SALTO"
ApplyJumpButton.Font = Enum.Font.SourceSansBold
ApplyJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyJumpButton.TextSize = 16
ApplyJumpButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) -- Verde
ApplyJumpButton.Size = UDim2.new(0.9, 0, 0, 40)
ApplyJumpButton.Position = UDim2.new(0.05, 0, 0, 250)
ApplyJumpButton.Parent = MainFrame

ApplyJumpButton.MouseButton1Click:Connect(function()
    local newJump = tonumber(JumpInput.Text)
    if Humanoid and newJump and newJump > 0 then
        Humanoid.JumpPower = newJump
        Title.Text = "Salto establecido a: " .. newJump
    else
        Title.Text = "Error: Salto no válido"
    end
end)

-- Botón de TOGGLE INVISIBILIDAD
local IsInvisible = false
local InvisibleButton = Instance.new("TextButton")
InvisibleButton.Text = "👻 ACTIVAR INVISIBILIDAD"
InvisibleButton.Font = Enum.Font.SourceSansBold
InvisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisibleButton.TextSize = 16
InvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 150) -- Púrpura
InvisibleButton.Size = UDim2.new(0.9, 0, 0, 40)
InvisibleButton.Position = UDim2.new(0.05, 0, 0, 330)
InvisibleButton.Parent = MainFrame

InvisibleButton.MouseButton1Click:Connect(function()
    IsInvisible = not IsInvisible
    
    if IsInvisible then
        -- 1. Invisibilidad: recorre todas las partes del personaje y las hace transparentes
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                part.Transparency = 1 -- 1.0 es completamente invisible
            end
        end
        InvisibleButton.Text = "✅ INVISIBILIDAD ACTIVA (Haz clic para desactivar)"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        Title.Text = "¡Eres invisible!"
    else
        -- 2. Restaurar la visibilidad
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                part.Transparency = 0 -- 0.0 es completamente visible
            end
        end
        InvisibleButton.Text = "👻 ACTIVAR INVISIBILIDAD"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 150)
        Title.Text = "Visibilidad restaurada."
    end
end)

-- Botón de Teletransporte (como el anterior)
local TeleportButton = Instance.new("TextButton")
TeleportButton.Text = "🏠 Teleport a X=0, Y=100, Z=0"
TeleportButton.Font = Enum.Font.SourceSans
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.TextSize = 16
TeleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TeleportButton.Size = UDim2.new(0.9, 0, 0, 40)
TeleportButton.Position = UDim2.new(0.05, 0, 0, 400)
TeleportButton.Parent = MainFrame

TeleportButton.MouseButton1Click:Connect(function()
    if RootPart then
        RootPart.CFrame = CFrame.new(0, 100, 0) 
        Title.Text = "¡Teletransportado a 0, 100, 0!"
    end
end)

-- 3. INSERCIÓN DE LA GUI EN EL JUEGO (PARA EXECUTORS)
ScreenGui.Parent = game:GetService("CoreGui")

