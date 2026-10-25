local Lose={}

function Lose.load()
    
end

function Lose.draw()
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

        love.graphics.printf(
            "PRESS 'C' TO CONTINUE !",
            0,
            love.graphics.getHeight() / 2 + 30,
            love.graphics.getWidth(),
            "center"
        )

        love.graphics.setColor(1, 1, 1)
end

function Lose.update(dt)
  
end


function Lose.keypressed(key)
    if key=="c" then
        State=require("states.Menu")
        State.load()
    end
end


return Lose