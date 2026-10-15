local Game              = {}

local UI_carte          = require("objects.UI.UI_carte")
local UI_module         = require("objects.UI.UI_module")
local UI_Sitepanel      = require("objects.UI.Ui_Sitepanel")
local UI_DescentControl = require("objects.UI.UI_DescentControl")

local Player            = require("objects.Rocket")

function Game.load()
    UI_carte.load()
    UI_module.load()
    UI_Sitepanel.load()
    UI_DescentControl.load()

    Player.load()

    love.graphics.setBackgroundColor(1, 1, 1)
end

function Game.update(dt)
    Player.update(dt)
    UI_carte.updateShipPosition(Player)
end

function Game.draw()
    UI_carte.draw(Player)
    UI_module.draw()
    UI_Sitepanel.draw()
    UI_DescentControl.draw()

    Player.draw()
end

function Game.keypressed(key)
    if key == "r" then

    end
end

function Game.mousepressed(x, y, btn)

end

return Game
