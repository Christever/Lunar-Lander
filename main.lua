io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")

require("core.Reg")

State = require("states.Title")


function love.load()
    FontSmall  = love.graphics.newFont("assets/Fonts/PixelMaster.ttf", 24)
    FontMedium = love.graphics.newFont("assets/Fonts/PixelMaster.ttf", 36)
    FontLarge  = love.graphics.newFont("assets/Fonts/PixelMaster.ttf", 48)
    FontXXL    = love.graphics.newFont("assets/Fonts/PixelMaster.ttf", 64)

    FontUI = love.graphics.newFont("assets/Fonts/pong-score.ttf",36)

    love.window.setTitle("LUNAR LANDER")
    
    love.graphics.setBackgroundColor(0.02, 0.03, 0.10)
    State.load()
end

function love.update(dt)
    State.update(dt)
end

function love.draw()
    State.draw()
end

function love.keypressed(key, isrepeat)
    if State.keypressed then
        State.keypressed(key)
    end
end

function love.mousepressed(x, y, btn)
    if State.mousepressed then
        State.mousepressed(x, y, btn)
    end
end
