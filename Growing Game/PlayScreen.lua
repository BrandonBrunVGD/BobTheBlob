PlayScreen = Object:extend()

function PlayScreen:new()
    screenBoundsX = love.graphics.getWidth() + love.graphics.getWidth()/2
    screenBoundsY = love.graphics.getHeight() + love.graphics.getHeight()/2

    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()

    love.window.setMode(1920, 1080)

    Object = require "Libraries/classic"

    require "Player"
    require "Enemy"
    require "Background"

    Player = Player()
    Background = Background(1, 1, 0.75)
    Enemies = {}

    enemySpawnTimer = 240
    numberOfEnemies = 0
    scaleValue = 1
    zoomThreshHold = 15

    src1 = love.audio.newSource("SFX/eatSFX.wav", "static")
    table.insert(Enemies, Enemy(900, 300, 2.5, 250, "chaser"))
end

function PlayScreen:update(dt)
    
    Player:update(dt)
    
    enemySpawnTimer = enemySpawnTimer - 1
    if enemySpawnTimer <= 0 then
        spawnEnemy()
        enemySpawnTimer = 240
    end

    for i,v in ipairs(Enemies) do
        v:update(dt)

        if (v.x > screenBoundsX) then
            table.remove(Enemies, i)
        end

        if (v.x + v.width < -350) then
            table.remove(Enemies, i)
        end

        if checkCollision(v, Player) == true then
            
            if (v.tag == "normal" or v.tag == "chaser") then
                if (v.scale < Player.scale) then
                    table.remove(Enemies, i)
                    src1:play()
                    Player.scale = Player.scale + 0.40
                    Player.width = Player.image:getWidth() * Player.scale
                    Player.height = Player.image:getHeight() * Player.scale
                    Player.score = Player.score + v.score
                elseif (v.scale > Player.scale) then
                    resetGame()
                end
            elseif (v.tag == "boss") then
                if (v.scale < Player.scale) then
                    resetGame()
                    playscreen = false
                    winscreen = true
                elseif (v.scale > Player.scale) then
                    resetGame()
                end
            end
        end
    end

    if (Player.scale >= zoomThreshHold) then
        Player.y = screenBoundsY - Player.height
        Background.scale = 0.5
        scaleValue = 4
        Player.scale = Player.scale / scaleValue
        Player.width = Player.image:getWidth() * Player.scale
        Player.height = Player.image:getHeight() * Player.scale
        zoomThreshHold = 1000
        table.insert(Enemies, Enemy(screenBoundsX/2, 1, 50, 0, "boss"))
        
        for i,v in ipairs(Enemies) do 
            v.scale = v.scale / scaleValue 
            v.width = v.normal:getWidth() * v.scale
            v.height = v.normal:getHeight() * v.scale
        end
    end
end

function PlayScreen:draw()
    Background:draw()
    love.graphics.translate((-Player.x - Player.width / 2) + (love.graphics.getWidth() / 2), (-Player.y - Player.height / 2) + (love.graphics.getHeight() / 2))
    Player:draw()
    for i,v in ipairs(Enemies) do
        v:draw()
        drawCollision(v)
    end

    --love.graphics.print(#Enemies,0,0)
    --love.graphics.print(Player.scale,0,0)
    love.graphics.print("Score:",((Player.x + Player.width/2) - window_width/2) + 50, ((Player.y + Player.height/2) - window_height/2) + 10,0,10,10)
    love.graphics.print(Player.score, ((Player.x + Player.width/2) - window_width/2) + 460, ((Player.y + Player.height/2) - window_height/2) + 10 ,0,10,10)
    drawCollision(Player)
    
    love.graphics.rectangle("line", 0, 0, screenBoundsX, screenBoundsY)
end

function checkCollision(a, b)
    local a_left = a.x + a.width / 8
    local a_right = (a_left + a.width) - a.width/ 4
    local a_top = a.y + a.height / 8
    local a_bottom = (a_top + a.height) - a.width/ 4

    local b_left = b.x + b.width / 8
    local b_right = (b_left + b.width) - b.width/ 4
    local b_top = b.y + b.height / 8
    local b_bottom = (b_top + b.height) - b.width/ 4

    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end

function drawCollision(a)
    local a_left = a.x + a.width / 8
    local a_right = a.width - a.width / 4
    local a_top = a.y + a.height / 8
    local a_bottom = a.height - a.width / 4

    love.graphics.rectangle("line", a_left, a_top, a_right, a_bottom)
end

function spawnEnemy()
    --screenBoundsX = love.graphics.getWidth() + love.graphics.getWidth()/2
    randomY1 = love.math.random(1, 900)
    randomS1 = love.math.random(1, 10)
    randomY2 = love.math.random(1, 900)
    randomS2 = love.math.random(1, 10)
    table.insert(Enemies, Enemy(screenBoundsX, randomY1, randomS1/scaleValue, 250, "normal"))
    table.insert(Enemies, Enemy(-600, randomY2, randomS2/scaleValue, -250, "normal"))
end

function resetGame()
    Player.image = love.graphics.newImage("Assets/Sprites/SlimeGuy.png")
    Player.x = 250
    Player.y = 400
    Player.speed = 500
    Player.scale = 1.15
    Player.width = Player.image:getWidth() * Player.scale
    Player.height = Player.image:getHeight() * Player.scale
    Player.score = 0
    
    enemySpawnTimer = 120
    numberOfEnemies = 0
    scaleValue = 1
    zoomThreshHold = 15
    Background.scale = 0.75

    for i,v in ipairs(Enemies) do Enemies[i]=nil end
    table.insert(Enemies, Enemy(900, 300, 2.5, 200, "chaser"))
end