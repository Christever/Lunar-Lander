local UI_module = {}

function UI_module.load()
    UI_module.x      = 640
    UI_module.y      = 20
    UI_module.width  = 600
    UI_module.height = 400
end

function UI_module.update(dt)

end

function UI_module.draw()
     love.graphics.setColor(0,0,0)
     love.graphics.rectangle(
        "fill",
        UI_module.x, UI_module.y,
        UI_module.width, UI_module.height
     )
     love.graphics.setColor(1,1,1)
end

return UI_module
