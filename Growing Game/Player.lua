Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("Assets/Sprites/SlimeGuy.png")
    self.x = 250
    self.y = 400
    self.speed = 500
    self.scale = 1.15
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.score = 0
end

function Player:update(dt)
    --player movement
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
      
    elseif love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
       
    end

    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end

    --screen bounds
    local window_width = love.graphics.getWidth() + love.graphics.getWidth()/2
    local window_height = love.graphics.getHeight() + love.graphics.getHeight()/2

    if self.x < 0 then
        self.x = 0

    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
    end

    if self.y < 0 then
        self.y = 0

    elseif self.y + self.height > window_height then
        self.y = window_height - self.height
    end

   
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end