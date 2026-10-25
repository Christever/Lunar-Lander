local Title = {}

function Title.load()
    love.window.setMode(650,800)
    Title.image = love.graphics.newImage("assets/Images/title1.jpg")
    love.graphics.setFont(FontXXL)
end

function Title.update(dt)

end

function Title.draw()
    love.graphics.draw(Title.image, 0, 0)
    love.graphics.print("PRESS SPACE", 220, 10)
end

function Title.keypressed(key)
    if key == "space" then
        State = require("states.Menu")
        State.load()
    end
end

return Title
