local windowConfig = require('window_config')
local center = windowConfig.center
local render = {}

function render.rect(style, pos, size, color, rotation)
    local rotation = rotation or 0
    local w, h = size.width, size.height
    local r, g, b, a = color.r, color.g, color.b, color.a

    love.graphics.push()
    love.graphics.setColor(r, g, b, a)
    love.graphics.translate(pos.x,pos.y)
    love.graphics.rotate(rotation)
    love.graphics.rectangle(style, - w / 2, -h / 2, w, h)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.pop()
end

function render.sprite(sprite, position, scale, rotation)
    local origWidth, origHeight = sprite:getWidth(), sprite:getHeight()

    local offsetX = origWidth / 2
    local offsetY = origHeight / 2

    love.graphics.draw(sprite, position.x, position.y, rotation, scale.width, scale.height, offsetX, offsetY)
end

function render.spriteEntt(entt)
    local sprite = entt.sprite
    local x, y = entt.position.x, entt.position.y
    local sw, sh = entt.scale.width, entt.scale.height
    local r = entt.rotation
    local ox, oy = sprite:getWidth() / 2, sprite:getHeight() / 2
    love.graphics.draw(sprite,x,y,r,sh,sw,ox,oy)
end

function render.drawHitbox(entt)
    local x, y = entt.position.x, entt.position.y
    local w, h = entt.hitbox.width, entt.hitbox.height
    love.graphics.rectangle('line',x-w/2,y-h/2,w,h)
end

function render.text(txt)
    local font = love.graphics.newFont(txt.size)
    love.graphics.setFont(font)
    local textWidth = font:getWidth(txt.value)
    local textHeight = font:getHeight()
    local x, y = txt.position.x, txt.position.y
    local r, g, b, a = 0.15,0.15,0.15,1
    
    love.graphics.setColor(r,g,b,a)
    love.graphics.print(txt.value, x - textWidth / 2, y - textHeight / 2)
    love.graphics.setColor(1,1,1,1)
    
end



return render