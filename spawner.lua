local components = require('components')
local spawner = {}

-- This file contains the data templates for each entity

function spawner.entt(param)
    param = param or {}
    -- Default Values
    local entt = {
        position = components.vec2d(0,0,true),
        velocity = components.vec2d(0,0),
        scale = components.size2d(1,1),
        hitbox = components.size2d(10,10),
        rotation = 0,
    }
    -- Replace default values as well as adding new values
    for key, value in pairs(param) do
        entt[key] = value
    end
    return entt
end

function spawner.insertEntt(tbl,param)
    table.insert(tbl,spawner.entt(param))
end

function spawner.floatText(param)
    param = param or {}
    local text = {
        value = '',
        position = components.vec2d(0,0,true),
        textSize = 10,
        color = components.color(1,1,1,1)
    }
    for key, value in pairs(param) do
        text[key] = value
    end
    return text
end

return spawner