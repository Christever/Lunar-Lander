
local UI_module = {}

-- Nombre d'étoiles
local STAR_COUNT = 120

-- Intensité du déplacement horizontal des étoiles
local PARALLAX = 0.5

-- Altitude à laquelle le sol commence à remonter
local GROUND_START_ALTITUDE = 150

-- Position du sol au contact (coordonnée dans le panneau)
local GROUND_CONTACT_Y = 230

function UI_module.load()

    UI_module.x = 640
    UI_module.y = 20
    UI_module.width = 600
    UI_module.height = 400

    UI_module.stars = {}

    -- Création des étoiles
    for i = 1, STAR_COUNT do

        local star = {
            x = love.math.random(UI_module.width),
            y = love.math.random(UI_module.height),
            size = love.math.random(1, 2),
            brightness = love.math.random(50, 100) / 100
        }

        table.insert(UI_module.stars, star)

    end

end


function UI_module.update(dt, rocket)

    if not rocket or not UI_module.stars then
        return
    end

    -- Vitesses du vaisseau
    local altitudeVY = rocket.altitudeVY or 0
    local vx = rocket.shipVX or 0

    -- Déplacement des étoiles
    local speedY = altitudeVY * 5
    local speedX = -vx * PARALLAX

    for _, star in ipairs(UI_module.stars) do

        -- Déplacement vertical
        star.y = star.y + speedY * dt

        -- Déplacement horizontal
        star.x = star.x + speedX * dt

        -- Réapparition verticale
        if star.y >= UI_module.height then
            star.y = star.y - UI_module.height
        elseif star.y < 0 then
            star.y = star.y + UI_module.height
        end

        -- Réapparition horizontale
        if star.x >= UI_module.width then
            star.x = star.x - UI_module.width
        elseif star.x < 0 then
            star.x = star.x + UI_module.width
        end

    end

end


function UI_module.draw(rocket)

    local x = UI_module.x
    local y = UI_module.y
    local width = UI_module.width
    local height = UI_module.height

    -- Fond noir
    love.graphics.setColor(0, 0, 0)

    love.graphics.rectangle(
        "fill",
        x,
        y,
        width,
        height
    )

    -- Limiter le dessin au panneau
    love.graphics.setScissor(
        x,
        y,
        width,
        height
    )

    -- Dessiner les étoiles
    for _, star in ipairs(UI_module.stars) do

        love.graphics.setColor(
            star.brightness,
            star.brightness,
            star.brightness
        )

        love.graphics.rectangle(
            "fill",
            x + star.x,
            y + star.y,
            star.size,
            star.size
        )

    end

    -- Dessiner le sol selon l'altitude réelle
    if rocket and rocket.altitude ~= nil then

        local altitude = math.max(0, rocket.altitude)
        local groundY

        if altitude > GROUND_START_ALTITUDE then

            -- Sol encore hors de vue
            groundY = height

        else

            -- Progression de 0 à 1
            local progress =
                1 - altitude / GROUND_START_ALTITUDE

            -- Remontée progressive du sol
            groundY = height
                - progress * (height - GROUND_CONTACT_Y)

        end

        -- Surface lunaire plate
        love.graphics.setColor(0.48, 0.48, 0.48)

        love.graphics.rectangle(
            "fill",
            x,
            y + groundY,
            width,
            height - groundY
        )

        -- Ligne d'horizon
        love.graphics.setColor(0.75, 0.75, 0.75)

        love.graphics.line(
            x,
            y + groundY,
            x + width,
            y + groundY
        )

    end

    -- Désactiver le découpage
    love.graphics.setScissor()

    -- Restaurer la couleur normale
    love.graphics.setColor(1, 1, 1)

end


return UI_module
