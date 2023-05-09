StartScreen = Object:extend()

function StartScreen:new()
    self.startbutton = love.graphics.newImage("Assets/Sprites/StartButton.png")
    self.logo = love.graphics.newImage("Assets/Sprites/BOBTheBlob.png")
    
end

function StartScreen:update(dt)
    if (love.keyboard.isDown("return")) then
        playscreen = true
        startscreen = false
     end
end

function StartScreen:draw()
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()

    love.graphics.draw(self.startbutton, window_width/2, 850, 0, 10, 10, self.startbutton:getWidth()/2, self.startbutton:getHeight()/2)
    love.graphics.draw(self.logo, window_width/2, 330, 0, 10, 10, self.logo:getWidth()/2, self.logo:getHeight()/2)
end