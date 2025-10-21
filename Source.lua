--[[
    ================================================================
    SCRIPT 1 (PRINCIPAL): Menú de Habilidades y Receptor de Coordenadas
    ================================================================
]]

-- 1. CONFIGURACIÓN DE VARIABLES GLOBALES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid")
local RootPart = Character:FindFirstChild("HumanoidRootPart")

-- CREAMOS UN VALOR PARA COMUNICAR COORDENADAS CON EL SCRIPT 2
local TeleportValue = Instance.new("StringValue")
TeleportValue.Name = "GuiaDeCoordenadasBrainrot" 
TeleportValue.Value = ""
-- Lo insertaremos en la GUI más tarde


-- 2. CREACIÓN DEL CONTENEDOR PRINCIPAL Y VENTANA

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiScriptExecutorGUI"
ScreenGui.ResetOnSpawn = false 
ScreenGui.Parent = game:GetService("CoreGui")

-- Insertamos el valor de comunicación aquí
TeleportValue.Parent = ScreenGui 

-- La Ventana Principal (MainFrame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 480) 
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 1
MainFrame.Active = true 
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false -- Empieza oculto

-- Cabecera y Título
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "✨ Executor Pro Final"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -30, 1, 0) 
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Parent = Header

-- 3. CREACIÓN DEL BOTÓN FLOTANTE Y BOTÓN DE CIERRE "X"

-- Botón de Cierre "X" (para minimizar al botón flotante)
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0) 
CloseButton.Parent = Header

-- Botón de Minimizado Flotante ("Bolita" - TextButton)
local MinimizationButton = Instance.new("TextButton")
MinimizationButton.Name = "MinimizationButton"
MinimizationButton.BackgroundTransparency = 0 
MinimizationButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255) 
MinimizationButton.Text = "MENU" 
MinimizationButton.Font = Enum.Font.SourceSansBold
MinimizationButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizationButton.TextSize = 14
MinimizationButton.Size = UDim2.new(0, 50, 0, 50) 
MinimizationButton.Position = UDim2.new(1, -60, 0.2, 0) 
MinimizationButton.ZIndex = 10 
MinimizationButton.Parent = ScreenGui 
MinimizationButton.Draggable = true 

-- Conexión de Clic para la bolita
MinimizationButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true 
    MinimizationButton.Visible = false 
end)

-- Conexión de Clic para el botón 'X'
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false 
    MinimizationButton.Visible = true 
end)


-- 4. FUNCIONES DE VELOCIDAD, SALTO E INVISIBILIDAD

-- Función para crear una caja de texto con etiqueta
local function createInputGroup(label, yPosition, placeholderText)
    local Label = Instance.new("TextLabel")
    Label.Text = label
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.9, 0, 0, 20)
    Label.Position = UDim2.new(0.05, 0, 0, yPosition)
    Label.Parent = MainFrame

    local TextBox = Instance.new("TextBox")
    TextBox.Text = placeholderText 
    TextBox.PlaceholderText = placeholderText
    TextBox.TextSize = 16
    TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    TextBox.Size = UDim2.new(0.9, 0, 0, 30)
    TextBox.Position = UDim2.new(0.05, 0, 0, yPosition + 25)
    TextBox.Parent = MainFrame
    
    return TextBox
end

-- Campos de entrada
local SpeedInput = createInputGroup("🏃 Velocidad (WalkSpeed):", 40, "200") 
local JumpInput = createInputGroup("🚀 Potencia de Salto (JumpPower):", 120, "150") 

-- Botón Aplicar Velocidad
local ApplySpeedButton = Instance.new("TextButton")
ApplySpeedButton.Text = "APLICAR VELOCIDAD"
ApplySpeedButton.Font = Enum.Font.SourceSansBold
ApplySpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplySpeedButton.TextSize = 16
ApplySpeedButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) 
ApplySpeedButton.Size = UDim2.new(0.9, 0, 0, 40)
ApplySpeedButton.Position = UDim2.new(0.05, 0, 0, 170)
ApplySpeedButton.Parent = MainFrame

ApplySpeedButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(SpeedInput.Text) or 16 
    local safeSpeed = math.min(newSpeed, 2000) 
    
    if Humanoid and safeSpeed >= 16 then
        Humanoid.WalkSpeed = safeSpeed
        Title.Text = "Velocidad establecida a: " .. safeSpeed
        if newSpeed > 2000 then 
            Title.Text = "Máx. Velocidad aplicada: 2000"
        end
    else
        Title.Text = "Error: Velocidad mínima es 16"
    end
end)

-- Botón Aplicar Salto
local ApplyJumpButton = Instance.new("TextButton")
ApplyJumpButton.Text = "APLICAR SALTO"
ApplyJumpButton.Font = Enum.Font.SourceSansBold
ApplyJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyJumpButton.TextSize = 16
ApplyJumpButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50) 
ApplyJumpButton.Size = UDim2.new(0.9, 0, 0, 40)
ApplyJumpButton.Position = UDim2.new(0.05, 0, 0, 250)
ApplyJumpButton.Parent = MainFrame

ApplyJumpButton.MouseButton1Click:Connect(function()
    local newJump = tonumber(JumpInput.Text) or 50
    local safeJump = math.min(newJump, 500) 
    
    if Humanoid and safeJump >= 50 then
        Humanoid.JumpPower = safeJump
        Title.Text = "Salto establecido a: " .. safeJump
    else
        Title.Text = "Error: Salto no válido"
    end
end)

-- Botón de TOGGLE INVISIBILIDAD (PHANTOM MODE)
local IsInvisible = false
local InvisibleButton = Instance.new("TextButton")
InvisibleButton.Text = "👻 ACTIVAR PHANTOM MODE (RIESGO)"
InvisibleButton.Font = Enum.Font.SourceSansBold
InvisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisibleButton.TextSize = 16
InvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 150) 
InvisibleButton.Size = UDim2.new(0.9, 0, 0, 40)
InvisibleButton.Position = UDim2.new(0.05, 0, 0, 330)
InvisibleButton.Parent = MainFrame

InvisibleButton.MouseButton1Click:Connect(function()
    IsInvisible = not IsInvisible
    
    if IsInvisible then
        InvisibleButton.Text = "✅ PHANTOM ACTIVO (Desactivar)"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        Title.Text = "¡Personaje desaparecido!"

        -- 1. Forzar la transparencia total (para que ni tú te veas)
        for _, item in pairs(Character:GetDescendants()) do
            if item:IsA("BasePart") or item:IsA("Decal") or item:IsA("MeshPart") then
                item.Transparency = 1 
            elseif item:IsA("Accessory") then
                if item:FindFirstChildOfClass("BasePart") then
                    item:FindFirstChildOfClass("BasePart").Transparency = 1
                end
            end
            if item.Name == "HumanoidRootPart" then
                 item.Transparency = 1
            end
        end

        -- 2. MOVEMOS las partes para romper el render de otros
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Parent = nil 
            elseif part:IsA("Accessory") then
                part.Parent = nil
            elseif part:IsA("Shirt") or part:IsA("Pants") then
                part.Parent = nil
            end
        end

    else -- Desactivar Phantom Mode
        
        InvisibleButton.Text = "👻 ACTIVAR PHANTOM MODE (RIESGO)"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 150)
        Title.Text = "Visibilidad restaurada. (Forzando Respawn)"

        -- Restaurar: Obliga a recargar el personaje
        LocalPlayer:LoadCharacter()

    end
end)

-- Botón de Teletransporte a Coordenada Guardada
local TeleportButton = Instance.new("TextButton")
TeleportButton.Text = "🏠 TELEPORTAR A COORDENADA GUARDADA"
TeleportButton.Font = Enum.Font.SourceSans
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.TextSize = 16
TeleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TeleportButton.Size = UDim2.new(0.9, 0, 0, 40)
TeleportButton.Position = UDim2.new(0.05, 0, 0, 400)
TeleportButton.Parent = MainFrame

TeleportButton.MouseButton1Click:Connect(function()
    -- Leemos el valor guardado
    local coordsString = TeleportValue.Value
    
    if coordsString and coordsString ~= "" then
        -- Convertimos la cadena "X, Y, Z" a números
        local x, y, z = coordsString:match("([^,]+),([^,]+),([^,]+)")
        local newX = tonumber(x)
        local newY = tonumber(y)
        local newZ = tonumber(z)

        if RootPart and newX and newY and newZ then
            RootPart.CFrame = CFrame.new(newX, newY + 2, newZ) -- +2 para subir un poco
            Title.Text = "¡Teletransportado a punto guardado!"
        else
            Title.Text = "Error: Coordenadas no válidas."
        end
    else
        Title.Text = "ERROR: ¡No hay coordenada guardada!"
    end
end)
