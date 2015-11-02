local cos=math.cos
local sin=math.sin
local function grad(x)
	if x then
		local th=x%1*6.2831853071796
		local co=1/4*cos(th)
		local si=3^0.5/4*sin(th)
		return 1/2+2*co,
			1/2+si-co,
			1/2-si-co
	else
		return 0,0,0
	end
end


local function complex(x,y)
	local i=1/12*y*(-(35/((2+x)*(2+x)+y*y))+(4*(2+x*(14+5*x)+5*y*y))/((1+x+x*x)*(1+x+x*x)+(-1+2*x*(1+x))*y*y+y*y*y*y)+(3*(-36+(-32+x)*x+y*y))/((4+x*(2+x))*(4+x*(2+x))+2*(-2+x*(2+x))*y*y+y*y*y*y))
	local r=1/12*((35*(2+x))/((2+x)*(2+x)+y*y)-(3*(-64+18*y*y+x*(-28+(-14+x)*x+y*y)))/((4+x*(2+x))*(4+x*(2+x))+2*(-2+x*(2+x))*y*y+y*y*y*y)-(4*(7-2*y*y+x*(12+x*(12+5*x)+5*y*y)))/((1+x+x*x)^2+(-1+2*x*(1+x))*y*y+y*y*y*y))

	local abs=(sin(6.28318*r)+1)/2
	local r,g,b=grad(i)
	return r*abs,g*abs,b*abs
end

local pic=newcanvas(1920,1080)
renderfunction(pic,
	1,1,				--lower left of renderbox on canvas
	1920,1080,			--upper right of renderbox on canvas
	complex,			--render function, returns r g b
	4*-1920/1080,4*-1,	--lower left bound of render function coordinates
	4*1920/1080,4*1,	--upper right bound of render function coordinates
	4					--number of horizontal samples per pixel (antialiasing x n^2)
)
pic:save("prettycoolmang.bmp")
