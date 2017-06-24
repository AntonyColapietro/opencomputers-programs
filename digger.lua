

local R = require("robot") 
local B = require("battery") 
local M = require("mapper") 
local W = require("walker") 



B.setThreshold(0.5)


XValue=4
YValue=4
numberOfLevels=5

local road = M.writePath(XValue,YValue,numberOfLevels)

local robotCouldNotMove=false

for i=1,#road do


if(robotCouldNotMove)then
	break
end

step = road[i]
directionOfStep = step[1]
numberOfIdenticalSteps = step[2]

io.write("moving ")
io.write(directionOfStep)
io.write(" for ")
io.write(numberOfIdenticalSteps)
io.write("\n")

for j=1,numberOfIdenticalSteps do

if(R.detectUp() and not R.suckUp()) then
R.swingUp()
end

R.swingDown()

if( not W.move(directionOfStep)) then
	robotCouldNotMove =true
	break
end

B.checkAndRechargeBatteryIfNeeded()

end


end

R.swingDown()
R.swingUp()

local currentPosition = 1

while currentPosition  < numberOfLevels do
	
	if W.move("up") then
	 currentPosition = currentPosition + 1
	 else
	   W.move("back")
	   R.turnAround()
	
	 end

end