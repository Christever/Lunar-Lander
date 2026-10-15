
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


function UI_module.update(dt, rocket)

    if not rocket then
        return
    end

    -- Récupérer la position du vaisseau
    local rocketX = rocket.x or rocket.shipX
    local rocketY = rocket.y or rocket.shipY

    if not rocketX or not rocketY then
        return
    end

    -- Première mise à jour : mémoriser la position
    if UI_module.previousX == nil then
        UI_module.previousX = rocketX
        UI_module.previousY = rocketY
        return
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
