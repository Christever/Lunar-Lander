local Won = {}

function Won.load()

end

function Won.draw()
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

     love.graphics.printf(
            "PRESS 'C' TO CONTINUE !",
            0,
            love.graphics.getHeight() / 2 + 30,
            love.graphics.getWidth(),
            "center"
        )

    love.graphics.setColor(1, 1, 1)
end

function Won.update(dt)

end

function Won.keypressed(key)
     if key=="c" then
        State=require("states.Menu")
        State.load()
    end
end

return Won
