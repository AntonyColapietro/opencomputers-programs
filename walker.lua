local W={}

local C = require("constant")

local robot = require("robot")


function W.turnAround()
  return robot.turnAround()
end

function isPassed(direction)
  if direction==C.W then
    return robot.forward()
  end
  if direction==C.S then
    robot.turnAround()
    return robot.forward()
  end
  if direction==C.D  then
    robot.turnRight()
    return robot.forward()
  end
  if direction==C.A then
    robot.turnLeft()
    return robot.forward()
  end
  if direction==C.E then
    return robot.up()
  end
  if direction==C.Q then
    return robot.down()
  end

end


function check(direction)
  if direction==C.W or direction==C.D or direction==C.A or direction==C.S then
    robot.swing()
  end
  if direction==C.E then
    robot.swingUp()
  end
  if direction==C.Q then
    robot.swingDown()
  end
end

function W.move(direction)
  local passed=isPassed(direction)
  local limitofchecks=0
  while not (passed) and limitofchecks<20 do
    check(direction)
    limitofchecks=limitofchecks+1
    os.sleep(1)
    if direction==C.W or direction==C.D or direction==C.A or direction==C.S then
      passed=isPassed(C.W)
    else
      passed=isPassed(direction)
    end
  end
  if not (passed) then
    print("Error:Obstacle found on the way")
    -- goHome() TODO: implement this concept
    -- maybe move(direction) can return a boolean to get success/error of the movement

  else
    return true
  end
end



return W