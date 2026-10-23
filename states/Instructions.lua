local Instructions = {}

function Instructions.load()
    love.graphics.setBackgroundColor(Color.BLACK)
end

function Instructions.update(dt)

end

function Instructions.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    love.graphics.setBackgroundColor(Color.BLACK)
    love.graphics.setColor(Color.WHITE)

    -- Titre
    love.graphics.setFont(FontMedium)

    local title = "INSTRUCTIONS"
    local titleWidth = FontMedium:getWidth(title)

    love.graphics.print(
        title,
        (screenWidth - titleWidth) / 2,
        100
    )

    -- Texte des instructions
    local instructions = {
        "PROJET EN COURS DE DEVELOPPEMENT",
        "",
        "OBJECTIF",
        "Rejoindre la zone cible et effectuer un alunissage en douceur.",
        "",
        "COMMANDES",
        "Fleches directionnelles : deplacer la cible sur la carte.",
        "SPACE : augmenter la poussee verticale pour freiner la descente.",
        "",
        "CONSIGNES D'ALUNISSAGE",
        "Surveillez l'altitude et le taux de descente R.O.D.",
        "Le R.O.D. doit etre compris entre 0 et -6 pour eviter le crash.",
        "Une vitesse de descente trop elevee provoque un crash.",
        "",
        "Bonne chance, pilote !",
        "",
        "Appuyez sur ESCAPE pour revenir au menu."
    }

    -- Affichage du texte
    local lineHeight = 30
    local startY = 190

    love.graphics.setFont(FontSmall or FontMedium)

    for i, line in ipairs(instructions) do
        local font = love.graphics.getFont()
        local lineWidth = font:getWidth(line)

        love.graphics.print(
            line,
            (screenWidth - lineWidth) / 2,
            startY + (i - 1) * lineHeight
        )
    end

    love.graphics.setColor(1, 1, 1)
end

function Instructions.keypressed(key)
    if key == "escape" or key == "backspace" then
        State = require("states.Menu")
        State.load()
    end
end

function Instructions.mousepressed(x, y, btn)

end

return Instructions
