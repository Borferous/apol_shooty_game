local windowConfig = require('window_config')
local components = {}

local center = windowConfig.center

function components.vec2d(x,y,centered)
    local centered = centered or false
    local x = x or 0
    local y = y or 0
    return centered and {
        x = center.x + x,
        y = center.y - y
    } or {
        x = x,
        y = y,
    }
end

function components.copyVec2d(vec)
    return {
        x = vec.x,
        y = vec.y
    }
end

function components.size2d(w,h)
    return {
        width = w or 20,
        height = h or 20,
    }
end

function components.color(r,g,b,a)
    return {
        r = r or 1,
        g = g or 1,
        b = b or 1,
        a = a or 1,
    }
end

return components