local windowConfig = {}

local window_width = 500
local window_height = 500
local window_title = 'Shoot Game'

windowConfig.size = {
    width = window_width,
    height = window_height
}

windowConfig.center = {
    x = window_width / 2,
    y = window_height / 2,
}

windowConfig.title = window_title

love.window.setTitle(window_title)
love.window.setMode(window_width,window_height,{
    fullscreen = false
})

return windowConfig