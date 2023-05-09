WinScreen = Object:extend()

function WinScreen:new()
    self.startbutton = love.graphics.newImage("Assets/Sprites/StartButton.png")
    self.youwin = love.graphics.newImage("Assets/Sprites/YouWin.png")
end

function WinScreen:update(dt)
    if (love.keyboard.isDown("return")) then
        playscreen = true
        winscreen = false
     end
end

function WinScreen:draw()
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()

    love.graphics.draw(self.startbutton, window_width/2, 850, 0, 10, 10, self.startbutton:getWidth()/2, self.startbutton:getHeight()/2)
    love.graphics.draw(self.youwin, window_width/2, 330, 0, 10, 10, self.youwin:getWidth()/2, self.youwin:getHeight()/2)
end