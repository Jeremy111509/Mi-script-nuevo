--[[
    ======================================
    Script Mejorado v3: Con Botón Flotante de Minimizado
    ======================================
]]

-- 1. CONFIGURACIÓN DE VARIABLES (Se ejecutan al cargar el script)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid")
local RootPart = Character:FindFirstChild("HumanoidRootPart")

-- Creamos el contenedor principal (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiScriptExecutorGUI"
ScreenGui.ResetOnSpawn = false 

-- Creamos el Frame (la ventana principal)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 480) 
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 1
MainFrame.Active = true 
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false -- IMPORTANTE: Empieza oculto


-- 2. CREACIÓN DEL BOTÓN FLOTANTE (LA "BOLITA" DE MINIMIZADO)

local MinimizationButton = Instance.new("ImageButton")
MinimizationButton.Name = "MinimizationButton"
MinimizationButton.BackgroundTransparency = 1
MinimizationButton.Size = UDim2.new(0, 50, 0, 50) -- Tamaño de la bolita
MinimizationButton.Position = UDim2.new(1, -60, 0.2, 0) -- Posiciona en la esquina derecha
MinimizationButton.ZIndex = 10 -- Asegura que esté por encima de todo
MinimizationButton.Image = "rbxassetid://9810574577" -- ID de una imagen de icono de herramienta (puedes usar la tuya)
MinimizationButton.Parent = ScreenGui -- Es hijo directo del ScreenGui para que sea flotante
MinimizationButton.Draggable = true -- Permite arrastrar la bolita

MinimizationButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible -- Invierte la visibilidad de la ventana
    MinimizationButton.Visible = not MainFrame.Visible -- Oculta la bolita si la ventana principal se abre
end)

-- Botón para cerrar la GUI completamente (para salir del script)
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0) -- Posiciona en la esquina superior derecha
CloseButton.Parent = Header

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false -- Oculta la ventana
    MinimizationButton.Visible = true -- Muestra la bolita para volver a abrir
end)


-- ... (Resto del código de la Cabecera, Título y las funciones, sin cambios sustanciales) ...

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
Title.Size = UDim2.new(1, -30, 1, 0) -- Un poco más pequeño para dejar espacio a la X
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Parent = Header

-- Función para crear una etiqueta y una caja de texto (para editar valores)
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
    TextBox.Text = placeholderText 
    TextBox.PlaceholderText = placeholderText
    TextBox.TextSize = 16
    TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    TextBox.Size = UDim2.new(0.9, 0, 0, 30)
    TextBox.Position = UDim2.new(0.05, 0, 0, yPosition + 25)
    TextBox.Parent = MainFrame
    
    return TextBox
end

-- Creamos los campos de entrada
local SpeedInput = createInputGroup("🏃 Velocidad (WalkSpeed):", 40, "200") 
local JumpInput = createInputGroup("🚀 Potencia de Salto (JumpPower):", 120, "150") 

-- Función para aplicar la Velocidad (CON LÍMITE)
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

-- Función para aplicar el Salto (CON LÍMITE)
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

-- FUNCIÓN PARA LA INVISIBILIDAD MEJORADA
local IsInvisible = false
local InvisibleButton = Instance.new("TextButton")
InvisibleButton.Text = "👻 ACTIVAR INVISIBILIDAD"
InvisibleButton.Font = Enum.Font.SourceSansBold
InvisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisibleButton.TextSize = 16
InvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 150) 
InvisibleButton.Size = UDim2.new(0.9, 0, 0, 40)
InvisibleButton.Position = UDim2.new(0.05, 0, 0, 330)
InvisibleButton.Parent = MainFrame

InvisibleButton.MouseButton1Click:Connect(function()
    IsInvisible = not IsInvisible
    
    for _, item in pairs(Character:GetDescendants()) do
        if item:IsA("BasePart") or item:IsA("Decal") or item:IsA("MeshPart") then
            item.LocalTransparencyModifier = (IsInvisible and 1) or 0
        elseif item:IsA("Accessory") then
            if item:FindFirstChildOfClass("BasePart") then
                item:FindFirstChildOfClass("BasePart").LocalTransparencyModifier = (IsInvisible and 1) or 0
            end
        end
    end
    
    if IsInvisible then
        InvisibleButton.Text = "✅ INVISIBILIDAD ACTIVA (Desactivar)"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        Title.Text = "¡Eres invisible (pelo incluido)!"
    else
        InvisibleButton.Text = "👻 ACTIVAR INVISIBILIDAD"
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 50, 150)
        Title.Text = "Visibilidad restaurada."
    end
end)

-- Botón de Teletransporte (TeleportButton)
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


-- 3. INSERCIÓN DE LA GUI EN EL JUEGO
ScreenGui.Parent = game:GetService("CoreGui")

