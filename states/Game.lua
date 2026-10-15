local Game              = {}

local UI_carte          = require("objects.UI.UI_carte")
local UI_module         = require("objects.UI.UI_module")
local UI_Sitepanel      = require("objects.UI.Ui_Sitepanel")
local UI_DescentControl = require("objects.UI.UI_DescentControl")

local Player            = require("objects.Rocket")

function Game.load()
    Player.load()

    UI_carte.load()
    UI_module.load()
    UI_Sitepanel.load(Player)
    UI_DescentControl.load()


    love.graphics.setBackgroundColor(1, 1, 1)
end

function Game.update(dt)
    Player.update(dt)
    UI_carte.update(dt, Player)
    UI_module.update(dt)
    UI_Sitepanel.update(dt)
    UI_DescentControl.update(dt)
end

function Game.draw()
    UI_carte.draw()
    UI_module.draw()
    UI_Sitepanel.draw(Player)
    UI_DescentControl.draw(Player)

    Player.draw()
end

function Game.keypressed(key)
    if key == "r" then

    end
end

function Game.mousepressed(x, y, btn)

end

return Game
