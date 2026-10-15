local Rocket = {}
local UI_carte = require("objects.UI.UI_carte")

function Rocket.load()
    Rocket.image        = love.graphics.newImage("assets/Images/fusee.png")
    Rocket.width        = Rocket.image:getWidth()
    Rocket.height       = Rocket.image:getHeight()
    Rocket.x            = 940
    Rocket.y            = 190
    Rocket.shipX        = 150
    Rocket.shipY        = 230
    Rocket.speed        = 60

    Rocket.shipVX       = 0
    Rocket.shipVY       = 0

    Rocket.acceleration = 150
    Rocket.maxSpeed     = 200
end

function Rocket.update(dt)
    -- Accélération commandée
    if love.keyboard.isDown("left") then
        Rocket.shipVX = Rocket.shipVX - Rocket.acceleration * dt
    end

    if love.keyboard.isDown("right") then
        Rocket.shipVX = Rocket.shipVX + Rocket.acceleration * dt
    end

    if love.keyboard.isDown("up") then
        Rocket.shipVY = Rocket.shipVY - Rocket.acceleration * dt
    end

    if love.keyboard.isDown("down") then
        Rocket.shipVY = Rocket.shipVY + Rocket.acceleration * dt
    end

    -- Limiter la vitesse maximale
    Rocket.shipVX = math.max(-Rocket.maxSpeed,
        math.min(Rocket.maxSpeed, Rocket.shipVX))

    Rocket.shipVY = math.max(-Rocket.maxSpeed,
        math.min(Rocket.maxSpeed, Rocket.shipVY))

    -- Déplacement : conservation de la vitesse
    Rocket.shipX = Rocket.shipX + Rocket.shipVX * dt
    Rocket.shipY = Rocket.shipY + Rocket.shipVY * dt
end

function Rocket.draw()
    love.graphics.draw(
        Rocket.image,
        Rocket.x - Rocket.width / 2, Rocket.y
    )
end

return Rocket
