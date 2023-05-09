Enemy = Object:extend()

function Enemy:new(x, y, s, speed, tag)
    self.normal = love.graphics.newImage("Assets/Sprites/EnemySlime.png")
    self.chaser = love.graphics.newImage("Assets/Sprites/ChaserSlime.png")
    self.boss = love.graphics.newImage("Assets/Sprites/SlimeKing.png")
    self.x = x
    self.y = y
    self.speed = speed
    self.scale = s
    self.width = self.normal:getWidth() * self.scale
    self.height = self.normal:getHeight() * self.scale
    self.tag = tag
    self.score = self.scale * 10
end

function Enemy:update(dt)
    --enemy movement
    if (self.tag == "normal") then
        self.x = self.x - self.speed * dt 

    elseif (self.tag == "chaser") then
        if (Player.x > self.x + self.width/2) then
            self.x = self.x + self.speed * dt
        end
        if (Player.x < self.x + self.width/2) then
            self.x = self.x - self.speed * dt
        end
        if (Player.y > self.y + self.height/2) then
            self.y = self.y + self.speed * dt
        end
        if (Player.y < self.y + self.height/2) then
            self.y = self.y - self.speed * dt
        end
    end
end

function Enemy:draw()
    if (self.tag == "normal") then 
        love.graphics.draw(self.normal, self.x, self.y, 0, self.scale, self.scale)
    elseif (self.tag == "chaser") then
        love.graphics.draw(self.chaser, self.x, self.y, 0, self.scale, self.scale)
    elseif (self.tag == "boss") then
        love.graphics.draw(self.boss, self.x, self.y, 0, self.scale, self.scale)
    end
end
