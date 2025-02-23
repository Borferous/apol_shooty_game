local spriteKeys = {
    apple = 'apple.png',
    arrow = 'arrow.png',
    bow = 'bow.png',
    bowLoaded = 'bow_shoot.png',
    background = 'background.png',
}

local sprites = {}

for key, value in pairs(spriteKeys) do
    sprites[key] = love.graphics.newImage('assets/' .. value)
end

return sprites