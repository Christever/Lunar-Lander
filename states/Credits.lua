local Credits = {}

-- Structure contenant les informations de nos liens
local links = {
    { text = "Gamecodeur : https://gamecodeur.fr/!",       url = "https://gamecodeur.fr/" },
    { text = "Mon portfolio : https://steverlynck.fr/",    url = "https://steverlynck.fr/" },
    { text = "Mon github : https://github.com/christever", url = "https://github.com/christever" }
}

-- Liste des lignes de texte statiques
local creditLines = {
    "PROJET EN COURS DE DEVELOPPEMENT",
    "",
    "Réalisé pour la Gamecodeur Community Gamejam #4.",
    "",
    "Code : Christever",
    "Graphisme: Sur le net (j'ai publié où...)",
    "",
    "Merci à David pour m'avoir redonné le gout à la programmtion,",
    "aussi bien pour les jeux ou applications.",
    ""
}

function Credits.load()
    love.graphics.setBackgroundColor(Color.BLACK)
    Credits.image = love.graphics.newImage("assets/Images/dm.png")
end

function Credits.update(dt)
end

function Credits.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    love.graphics.setBackgroundColor(Color.BLACK)
    love.graphics.setColor(Color.WHITE)

    love.graphics.draw(
        Credits.image,
        screenWidth / 2 - Credits.image:getWidth() / 2,
        20
    )


    -- 1. Titre
    love.graphics.setFont(FontMedium)
    local title = "Credits"
    local titleWidth = FontMedium:getWidth(title)
    love.graphics.print(title, (screenWidth - titleWidth) / 2, 150)

    -- 2. Configuration de l'affichage du corps du texte
    love.graphics.setFont(FontSmall or FontMedium)
    local font = love.graphics.getFont()
    local lineHeight = 30
    local currentY = 190
    local mouseX, mouseY = love.mouse.getPosition()

    -- 3. Affichage du texte de crédit standard
    for _, line in ipairs(creditLines) do
        local lineWidth = font:getWidth(line)
        love.graphics.print(line, (screenWidth - lineWidth) / 2, currentY)
        currentY = currentY + lineHeight
    end


    -- 4. Affichage des liens interactifs avec effet visuel au survol
    for _, link in ipairs(links) do
        local lineWidth = font:getWidth(link.text)
        local startX = (screenWidth - lineWidth) / 2

        -- On stocke dynamiquement la zone du lien pour la collision de la souris
        link.x = startX
        link.y = currentY
        link.w = lineWidth
        link.h = font:getHeight()

        -- Si la souris survole le lien, on change sa couleur et on le souligne
        if mouseX >= link.x and mouseX <= link.x + link.w and mouseY >= link.y and mouseY <= link.y + link.h then
            love.graphics.setColor(0.3, 0.6, 1)                                           -- Couleur Bleue au survol
            love.graphics.line(link.x, link.y + link.h, link.x + link.w, link.y + link.h) -- Soulignement
        else
            love.graphics.setColor(1, 1, 1)                                               -- Couleur Blanche par défaut
        end

        love.graphics.print(link.text, startX, currentY)
        currentY = currentY + lineHeight
    end

    -- 5. Message de fin
    love.graphics.setColor(1, 1, 1)
    currentY = currentY + (lineHeight * 3) -- Espacement

    local escapeText = "Appuyez sur ESCAPE pour revenir au menu."
    local escapeWidth = font:getWidth(escapeText)
    love.graphics.print(escapeText, (screenWidth - escapeWidth) / 2, currentY)
end

function Credits.keypressed(key)
    if key == "escape" or key == "backspace" then
        State = require("states.Menu")
        State.load()
    end
end

function Credits.mousepressed(x, y, btn)
    -- Détection du clic gauche (1) sur un lien actif
    if btn == 1 then
        for _, link in ipairs(links) do
            -- On vérifie si la boîte de collision du lien a été définie et cliquée
            if link.x and x >= link.x and x <= link.x + link.w and y >= link.y and y <= link.y + link.h then
                love.system.openURL(link.url)
                break -- Optionnel : évite de déclencher d'autres liens s'ils se superposent
            end
        end
    end
end

return Credits
