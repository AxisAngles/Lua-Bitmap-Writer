--By Trey Reynolds

--Basically just gives a function an x y coordinate, and enters the returned color in some place on the image
--cx0,cy0 = lower left of renderbox on canvas
--cx1,cy1 = upper right of renderbox on canvas
--func = render function, returns r g b
--x0,y0 = lower left bound of render function coordinates
--x1,y1 = upper right bound of render function coordinates
--aa = number of horizontal samples per pixel (antialiasing x n^2)
local function renderfunction(canvas,cx0,cy0,cx1,cy1,func,x0,y0,x1,y1,aa)
	aa=aa or 1
	local aa2=aa*aa
	local sx=(x1-x0)/(cx1-cx0)
	local sy=(y1-y0)/(cy1-cy0)
	for x=cx0,cx1 do
		for y=cy0,cy1 do
			local r,g,b=0,0,0
			for i=1,aa do
				local ax=sx*(x-cx0+(i-1/2)/aa-1/2)+x0
				for j=1,aa do
					local ay=sy*(y-cy0+(j-1/2)/aa-1/2)+y0
					local newr,newg,newb=func(ax,ay)
					r,g,b=r+newr,g+newg,b+newb
				end
			end
			r=r/aa2
			g=g/aa2
			b=b/aa2
			local pix=canvas[y][x]
			pix.r,pix.g,pix.b=r,g,b
		end
	end
	return canvas
end

return renderfunction
