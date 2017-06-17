local P = {}



local C = require ("constant")



P.path={}
P.ypath={}
P.xpathD={C.D,C.D}
P.xpathA={C.A,C.A}
P.zpathO={C.Q,C.Q,C.Q,C.S}  --path used for odd Z transitions or even Z transitions
P.zpathE={C.Q,C.Q,C.S}
P.zpathL={C.Q,C.S}  --corner case in odd Z transitions





function P.writeStep(whichpath,direction,position)
  table.insert(whichpath,position,direction)
end



function P.updatePath(list)

  for i=1,#list do
    P.writeStep(P.path,list[i],#P.path+1)
  end

end

function P.corner(index)

  if index%2==1 then
    P.updatePath(P.xpathD)
  else
    P.updatePath(P.xpathA)
  end

end



function P.prepareStraightLinePath(straightLineLimit) --ypath (excluded first step, change of column right/left (x) and change of level (S key count as a W fo walker.lua) (z))

  for j = 2,straightLineLimit do
    P.writeStep(P.ypath,C.W,C.FIRST)
  end

end


function P.addStraightLineToPathWithOptionalCornerToPlan(lineIndex,shouldAddCorner) --ypath (excluded first step, change of column right/left (x) and change of level (S key count as a W fo walker.lua) (z))

  P.updatePath(P.ypath)

  if(shouldAddCorner == true) then
    P.corner(lineIndex)
  end

end



function P.addVerticalTransitiontToPath(transitionPath) --ypath (excluded first step, change of column right/left (x) and change of level (S key count as a W fo walker.lua) (z))

  P.updatePath(transitionPath)

end


function P.init(lengthOfStraightLine)  --initiliaze y-axis path and add first step
  P.path={C.W}    --counting first step
  P.prepareStraightLinePath(lengthOfStraightLine)
end




return P