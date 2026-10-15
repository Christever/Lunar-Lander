local Rocket = {}
local UI_carte = require("objects.UI.UI_carte")

function Rocket.load()
    Rocket.image         = love.graphics.newImage("assets/Images/fusee.png")
    Rocket.width         = Rocket.image:getWidth()
    Rocket.height        = Rocket.image:getHeight()
    Rocket.x             = 940
    Rocket.y             = 190
    Rocket.latitude      = 300
    Rocket.longitude     = 230
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
    Rocket.thrust        = 4.0

    -- Carburant
    Rocket.fuel          = 400

    Rocket.fuelVertical  = 10
    Rocket.fuelLatitude  = 2
    Rocket.fuelLongitude = 2

    Rocket.thrusters     = {
        up = false,
        down = false,
        left = false,
        right = false,
        main = false
    }
end

function Rocket.update(dt)
    Rocket.thrusters.left  = love.keyboard.isDown("left") and Rocket.fuel > 0
    Rocket.thrusters.right = love.keyboard.isDown("right") and Rocket.fuel > 0
    Rocket.thrusters.up    = love.keyboard.isDown("up") and Rocket.fuel > 0
    Rocket.thrusters.down  = love.keyboard.isDown("down") and Rocket.fuel > 0
    Rocket.thrusters.main  = love.keyboard.isDown("space") and Rocket.fuel > 0
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
    Rocket.shipVX     = math.max(-Rocket.maxSpeed,
        math.min(Rocket.maxSpeed, Rocket.shipVX))

    Rocket.shipVY     = math.max(-Rocket.maxSpeed,
        math.min(Rocket.maxSpeed, Rocket.shipVY))

    -- Déplacement : conservation de la vitesse
    Rocket.latitude   = Rocket.latitude + Rocket.shipVX * dt
    Rocket.longitude  = Rocket.longitude + Rocket.shipVY * dt

    

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
    local x = Rocket.x
    local y = Rocket.y
    local w = Rocket.width
    local h = Rocket.height

    -- SPACE : poussée verticale, flamme sous la fusée
    if Rocket.thrusters.main then
        Rocket.drawFlame(
            x + w / 2,
            y + h,
            "space",
            22
        )
    end

    -- UP : propulseur sur le bord droit, derrière la fusée
    if Rocket.thrusters.up then
        Rocket.drawFlame(
            x + w - 2,
            y + h / 2,
            "up",
            18
        )
    end

    -- RIGHT : flamme sur le côté droit
    if Rocket.thrusters.right then
        Rocket.drawFlame(
            x + w,
            y + h / 2,
            "right",
            14
        )
    end

    -- LEFT : flamme sur le côté gauche
    if Rocket.thrusters.left then
        Rocket.drawFlame(
            x,
            y + h / 2,
            "left",
            14
        )
    end

    -- Dessiner le corps de la fusée par-dessus les flammes
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Rocket.image, x, y)

    -- DOWN : propulseur incliné dans le sens inverse
    if Rocket.thrusters.down then
        Rocket.drawFlame(
            x + w / 2,
            y + h / 2,
            "down",
            18
        )
    end

    -- Restaurer la couleur normale
    love.graphics.setColor(1, 1, 1)
end

function Rocket.drawFlame(x, y, direction, length)
    local dx = 0
    local dy = 0
    local halfWidth = 4

    if direction == "up" then
        dx = -math.cos(math.rad(30)) * length
        dy = -math.sin(math.rad(30)) * length
    elseif direction == "down" then
        dx = math.sin(math.rad(15)) * length
        dy = math.cos(math.rad(15)) * length
    elseif direction == "left" then
        dx = -length
        dy = 0
        halfWidth = 4
    elseif direction == "right" then
        dx = length
        dy = 0
        halfWidth = 4
    elseif direction == "space" then
        dx = 0
        dy = length
    else
        return
    end

    -- Flamme extérieure orange
    love.graphics.setColor(1, 0.35, 0.05)

    if direction == "left" or direction == "right" then
        love.graphics.polygon("fill",
            x, y - halfWidth,
            x, y + halfWidth,
            x + dx, y
        )
    else
        love.graphics.polygon("fill",
            x - halfWidth, y,
            x + halfWidth, y,
            x + dx, y + dy
        )
    end

    -- Cœur intérieur jaune
    love.graphics.setColor(1, 0.85, 0.2)

    if direction == "left" or direction == "right" then
        love.graphics.polygon("fill",
            x, y - 2,
            x, y + 2,
            x + dx * 0.6, y
        )
    else
        love.graphics.polygon("fill",
            x - 2, y,
            x + 2, y,
            x + dx * 0.6, y + dy * 0.6
        )
    end

    love.graphics.setColor(1, 1, 1)
end

return Rocket
