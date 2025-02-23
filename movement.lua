local movement = {}

function movement.applyVelocity(entt)
    local position = entt.position
    local velocity = entt.velocity
    position.x = position.x + velocity.x
    position.y = position.y - velocity.y
end

function movement.applyGravity(entt)
    local gravity = 0.1
    local velocity = entt.velocity
    velocity.y = math.max(velocity.y - gravity,-5)
end

function movement.rotate(entt)
    entt.rotation = entt.rotation + entt.rotateSpd
end

return movement