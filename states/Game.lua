local Game              = {}

local UI_carte          = require("objects.UI.UI_carte")
local UI_module         = require("objects.UI.UI_module")
local UI_Sitepanel      = require("objects.UI.Ui_Sitepanel")
local UI_DescentControl = require("objects.UI.UI_DescentControl")

local Player            = require("objects.Rocket")

-- Vitesse maximale autorisée à l'alunissage
local MAX_LANDING_ROD   = 6


function Game.load()
    Player.load()

    UI_carte.load()
    UI_module.load()
    UI_Sitepanel.load(Player)
    UI_DescentControl.load()

    Game.state = "playing"

    love.graphics.setBackgroundColor(1, 1, 1)
end

function Game.update(dt)
    -- Ne plus mettre à jour le jeu après la fin de partie
    if Game.state ~= "playing" then
        return
    end

    -- Mise à jour du vaisseau et de sa physique
    Player.update(dt)

    -- Vérifier le contact avec le sol
    if Player.altitude <= 0 then
        local landingROD = Player.impactSpeed or math.huge

        if landingROD <= MAX_LANDING_ROD then
            Game.state = "won"
        else
            Game.state = "crashed"
        end

        return
    end

    -- Mise à jour des interfaces
    UI_carte.update(dt, Player)
    UI_module.update(dt, Player)
    UI_Sitepanel.update(dt)
    UI_DescentControl.update(dt)
end

function Game.draw()
    -- Écran de victoire
    if Game.state == "won" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle(
            "fill",
            0, 0,
            love.graphics.getWidth(),
            love.graphics.getHeight()
        )

        love.graphics.setColor(0.3, 1, 0.3)
        love.graphics.printf(
            "ALUNISSAGE REUSSI !",
            0,
            love.graphics.getHeight() / 2 - 30,
            love.graphics.getWidth(),
            "center"
        )

        love.graphics.setColor(1, 1, 1)
        return
    end

    -- Écran de crash
    if Game.state == "crashed" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle(
            "fill",
            0, 0,
            love.graphics.getWidth(),
            love.graphics.getHeight()
        )

        love.graphics.setColor(1, 0.2, 0.2)
        love.graphics.printf(
            "CRASH !",
            0,
            love.graphics.getHeight() / 2 - 30,
            love.graphics.getWidth(),
            "center"
        )

        love.graphics.setColor(1, 1, 1)
        return
    end

    -- Affichage normal du jeu
    UI_carte.draw()
    UI_module.draw()
    UI_Sitepanel.draw(Player)
    UI_DescentControl.draw(Player)

    Player.draw()
end

function Game.keypressed(key)
    -- Recommencer la partie avec R
    if key == "r" and Game.state ~= "playing" then
        Game.load()
    end
end

function Game.mousepressed(x, y, btn)

end

return Game
