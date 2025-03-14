local ball = {}

function ball.load(screenWidth, screenHeight)
	ball.x = screenWidth / 2
	ball.y = screenHeight / 2
	ball.radius = 10
	ball.dx = 200 -- horizontal speed
	ball.dy = 150 -- vertical speed
end

-- function ball.reset(screenWidth, screenHeight)
-- 	ball.x = screenWidth / 2
-- 	ball.y = screenHeight / 2
--
-- 	-- Randomize direction for dx and dy
-- 	ball.dx = 200 * (math.random(0, 1) == 0 and -1 or 1)
-- 	ball.dy = 150 * (math.random(0, 1) == 0 and -1 or 1)
-- end

function ball.update(dt, screenWidth, screenHeight)
	ball.x = ball.x + ball.dx * dt
	ball.y = ball.y + ball.dy * dt

	-- Bounce off top and bottom edges
	if ball.y - ball.radius < 0 or ball.y + ball.radius > screenHeight then
		ball.dy = -ball.dy
	end
end

function ball.draw()
	love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

return ball
