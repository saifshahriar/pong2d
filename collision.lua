local collision = {}

function collision.circleRect(cx, cy, radius, rx, ry, rw, rh)
	local closestX = math.max(rx, math.min(cx, rx + rw))
	local closestY = math.max(ry, math.min(cy, ry + rh))

	local dx = cx - closestX
	local dy = cy - closestY

	return (dx * dx + dy * dy) < (radius * radius)
end

return collision
