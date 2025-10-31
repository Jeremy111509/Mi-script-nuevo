-- [[ Script Avanzado de Panel de Control con Scroll ]]

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()

-- 1. Configuraciones Básicas y Colores
local MenuColor = Color3.fromRGB(35, 40, 50)       -- Fondo oscuro del menú
local TitleColor = Color3.fromRGB(255, 170, 0)     -- Dorado/Naranja brillante para títulos
local ButtonColor = Color3.fromRGB(60, 70, 85)     -- Color de botones
local ButtonHoverColor = Color3.fromRGB(80, 90, 105) -- Color al pasar el ratón

-- 2. Crear el Contenedor Principal (ScreenGui)
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "PanelDeControlAvanzado"
MenuGui.Parent = PlayerGui

-- 3. Crear el Marco Principal (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MarcoPrincipal"
MainFrame.Size = UDim2.new(0.25, 0, 0.7, 0) -- Un menú más grande (25% del ancho, 70% del alto)
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0) -- Esquina superior izquierda
MainFrame.BackgroundColor3 = MenuColor
MainFrame.BorderColor3 = TitleColor
MainFrame.BorderSizePixel = 5
MainFrame.Active = true
MainFrame.Draggable = true -- Se puede mover
MainFrame.Parent = MenuGui

-- 4. Título del Menú
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TituloDelPanel"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = TitleColor
TitleLabel.Text = "⚙️ PANEL DE JUEGO AVANZADO ⚙️"
TitleLabel.TextColor3 = MenuColor
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextScaled = true
TitleLabel.Parent = MainFrame

-- 5. Crear el SCROLLING FRAME (Marco Desplazable)
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ContenedorScroll"
ScrollFrame.Size = UDim2.new(1, 0, 0.9, 0) -- 90% restante del MainFrame
ScrollFrame.Position = UDim2.new(0, 0, 0.1, 0)
ScrollFrame.BackgroundColor3 = MenuColor
ScrollFrame.CanvasSize = UDim2.new(0, 0, 2.0, 0) -- **IMPORTANTE: Define el área total para desplazar (200% de su propia altura)**
ScrollFrame.ScrollBarImageColor3 = TitleColor
ScrollFrame.Parent = MainFrame

-- 6. Layout para organizar los elementos dentro del ScrollFrame
local ListLayout = Instance.new("UIListLayout")
ListLayout.Name = "OrganizadorDeElementos"
ListLayout.Padding = UDim.new(0, 10) -- Espacio entre elementos
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = ScrollFrame

-- FUNCIÓN PARA CREAR UNA SECCIÓN
local function createSection(name, height, parentFrame)
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = name
    SectionFrame.Size = UDim2.new(0.95, 0, height, 0) -- 95% de ancho, altura variable
    SectionFrame.BackgroundColor3 = Color3.fromRGB(50, 55, 65) -- Ligeramente más claro
    SectionFrame.Parent = parentFrame

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "TituloSeccion"
    SectionTitle.Size = UDim2.new(1, 0, 0.15, 0)
    SectionTitle.Position = UDim2.new(0, 0, 0, 0)
    SectionTitle.BackgroundColor3 = TitleColor
    SectionTitle.Text = "--- " .. name:upper() .. " ---"
    SectionTitle.TextColor3 = MenuColor
    SectionTitle.Font = Enum.Font.SourceSansBold
    SectionTitle.TextScaled = true
    SectionTitle.Parent = SectionFrame

    -- Layout para los botones dentro de la sección
    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.Name = "OrganizadorDeBotones"
    ButtonLayout.Padding = UDim.new(0, 5)
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ButtonLayout.Parent = SectionFrame

    return SectionFrame
end

-- FUNCIÓN PARA CREAR UN BOTÓN CON ESTILO
local function createStyledButton(text, yPos, parentFrame, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text:gsub(" ", ""):gsub("!", "") -- Nombre sin espacios
    Button.Size = UDim2.new(0.9, 0, 0.15, 0) -- Más pequeño
    Button.BackgroundColor3 = ButtonColor
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSans
    Button.TextScaled = true
    Button.Parent = parentFrame

    -- Efecto visual al pasar el ratón
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = ButtonHoverColor
    end)
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = ButtonColor
    end)

    -- Conectar la función (lógica)
    if callback then
        Button.MouseButton1Click:Connect(callback)
    end
end

-- =========================================================
-- 7. CREACIÓN DE LAS SECCIONES Y FUNCIONALIDADES
-- =========================================================

-- A. SECCIÓN DE MOVIMIENTO (MOVEMENT)
local MovementSection = createSection("Movimiento", UDim.new(0.3, 0), ScrollFrame)

createStyledButton("🏃 Aumentar Velocidad!", 0, MovementSection, function()
    -- Lógica: Aumenta la velocidad del jugador
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid.WalkSpeed = 32 -- Más rápido que el valor predeterminado de 16
        game.StarterGui:SetCore("ChatMakeSystemMessage", {Text = "¡Velocidad aumentada a 32!", Color = Color3.fromRGB(0, 255, 0)})
    end
end)

createStyledButton("🐢 Velocidad Normal", 0, MovementSection, function()
    -- Lógica: Vuelve a la velocidad normal
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid.WalkSpeed = 16
        game.StarterGui:SetCore("ChatMakeSystemMessage", {Text = "Velocidad restablecida a 16.", Color = Color3.fromRGB(255, 255, 0)})
    end
end)

-- B. SECCIÓN DE APARIENCIA (APPEARANCE)
local AppearanceSection = createSection("Apariencia", UDim.new(0.3, 0), ScrollFrame)

createStyledButton("🔴 Color Rojo", 0, AppearanceSection, function()
    -- Lógica: Cambia el color del personaje (Head y Torso, por simplicidad)
    if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Torso") then
        Character.Head.BrickColor = BrickColor.new("Really Red")
        Character.Torso.BrickColor = BrickColor.new("Really Red")
        game.StarterGui:SetCore("ChatMakeSystemMessage", {Text = "¡Personaje de color Rojo!", Color = Color3.fromRGB(255, 0, 0)})
    end
end)

createStyledButton("🟢 Color Verde", 0, AppearanceSection, function()
    -- Lógica: Cambia el color del personaje a verde
    if Character and Character:FindFirstChild("Head") and Character:FindFirstChild("Torso") then
        Character.Head.BrickColor = BrickColor.new("Bright green")
        Character.Torso.BrickColor = BrickColor.new("Bright green")
        game.StarterGui:SetCore("ChatMakeSystemMessage", {Text = "¡Personaje de color Verde!", Color = Color3.fromRGB(0, 255, 0)})
    end
end)

-- C. SECCIÓN DE EFECTOS (EFFECTS)
local EffectsSection = createSection("Efectos", UDim.new(0.3, 0), ScrollFrame)

createStyledButton("🔊 Tocar Sonido Aleatorio", 0, EffectsSection, function()
    -- Lógica: Crea y toca un sonido corto (necesitarás un ID de sonido real)
    local SoundID = "rbxassetid://1021465809" -- Ejemplo: Sonido de 'Pop'
    local Sound = Instance.new("Sound")
    Sound.SoundId = SoundID
    Sound.Volume = 1
    Sound.Parent = Character or Player -- Adjuntar a un objeto existente
    
    Sound:Play()
    Sound.Ended:Wait()
    Sound:Destroy()
    
    game.StarterGui:SetCore("ChatMakeSystemMessage", {Text = "¡Sonido reproducido!", Color = Color3.fromRGB(200, 100, 255)})
end)

-- 8. BOTÓN PARA CERRAR EL MENÚ (Fuera del ScrollFrame)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "BotonCerrar"
CloseButton.Size = UDim2.new(0.3, 0, 0.05, 0) -- Pequeño botón en la parte inferior
CloseButton.Position = UDim2.new(0.35, 0, 0.95, 0) -- Centrado en la parte inferior del MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Rojo para cerrar
CloseButton.Text = "X CERRAR"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextScaled = true
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    MainFrame:Destroy() -- Elimina el marco principal y todo lo que contiene
    game.StarterGui:SetCore("ChatMakeSystemMessage", {Text = "Menú cerrado. ¡A seguir jugando!", Color = Color3.fromRGB(255, 170, 0)})
end)
