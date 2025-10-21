--[ Script para Ejecutar en Delta Executor ]--
-- Crea y maneja los botones de teletransporte.

local posicionGuardada = nil

-- PASO 1: CREAR LA INTERFAZ PRINCIPAL (ScreenGui)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PanelTeletransporte"
-- Se añade al PlayerGui, que es donde se muestran las interfaces al jugador.
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") 

-- PASO 2: CREAR EL BOTÓN 1 (Marcar Posición)
local marcarBoton = Instance.new("TextButton")
marcarBoton.Name = "MarcarPosicion"
marcarBoton.Size = UDim2.new(0.2, 0, 0.1, 0)
marcarBoton.Position = UDim2.new(0.3, 0, 0.1, 0)
marcarBoton.BackgroundColor3 = Color3.fromRGB(85, 255, 0) -- Verde
marcarBoton.Text = "Marcar Posición"
marcarBoton.Parent = screenGui -- Se añade al ScreenGui que acabamos de crear.

marcarBoton.MouseButton1Click:Connect(function()
    -- Lógica para guardar la posición (CFrame) del personaje
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        posicionGuardada = character.HumanoidRootPart.CFrame
        -- Feedback visual
        marcarBoton.Text = "¡Posición Guardada!"
        -- ... (resto de la lógica del botón) ...
    else
        marcarBoton.Text = "¡Error: Carga primero!"
    end
end)

-- PASO 3: CREAR EL BOTÓN 2 (Teletransportar)
local teleBoton = Instance.new("TextButton")
teleBoton.Name = "Teletransportar"
teleBoton.Size = UDim2.new(0.2, 0, 0.1, 0)
teleBoton.Position = UDim2.new(0.5, 0, 0.1, 0)
teleBoton.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Azul
teleBoton.Text = "Teletransportar"
teleBoton.Parent = screenGui -- Se añade al ScreenGui.

teleBoton.MouseButton1Click:Connect(function()
    -- Lógica para teletransportar a la posición guardada
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if posicionGuardada then
            character.HumanoidRootPart.CFrame = posicionGuardada
            -- Feedback visual
            teleBoton.Text = "¡Teletransporte Exitoso!"
            -- ... (resto de la lógica del botón) ...
        else
            teleBoton.Text = "¡Marca una posición primero!"
        end
    else
        teleBoton.Text = "¡Error: Carga primero!"
    end
end)

-- Nota: Por brevedad, he omitido algunas partes de la lógica (como los 'wait(2)')
-- pero el script completo que te di antes las contiene y es el correcto.
