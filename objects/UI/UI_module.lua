
local UI_module = {}

-- Nombre d'étoiles
local STAR_COUNT = 120

-- Intensité du déplacement des étoiles
local PARALLAX = 0.5

function UI_module.load()

    UI_module.x      = 640
    UI_module.y      = 20
    UI_module.width  = 600
    UI_module.height = 400

    UI_module.stars = {}

    -- Position précédente du vaisseau
    UI_module.previousX = nil
    UI_module.previousY = nil

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

-- function UI_module.update(dt, rocket)

--     if not rocket or not UI_module.stars then
--         return
--     end

--     local altitudeVY = rocket.altitudeVY or 0

--     -- Calcul du déplacement vertical des étoiles
--     local speedY = altitudeVY * 5

--     for _, star in ipairs(UI_module.stars) do

--         -- Déplacement vertical
--         star.y = star.y + speedY * dt

--         -- Une étoile sort par le bas : elle revient en haut
--         if star.y >= UI_module.height then
--             star.y = star.y - UI_module.height
--         end

--         -- Une étoile sort par le haut : elle revient en bas
--         if star.y < 0 then
--             star.y = star.y + UI_module.height
--         end

--     end

-- end


function UI_module.update(dt, rocket)

    if not rocket or not UI_module.stars then
        return
    end

    -- Vitesses du vaisseau
    local altitudeVY = rocket.altitudeVY or 0
    local vx = rocket.shipVX or 0

    -- Déplacement des étoiles
    local speedY = altitudeVY * 5
    local speedX = -vx * .5

    for _, star in ipairs(UI_module.stars) do

        -- Déplacement vertical selon l'altitude
        star.y = star.y + speedY * dt

        -- Déplacement horizontal en sens inverse du vaisseau
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



function UI_module.draw()

    -- Fond noir du panneau
    love.graphics.setColor(0, 0, 0)

    love.graphics.rectangle(
        "fill",
        UI_module.x,
        UI_module.y,
        UI_module.width,
        UI_module.height
    )

    -- Limiter le dessin des étoiles au panneau
    love.graphics.setScissor(
        UI_module.x,
        UI_module.y,
        UI_module.width,
        UI_module.height
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
            UI_module.x + star.x,
            UI_module.y + star.y,
            star.size,
            star.size
        )

    end

    -- Désactiver la zone de découpage
    love.graphics.setScissor()

    -- Restaurer la couleur normale
    love.graphics.setColor(1, 1, 1)

end


return UI_module
