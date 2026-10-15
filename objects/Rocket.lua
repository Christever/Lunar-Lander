local Rocket = {}
local UI_carte = require("objects.UI.UI_carte")

function Rocket.load()
    Rocket.image         = love.graphics.newImage("assets/Images/fusee.png")
    Rocket.width         = Rocket.image:getWidth()
    Rocket.height        = Rocket.image:getHeight()
    Rocket.x             = 940
    Rocket.y             = 190
    Rocket.shipX         = 150
    Rocket.shipY         = 230
    Rocket.speed         = 60

    Rocket.shipVX        = 0
    Rocket.shipVY        = 0

    Rocket.acceleration  = 150
    Rocket.maxSpeed      = 200
    Rocket.thrustPercent = 0

    Rocket.altitude      = 500
    Rocket.altitudeVY    = 0

    -- Physique lunaire
    Rocket.gravity       = 1.6
    Rocket.thrust        = 2.0

    -- Carburant
    Rocket.fuel          = 400

    Rocket.fuelVertical  = 10
    Rocket.fuelLatitude  = 2
    Rocket.fuelLongitude = 2
end

function Rocket.update(dt)
    -- Accélération commandée
    if love.keyboard.isDown("left") then
        Rocket.shipVX = Rocket.shipVX - Rocket.acceleration * dt
        Rocket.fuel = math.max(0, Rocket.fuel - Rocket.fuelLatitude * dt)
    end

    if love.keyboard.isDown("right") then
        Rocket.shipVX = Rocket.shipVX + Rocket.acceleration * dt
        Rocket.fuel = math.max(0, Rocket.fuel - Rocket.fuelLatitude * dt)
    end

    if love.keyboard.isDown("up") then
        Rocket.shipVY = Rocket.shipVY - Rocket.acceleration * dt
        Rocket.fuel = math.max(0, Rocket.fuel - Rocket.fuelLongitude * dt)
    end

    if love.keyboard.isDown("down") then
        Rocket.shipVY = Rocket.shipVY + Rocket.acceleration * dt
        Rocket.fuel = math.max(0, Rocket.fuel - Rocket.fuelLongitude * dt)
    end

    -- Limiter la vitesse maximale
    Rocket.shipVX = math.max(-Rocket.maxSpeed,
        math.min(Rocket.maxSpeed, Rocket.shipVX))

    Rocket.shipVY = math.max(-Rocket.maxSpeed,
        math.min(Rocket.maxSpeed, Rocket.shipVY))

    -- Déplacement : conservation de la vitesse
    Rocket.shipX = Rocket.shipX + Rocket.shipVX * dt
    Rocket.shipY = Rocket.shipY + Rocket.shipVY * dt

    -- Gravité lunaire : accélération vers le sol
    Rocket.altitudeVY = Rocket.altitudeVY - Rocket.gravity * dt

    -- Moteur : poussée vers le haut
    if love.keyboard.isDown("space") and Rocket.fuel > 0 then
        Rocket.thrustPercent = 100
        Rocket.altitudeVY = Rocket.altitudeVY + Rocket.thrust * dt
        Rocket.fuel = math.max(0, Rocket.fuel - Rocket.fuelVertical * dt)
    else
        Rocket.thrustPercent = 0
    end

    -- Mise à jour de l'altitude
    Rocket.altitude = Rocket.altitude + Rocket.altitudeVY * dt

    -- Contact avec le sol
    if Rocket.altitude <= 0 then
        Rocket.altitude = 0
        Rocket.altitudeVY = 0
    end
end

function Rocket.draw()
    love.graphics.draw(
        Rocket.image,
        Rocket.x - Rocket.width / 2, Rocket.y
    )
end

return Rocket
