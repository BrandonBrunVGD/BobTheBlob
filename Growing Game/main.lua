function love.load()
    love.window.setMode(1920, 1080)

    Object = require "Libraries/classic"

    require "StartScreen"
    require "PlayScreen"
    require "WinScreen"
    require "DeathScreen"

    startscreen = true
    playscreen = false
    winscreen = false
    deathscreen = false

    StartScreen = StartScreen()
    PlayScreen = PlayScreen()
    WinScreen = WinScreen()
    DeathScreen = DeathScreen()
end

function love.update(dt)
    if (startscreen) then
        StartScreen:update(dt) 
    end
    if (playscreen) then
        PlayScreen:update(dt)
    end
    if (winscreen) then
        WinScreen:update(dt)
    end
    if (deathscreen) then
        DeathScreen:update(dt)
    end
    
end

function love.draw()
    if (startscreen) then
        StartScreen:draw()
    end
    if (playscreen) then    
        PlayScreen:draw()
    end
    if (winscreen) then
        WinScreen:draw(dt)
    end
    if (deathscreen) then
        DeathScreen:draw(dt)
    end
end