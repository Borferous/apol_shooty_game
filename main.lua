local windowConfig = require('window_config')
local spawner = require('spawner')
local tools = require('tools')
local render = require('render')
local components = require('components')
local movement = require('movement')
local sprites  = require('sprites')
local center = windowConfig.center
local screenSize = windowConfig.size

local gametick = 0

local apples = {}
local arrows = {}
local playerBow = spawner.entt({
    sprite = sprites.bow,
    scale = components.size2d(0.5,0.5),
    position = components.vec2d(0,-100,true),
    rotation = -45,
    hitbox = components.size2d(125,125),
    dist = 0,
})

local debug = false
local isLose = true
local score = spawner.entt({
    value = 0,
    position = components.vec2d(0,100,true),
    size = 50,
})

function love.load()

end

function love.keypressed(key)
    if key == "space" and isLose then
        StartGame()
    elseif key == 'd' then
        debug = not debug
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.mousepressed( x, y, button, istouch, presses )
   if tools.onClick({x=x,y=y},playerBow) then
        playerBow.isPull = true
   end
end

function love.mousereleased( x, y, button, istouch, presses )
    if playerBow.isPull then
        playerBow.isPull = false
        ArrowSpawn()
    end
end

function love.draw()
    love.graphics.clear(0.25, 0.25, 0.25)

    love.graphics.draw(sprites.background,0,0)
    if not isLose then
        gametick = gametick + 1
        AppleSpawn()
        PlayerUpdate()
        tools.revForEach(arrows, ArrowUpdate)
        tools.revForEach(apples, AppleUpdate)
        render.text(score)
        if debug then
            local entts = {apples, arrows,{playerBow}}
            tools.nestedForEach(entts,render.drawHitbox)
        end
    else
        render.text({value = 'Apol Shoot Game', position = components.vec2d(0,50,true), size = 30})
        render.text({value = 'Press SPACE to start', position = components.vec2d(0,0,true), size = 25})
    end
    
end

function StartGame()
    apples = {}
    arrows = {}
    isLose = false
    score.value = 0
    gametick = 0
end

function AppleSpawn()
    if gametick % 120 == 0 then
        local side = math.random() <= 0.5 and -1 or 1 
        local sx = side * screenSize.width/2
        local sy = -25
        local vx, vy = -side * 1.5, math.random(5, 8)
        spawner.insertEntt(apples,{
            sprite = sprites.apple,
            position = components.vec2d(sx,sy,true),
            velocity = components.vec2d(vx,vy),
            scale = components.size2d(0.5,0.5),
            hitbox = components.size2d(25,25),
            rotateSpd = math.random(-10,10) * 0.025
        })
    end
end

function ArrowSpawn()
    local p = playerBow
    local dx, dy = math.sin(p.rotation), math.cos(p.rotation)
    local speed = p.dist
    spawner.insertEntt(arrows,{
        sprite = sprites.arrow,
        position = components.copyVec2d(p.position),
        velocity = components.vec2d(dx * speed,dy * speed),
        scale = components.size2d(0.5,0.5),
        hitbox = components.size2d(50,50),
        rotation = p.rotation,
        duration = 60,
    })
end

function PlayerUpdate()
    local p = playerBow
    local px, py = p.position.x, p.position.y
    local mx, my = love.mouse.getX(), love.mouse.getY()

    p.sprite = p.isPull and sprites.bowLoaded or sprites.bow
    
    if p.isPull then
        local xDiff = mx - px
        local yDiff = my - py
        p.rotation = math.atan2(yDiff, xDiff) - (math.pi / 2)
        p.isPull = true
        local px, py = p.position.x, p.position.y
        local dis = math.sqrt(xDiff ^ 2 + yDiff ^ 2) * 0.25
        local vx, vy = math.sin(p.rotation), math.cos(p.rotation)
        p.dist = dis
        for i=1, 10, 1 do
            love.graphics.circle('fill',px,py,3)
            px = px + vx * dis
            py = py - vy * dis
        end
    else
        p.rotation = 0
    end
    render.spriteEntt(playerBow)
end

function ArrowUpdate(arrow, i)
    arrow.duration = arrow.duration - 1
    if arrow.duration <= 0 then
        table.remove(arrow,i)
    end
    
    tools.revForEach(apples,function(apple,j)
        if tools.squareCollision(arrow,apple) then
            table.remove(apples,j)
            table.remove(arrows,i)
            score.value = score.value + 1
        end
    end)

    movement.applyVelocity(arrow)
    render.spriteEntt(arrow)
end

function AppleUpdate(apple, i)
    movement.rotate(apple)
    movement.applyGravity(apple)
    movement.applyVelocity(apple)
    render.spriteEntt(apple)
    if apple.position.y > windowConfig.size.height then isLose = true end
end
