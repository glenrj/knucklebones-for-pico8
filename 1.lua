--board
function init_board()
	square={
		w=2,
		h=2,
		space=18
	}
	cpugrid={0,0,0,0,0,0,0,0,0}
	ccol1={}
	ccol2={}
	ccol3={}
	playergrid={0,0,0,0,0,0,0,0,0}
	pcol1={}
	pcol2={}
	pcol3={}
	--remaining={true,true,true,true,true,true,true,true,true}
    lastPlayed="player"
    --available x coordinates for selector
	playergridx={}
	playergridy={}
	add(playergridx,56)
	add(playergridx,56+square.space)
	add(playergridx,56+(square.space*2))
	add(playergridx,56)
	add(playergridx,56+square.space)
    add(playergridx,56+(square.space*2))
	add(playergridx,56)
	add(playergridx,56+square.space)
    add(playergridx,56+(square.space*2))
    --available y coordinates for selector
	add(playergridy,70)
	add(playergridy,70)
	add(playergridy,70)
	add(playergridy,70+square.space)
	add(playergridy,70+square.space)
	add(playergridy,70+square.space)
	add(playergridy,70+(square.space*2))
	add(playergridy,70+(square.space*2))
	add(playergridy,70+(square.space*2))
end

function draw_board()
	--cpu side
	draw_grid(cpugrid,56,8,square.space)
	--divider
	rectfill(50,64,116,65,13)
	--player side
	draw_grid(playergrid,56,70,square.space)
	--menu
	print("roll",12,80,7)
	print("restart",12,88,7)
end

function draw_grid(grid,x,y,space)
	sprites={}
	for i=1,9 do
		value=grid[i]
		sprite=(value+1)*2
		add(sprites,sprite,i)
	end
	--row one
	spr(sprites[1],x,y,square.w,square.h)
	spr(sprites[2],x+space,y,square.w,square.h)
	spr(sprites[3],x+(space*2),y,square.w,square.h)
	--row two
	spr(sprites[4],x,y+space,square.w,square.h)
	spr(sprites[5],x+space,y+space,square.w,square.h)
	spr(sprites[6],x+(space*2),y+space,square.w,square.h)
	--row three
	spr(sprites[7],x,y+(space*2),square.w,square.h)
	spr(sprites[8],x+space,y+(space*2),square.w,square.h)
	spr(sprites[9],x+(space*2),y+(space*2),square.w,square.h)
end

function compare_grids()
	to_col()
	if lastPlayed == "cpu" then
		for i=1,6 do
			if count(pcol1,i)>0 and count(ccol1,i)>0 then
				matches=find_match(pcol1,i)
				for i=1,#matches do
					pcol1[matches[i]]=0
				end
			end
			if count(pcol2,i)>0 and count(ccol2,i)>0 then
				matches=find_match(pcol2,i)
				for i=1,#matches do
					pcol2[matches[i]]=0
				end
			end
			if count(pcol3,i)>0 and count(ccol3,i)>0 then
				matches=find_match(pcol3,i)
				for i=1,#matches do
					pcol3[matches[i]]=0
				end
			end
		end
	end
	if lastPlayed == "player" then
		for i=1,6 do
			if count(pcol1,i)>0 and count(ccol1,i)>0 then
				matches=find_match(ccol1,i)
				for i=1,#matches do
					ccol1[matches[i]]=0
				end
			end
			if count(pcol2,i)>0 and count(ccol2,i)>0 then
				matches=find_match(ccol2,i)
				for i=1,#matches do
					ccol2[matches[i]]=0
				end
			end
			if count(pcol3,i)>0 and count(ccol3,i)>0 then
				matches=find_match(ccol3,i)
				for i=1,#matches do
					ccol3[matches[i]]=0
				end
			end
		end
	end
	to_grid()
	if count(playergrid,0)==0 or count(cpugrid,0)==0 then
		--TODO
		--change game.state to over
	end
end

function to_col()
	ccol1={cpugrid[1],cpugrid[4],cpugrid[7]}
	ccol2={cpugrid[2],cpugrid[5],cpugrid[8]}
	ccol3={cpugrid[3],cpugrid[6],cpugrid[9]}
	pcol1={playergrid[1],playergrid[4],playergrid[7]}
	pcol2={playergrid[2],playergrid[5],playergrid[8]}
	pcol3={playergrid[3],playergrid[6],playergrid[9]}
end

function to_grid()
	playergrid[1]=pcol1[1]
	playergrid[2]=pcol2[1]
	playergrid[3]=pcol3[1]
	playergrid[4]=pcol1[2]
	playergrid[5]=pcol2[2]
	playergrid[6]=pcol3[2]
	playergrid[7]=pcol1[3]
	playergrid[8]=pcol2[3]
	playergrid[9]=pcol3[3]
	cpugrid[1]=ccol1[1]
	cpugrid[2]=ccol2[1]
	cpugrid[3]=ccol3[1]
	cpugrid[4]=ccol1[2]
	cpugrid[5]=ccol2[2]
	cpugrid[6]=ccol3[2]
	cpugrid[7]=ccol1[3]
	cpugrid[8]=ccol2[3]
	cpugrid[9]=ccol3[3]
end