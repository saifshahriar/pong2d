_G.love = require("love")

local ball = require("ball")
local paddle = require("paddle")
local collision = require("collision")
local score = require("score")

function love.load()
	--- Load assets
	img = love.graphics.newImage("assets/images/bg.png")

	love.window.setMode(800, 600, { resizable = true, fullscreen = true })
	love.window.showMessageBox("Meow!", "You are about to go fullscreen.\nTo exit from the programme, press Ctrl + q")

	local font = love.graphics.newFont(50)
	love.graphics.setFont(font)

	screenWidth, screenHeight = love.graphics.getDimensions()

	-- Initialize ball and paddles
	ball.load(screenWidth, screenHeight)
	local paddleWidth, paddleHeight = 20, 100
	local paddleSpeed = 300
	leftPaddle = paddle.new(30, (screenHeight - paddleHeight) / 2, paddleWidth, paddleHeight, paddleSpeed)
	rightPaddle = paddle.new(
		screenWidth - 30 - paddleWidth,
		(screenHeight - paddleHeight) / 2,
		paddleWidth,
		paddleHeight,
		paddleSpeed
	)

	-- Reset scores
	score.reset()

	-- Seed random for ball reset randomness
	math.randomseed(os.time())
end

function love.update(dt)
	local width, height = love.graphics.getDimensions()

	-- Update paddles (left uses W/S, right uses Up/Down)
	leftPaddle:update(dt, "w", "s", height)
	rightPaddle:update(dt, "k", "j", height)

	-- Update ball position and bounce off top/bottom
	ball.update(dt, width, height)

	-- Handle collisions with paddles using our collision helper
	if
		collision.circleRect(
			ball.x,
			ball.y,
			ball.radius,
			leftPaddle.x,
			leftPaddle.y,
			leftPaddle.width,
			leftPaddle.height
		)
	then
		-- Bounce ball to the right
		ball.dx = math.abs(ball.dx)
	end

	if
		collision.circleRect(
			ball.x,
			ball.y,
			ball.radius,
			rightPaddle.x,
			rightPaddle.y,
			rightPaddle.width,
			rightPaddle.height
		)
	then
		-- Bounce ball to the left
		ball.dx = -math.abs(ball.dx)
	end

	-- Check for scoring: if ball goes off-screen, update the score and reset ball
	if ball.x + ball.radius < 0 then
		score.increase("right")
		ball.x = screenWidth / 2
		ball.y = screenHeight / 2
		-- Randomize direction for dx and dy
		ball.dx = 200 * (math.random(0, 1) == 0 and -1 or 1)
		ball.dy = 150 * (math.random(0, 1) == 0 and -1 or 1)
	end

	if ball.x - ball.radius > width then
		score.increase("left")
		ball.x = screenWidth / 2
		ball.y = screenHeight / 2
		-- Randomize direction for dx and dy
		ball.dx = 200 * (math.random(0, 1) == 0 and -1 or 1)
		ball.dy = 150 * (math.random(0, 1) == 0 and -1 or 1)
	end
end

function love.draw()
	local width, _ = love.graphics.getDimensions()

	love.graphics.draw(img, 0, 0)

	-- Draw game objects
	ball.draw()
	leftPaddle:draw()
	rightPaddle:draw()
	score.draw(width)
end

function love.keypressed(key)
	-- Quit on Ctrl + Q
	if key == "q" and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
		love.event.quit()
	end
end
