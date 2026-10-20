local UI_DescentControl = {}


function UI_DescentControl.load()
    UI_DescentControl.image  = love.graphics.newImage("assets/Images/panel1.png")
    UI_DescentControl.x      = 690
    UI_DescentControl.y      = 440
    UI_DescentControl.width  = 700
    UI_DescentControl.height = 340
end

function UI_DescentControl.update(dt)

end

function UI_DescentControl.draw(player)
    love.graphics.draw(
        UI_DescentControl.image,
        UI_DescentControl.x,
        UI_DescentControl.y
    )

    love.graphics.setColor(181 / 255, 196 / 255, 196 / 255)

    -- ROD
    love.graphics.rectangle(
        "fill",
        UI_DescentControl.x + 200,
        UI_DescentControl.y + 20,
        120, 60
    )

    -- FUEL
    love.graphics.rectangle(
        "fill",
        UI_DescentControl.x + 150,
        UI_DescentControl.y + 130,
        100, 60
    )

    -- Altitude
    love.graphics.rectangle(
        "fill",
        UI_DescentControl.x + 270,
        UI_DescentControl.y + 130,
        100, 60
    )

    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(FontUI)

    -- Affichage fuel / altitude

    local fuel = math.floor(player.fuel)
    local altitude = math.floor(player.altitude)

    love.graphics.print(string.format("%03d", fuel), UI_DescentControl.x + 155, UI_DescentControl.y + 140)
    love.graphics.print(string.format("%03d", altitude), UI_DescentControl.x + 275, UI_DescentControl.y + 140)

    -- Affichage du taux de descente (R.O.D.)
    -- Vitesse verticale
    local rod = math.floor(math.abs(player.altitudeVY) + 0.5)

    love.graphics.setColor(0, 0, 0)

    -- R.O.D. sur deux chiffres
    love.graphics.print(
        string.format("%02d", rod),
        UI_DescentControl.x + 220,
        UI_DescentControl.y + 30
    )

    -- Sens du mouvement
    local direction
    if player.altitudeVY < 0 then
        direction = "-"
    else
        direction = ""
    end

    if direction == "-" then
        love.graphics.rectangle("fill",
            UI_DescentControl.x + 180, UI_DescentControl.y + 20,
            30, 60
        )
    end
    love.graphics.setFont(FontXXL)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        direction,
        UI_DescentControl.x + 190,
        UI_DescentControl.y + 12
    )

    love.graphics.setFont(FontLarge)
    love.graphics.print("Fuel", UI_DescentControl.x + 165, UI_DescentControl.y + 180)
    love.graphics.print("Alt.", UI_DescentControl.x + 285, UI_DescentControl.y + 180)
    love.graphics.print("R.O.D", UI_DescentControl.x + 220, UI_DescentControl.y + 70)
    love.graphics.print("DESCENT CONTROL", UI_DescentControl.x + 120, UI_DescentControl.y + UI_DescentControl.height - 50)

    love.graphics.setColor(1, 1, 1)
end

return UI_DescentControl
