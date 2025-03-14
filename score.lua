local score = {}
local leftScore, rightScore = 0, 0

function score.reset()
	leftScore = 0
	rightScore = 0
end

function score.increase(side)
	if side == "left" then
		leftScore = leftScore + 1
	elseif side == "right" then
		rightScore = rightScore + 1
	end
end

function score.draw(screenWidth)
	love.graphics.print("Player 1: " .. leftScore, 50, 20)
	love.graphics.print("Player 2: " .. rightScore, screenWidth - 350, 20)
end

return score
