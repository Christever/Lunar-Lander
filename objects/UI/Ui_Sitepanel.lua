local UI_Sitepanel = {}

function UI_Sitepanel.load(player)
    UI_Sitepanel.image     = love.graphics.newImage("assets/Images/panel1.png")
    UI_Sitepanel.x         = 20
    UI_Sitepanel.y         = 440
    UI_Sitepanel.width     = 500
    UI_Sitepanel.height    = 340
    UI_Sitepanel.latitude  = player.shipX
    UI_Sitepanel.longitude = player.shipY
end

function UI_Sitepanel.update(dt)

end

function UI_Sitepanel.draw(player)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle(
        "fill",
        UI_Sitepanel.x, UI_Sitepanel.y,
        UI_Sitepanel.width, UI_Sitepanel.height
    )
    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(
        UI_Sitepanel.image,
        UI_Sitepanel.x,
        UI_Sitepanel.y
    )

    love.graphics.setColor(181 / 255, 196 / 255, 196 / 255)
    love.graphics.rectangle(
        "fill",
        UI_Sitepanel.x + 150,
        UI_Sitepanel.y + 130,
        100, 60
    )
    love.graphics.rectangle(
        "fill",
        UI_Sitepanel.x + 270,
        UI_Sitepanel.y + 130,
        100, 60
    )
    local i = 1
    love.graphics.setFont(FontMedium)
    for x = 160, 360, 50 do
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(i, UI_Sitepanel.x + x - 5, UI_Sitepanel.y + 15)
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle("fill", UI_Sitepanel.x + x, UI_Sitepanel.y + 60, 10)
        i = i + 1
    end
    love.graphics.setFont(FontSmall)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Tank", UI_Sitepanel.x + 110, UI_Sitepanel.y + 48)

    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(FontUI)

    local latitude  = math.floor(player.shipX)
    local longitude = math.floor(player.shipY)



    love.graphics.print(string.format("%03d", latitude), UI_Sitepanel.x + 150, UI_Sitepanel.y + 140)
    love.graphics.print(string.format("%03d", longitude), UI_Sitepanel.x + 270, UI_Sitepanel.y + 140)

    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(FontLarge)
    love.graphics.print("Lat.", UI_Sitepanel.x + 165, UI_Sitepanel.y + 180)
    love.graphics.print("Log.", UI_Sitepanel.x + 285, UI_Sitepanel.y + 180)

    love.graphics.print("SITE PANEL", UI_Sitepanel.x + 170, UI_Sitepanel.y + UI_Sitepanel.height - 50)
end

return UI_Sitepanel
