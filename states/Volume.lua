local Volume = {}

Volume.volume = 0.5
Volume.sound = nil

function Volume.load()
    if Volume.sound then
        Volume.sound:stop()
    end

    Volume.sound = love.audio.newSource("assets/sounds/Alarm.wav", "static")
    Volume.sound:setLooping(true)
    Volume.sound:play()
    
    Volume.volume = 0.5
    love.audio.setVolume(Volume.volume)
end

function Volume.update(dt)
    if love.keyboard.isDown("up") then
        Volume.volume = math.min(Volume.volume + dt * 0.5, 1.0)
        love.audio.setVolume(Volume.volume)
    end

    if love.keyboard.isDown("down") then
        Volume.volume = math.max(Volume.volume - dt * 0.5, 0.0)
        love.audio.setVolume(Volume.volume)
    end
end

function Volume.draw()
    love.graphics.setFont(FontLarge)
    love.graphics.printf(
        "Volume actuel : ".. math.floor(Volume.volume * 100) .. "%",
        0,
        love.graphics.getHeight() / 2 - 200,
        love.graphics.getWidth(),
        "center"
    )

    love.graphics.printf(
        "Utilisez les flèches HAUT et BAS pour régler le son.",
        0,
        love.graphics.getHeight() / 2 - 100,
        love.graphics.getWidth(),
        "center"
    )
    
    love.graphics.setFont(FontSmall)
    love.graphics.printf(
        "SPACE ou RETURN pour valider et quitter",
        0,
        love.graphics.getHeight() / 2 + 100,
        love.graphics.getWidth(),
        "center"
    )
end

function Volume.keypressed(key)
    if key=="space" or key=="return" then
        Volume.sound:stop()
        State=require("states.Menu")
        State.load()
    end
end



return Volume
