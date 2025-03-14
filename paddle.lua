local paddle = {}
paddle.__index = paddle

function paddle.new(x, y, width, height, speed)
	local self = setmetatable({}, paddle)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.speed = speed
	return self
end

function paddle:update(dt, upKey, downKey, screenHeight)
	if love.keyboard.isDown(upKey) then
		self.y = self.y - self.speed * dt
	end
	if love.keyboard.isDown(downKey) then
		self.y = self.y + self.speed * dt
	end
	-- Keep paddle within screen boundaries
	self.y = math.max(0, math.min(self.y, screenHeight - self.height))
end

function paddle:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return paddle
