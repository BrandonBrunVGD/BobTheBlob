Background = Object:extend()

function Background:new(x, y, s)
    self.image = love.graphics.newImage("Assets/Sprites/BackgroundBeach.png")
    self.x = x
    self.y = y
    self.scale = s
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
end

function Background:update(dt)
    
end

function Background:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end