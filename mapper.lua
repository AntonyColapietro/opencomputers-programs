local P = require "path"



 function writePlan(x,y,index)
 
 if x%2 == 0 then             --if x is even, then all the plans have the same path
  for i = 1,x do

	--P.updatePath(P.ypath)     
	--P.corner(i)
	P.addStraightLineWithOptionalCornerToPlan(i,true)

  end

else   

   if index%2 == 1  then
	 for i = 1,x do

	--   P.updatePath(P.ypath)
	--   P.corner(i)
	    P.addStraightLineToPathWithOptionalCornerToPlan(i,true)
	 end

   else

	  for i = 1,x do

		--P.updatePath(P.ypath)
	--  	P.corner(i+1)
		P.addStraightLineToPathWithOptionalCornerToPlan(i+1,true)
	  end

   end

end

  P.addStraightLineToPathWithOptionalCornerToPlan(-1,false)

end





  function writePath(x,y,z)

   --initiliaze parts of the path

   local x1 = x-1        --local variables for transitions (transitions between blocks, for x and y their number is equal to number of blocks -1)

   local y1 = y-1

   local z1 = z+2     --count level over the turtle at home position (if turtle start at height N, then it will stop at height N-z1, digging  N+1 levels of blocks) 

   P.init(y1)
   
   writeCube(x1,y1,z1)

  end



  function writeCube(x,y,z)

   if z < 3 then   --handle cases where it could be dig just 1 level or Z<0
       writePlan(x,y,1)
       return
    end

   local rest = z % 3

   local div = math.floor(z/3)


   for i = 1,div do
	   writePlan(x,y,i)
	   if(i < div) then
	      P.addVerticalTransitiontToPath(P.zpathO)
         else
       	    if rest == 0 then
       	     	return
       	     elseif rest == 1 then
       	     	P.addVerticalTransitiontToPath(P.zpathL)
       	     elseif rest == 2 then
       	    	P.addVerticalTransitiontToPath(P.zpathE)
       	    end
       	     	 writePlan(x,y,i+1)
	    end

	   end

	 end