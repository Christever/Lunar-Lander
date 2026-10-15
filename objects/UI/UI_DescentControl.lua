local UI_DescentControl = {}


function UI_DescentControl.load()
    UI_DescentControl.x      = 540
    UI_DescentControl.y      = 440
    UI_DescentControl.width  = 700
    UI_DescentControl.height = 340
end

function UI_DescentControl.update(dt)

end

function UI_DescentControl.draw()
     love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle(
        "fill",
        UI_DescentControl.x, UI_DescentControl.y,
        UI_DescentControl.width, UI_DescentControl.height
    )
    love.graphics.setColor(1, 1, 1)
end

return UI_DescentControl
