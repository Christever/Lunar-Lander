local Rocket = {}
local UI_carte = require("objects.UI.UI_carte")

function Rocket.load()
    Rocket.image  = love.graphics.newImage("assets/Images/fusee.png")
    Rocket.width  = Rocket.image:getWidth()
    Rocket.height = Rocket.image:getHeight()
    Rocket.x      = 940
    Rocket.y      = 190
    Rocket.shipX  = 150
    Rocket.shipY  = 230
end

function Rocket.update(dt)
    if love.keyboard.isDown("left") then
        Rocket.shipX = Rocket.shipX - 10
    end
    if love.keyboard.isDown("right") then
        Rocket.shipX = Rocket.shipX + 10
    end
end

function Rocket.draw()
    love.graphics.draw(
        Rocket.image,
        Rocket.x - Rocket.width / 2, Rocket.y
    )
end

return Rocket
