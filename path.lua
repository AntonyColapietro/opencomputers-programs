local P = {}



local C = require ("constant")



P.path={}
P.ypath={}
P.xpathD={{C.D,2}}
P.xpathA={{C.A,2}}
P.zpathO={{C.Q,3},{C.S,1}}  --path used for odd Z transitions or even Z transitions
P.zpathE={{C.Q,2},{C.S,1}}
P.zpathL={{C.Q,1},{C.S,1}}  --corner case in odd Z transitions





function P.writeStep(whichpath,direction,position)
  whichpath[position]=direction
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
  
  P.ypath= {{C.W,straightLineLimit-1}}


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
  P.path={{C.W,1}}    --counting first step
  P.prepareStraightLinePath(lengthOfStraightLine)
end




return P