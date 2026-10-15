local UI_carte = {}

function UI_carte.load()
    UI_carte.x      = 20
    UI_carte.y      = 20
    UI_carte.width  = 600
    UI_carte.height = 400
    UI_carte.bg     = love.graphics.newImage("assets/Images/lunar.jpg")
    UI_carte.ship   = love.graphics.newImage("assets/Images/ship.png")
    UI_carte.shipX  = 150
    UI_carte.shipY  = 200
end

function UI_carte.update(dt)

end

function UI_carte.draw(Player)
    love.graphics.draw(
        UI_carte.bg,
        UI_carte.x, UI_carte.y,
        0,
        UI_carte.width / UI_carte.bg:getWidth(),
        UI_carte.height / UI_carte.bg:getHeight()
    )

    love.graphics.setColor(1, 0, 0)
    love.graphics.setLineWidth(2)
    love.graphics.line(
        UI_carte.x + 150, UI_carte.y,
        UI_carte.x + 150, UI_carte.y + UI_carte.height
    )
    love.graphics.line(
        UI_carte.x, UI_carte.y + 200,
        UI_carte.x + UI_carte.width, UI_carte.y + 200
    )

    love.graphics.setFont(FontMedium)
    love.graphics.setColor(245 / 255, 245 / 255, 81 / 255)
    love.graphics.print(
        "Landing zone",
        UI_carte.x + 20,
        UI_carte.y + UI_carte.height - 50
    )

    love.graphics.setColor(1, 1, 1)

    -- Position provisoire du marqueur sur la carte
    love.graphics.draw(
        UI_carte.ship,
        UI_carte.x + UI_carte.shipX,
        UI_carte.y + UI_carte.shipY
    )
end

-- function UI_carte.setShipPosition(x, y)
--     UI_carte.shipX = x
--     UI_carte.shipY = y
-- end

-- function UI_carte.updateShipPosition(Player)
--     local screenWidth = love.graphics.getWidth()
--     local screenHeight = love.graphics.getHeight()

--     UI_carte.shipX = Player.x / screenWidth * UI_carte.width
--     UI_carte.shipY = Player.y / screenHeight * UI_carte.height
    -- UI_carte.shipX = UI_carte.x + 
-- end

return UI_carte
