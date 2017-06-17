local B={}


local C = require("constant")
local robot = require("robot") 
local computer = require("computer")
local walker = require("walker") 




B.threshold =nil;


function B.setThreshold(threshold)

       B.threshold = threshold

end

function getPercentOfEnergyLeft()

energyLeft = computer.energy()
fullEnergy = computer.maxEnergy()

return energyLeft/fullEnergy


end

function B.checkAndRechargeBatteryIfNeeded()

if B.threshold == nil then

   B.setThreshold(0.3)

end


if getPercentOfEnergyLeft() > B.threshold  then
return
end

isDownAirBlock = robot.detectDown() and robot.swingDown() or not robot.detectDown()
isUpAirBlock = robot.detectUp() and robot.swingUp() or not robot.detectUp()





if isDownAirBlock and isUpAirBlock  then
    robot.select(1)
	if robot.placeDown() then
	      robot.select(2)
	      if walker.move(C.E) then
		   if robot.placeDown() then
		       if robot.select(3)==3 then
     			  walker.move(C.S)
				  walker.turnAround() 
				  robot.place()
				  walker.move(C.Q)
				  while(getPercentOfEnergyLeft()< 0.95 ) do
				  os.sleep(1)
				  end
				  robot.select(2)
				  walker.move(C.W)
				  robot.select(1)
				  robot.swingDown()
				  robot.select(3)
				  robot.swingUp()
				end
			end				  
		   end
	end
	
end

end


return B	
	