local tools = {}

function tools.forEach(arr,fn)
    for _, value in ipairs(arr) do
        fn(value)
    end
end

function tools.nestedForEach(arrs,fn)
    tools.forEach(arrs,function (arr)
        tools.forEach(arr,fn)    
    end)
end

function tools.revForEach(arr,fn)
    for i = #arr, 1, -1 do
        local value = arr[i]
        fn(value,i)
    end
end

function tools.circleCollision(posA, sizeA, posB, sizeB)
    local dx = posA.x - posB.x
    local dy = posA.y - posB.y
    local distanceSquared = dx * dx + dy * dy
    local radiusSum = (sizeA + sizeB) / 2
    return distanceSquared <= radiusSum * radiusSum
end

function tools.squareCollision(enttA,enttB)
    local posA, hitboxA = enttA.position, enttA.hitbox
    local posB, hitboxB = enttB.position, enttB.hitbox
    local ax, ay, bx, by = posA.x, posA.y, posB.x, posB.y
    local aw, ah, bw, bh = hitboxA.width, hitboxA.height, hitboxB.width, hitboxB.height
    return math.abs(ax - bx) < (aw + bw) / 2
    and    math.abs(ay - by) < (ah + bh) / 2
end

function tools.onClick(mouse,entt)
    local mx, my = mouse.x, mouse.y
    local ex, ey = entt.position.x, entt.position.y
    local ew, eh = entt.hitbox.width, entt.hitbox.height
    return math.abs(mx - ex) < ew / 2
    and    math.abs(my - ey) < eh / 2
end

return tools
