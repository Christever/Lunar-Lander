local Rocket = {}
local UI_carte = require("objects.UI.UI_carte")

function Rocket.load()
    Rocket.image  = love.graphics.newImage("assets/Images/fusee.png")
    Rocket.width  = Rocket.image:getWidth()
    Rocket.height = Rocket.image:getHeight()
    Rocket.x      = 940 - Rocket.width/2
    Rocket.y      = 190
end

function Rocket.update(dt)
   
end

function Rocket.draw()
    love.graphics.draw(
        Rocket.image,
        Rocket.x, Rocket.y
    )
end

return Rocket
