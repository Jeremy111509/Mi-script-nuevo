--[ Delta Executor Teleport Script (2 Botones) ]--

-- Variables globales
local posicionGuardada = nil
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PanelTeletransporte"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 1. Botón para MARCAR POSICIÓN
local marcarBoton = Instance.new("TextButton")
marcarBoton.Name = "MarcarPosicion"
marcarBoton.Size = UDim2.new(0.2, 0, 0.1, 0)
marcarBoton.Position = UDim2.new(0.3, 0, 0.1, 0)
marcarBoton.BackgroundColor3 = Color3.fromRGB(85, 255, 0) -- Verde
marcarBoton.Text = "Marcar Posición"
marcarBoton.Parent = screenGui

marcarBoton.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        posicionGuardada = character.HumanoidRootPart.CFrame
        marcarBoton.Text = "¡Posición Guardada!"
        marcarBoton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        
        -- Reiniciar el botón después de un momento
        spawn(function()
            wait(2)
            marcarBoton.Text = "Marcar Posición"
            marcarBoton.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
        end)
    else
        marcarBoton.Text = "¡Error: Carga primero!"
    end
end)

-- 2. Botón para TELETRANSPORTAR
local teleBoton = Instance.new("TextButton")
teleBoton.Name = "Teletransportar"
teleBoton.Size = UDim2.new(0.2, 0, 0.1, 0)
teleBoton.Position = UDim2.new(0.5, 0, 0.1, 0)
teleBoton.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Azul
teleBoton.Text = "Teletransportar"
teleBoton.Parent = screenGui

teleBoton.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if posicionGuardada then
            character.HumanoidRootPart.CFrame = posicionGuardada
            teleBoton.Text = "¡Teletransporte Exitoso!"
            teleBoton.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
            
            spawn(function()
                wait(2)
                teleBoton.Text = "Teletransportar"
                teleBoton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            end)
        else
            teleBoton.Text = "¡Marca una posición primero!"
        end
    else
        teleBoton.Text = "¡Error: Carga primero!"
    end
end)
