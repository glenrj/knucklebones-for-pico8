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
    lastplayed="player"
    --available x coordinates for selector
	--todo hard code/collapse
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
	draw_grid(cpugrid,59,6,square.space)
	--divider
	rectfill(51,63,117,64,13)
	--player side
	draw_grid(playergrid,59,70,square.space)
	if game.state == "game" then
		--menu
		print("roll",20,72,7)
		print("restart",14,80,7)
		print("rules",17,88,7)
	end
end

function draw_grid(grid,x,y,space)
	sprites={}
	xcoords={x,x+space,x+(space*2),x,x+space,x+(space*2),x,x+space,x+(space*2)}
	ycoords={y,y,y,y+space,y+space,y+space,y+(space*2),y+(space*2),y+(space*2)}
	newcol1={grid[1],grid[4],grid[7]}
	newcol2={grid[2],grid[5],grid[8]}
	newcol3={grid[3],grid[6],grid[9]}

	for i=1,9 do
		value=grid[i]
		sprite=(value+1)*2
		coloura=6
		colourb=7
		add(sprites,sprite,i)
		--set colour based on amount per column
		if i==1 or i==4 or i==7 then
			colmult=count(newcol1,value)
		elseif i==2 or i==5 or i==8 then
			colmult=count(newcol2,value)
		elseif i==3 or i==6 or i==9 then
			colmult=count(newcol3,value)
		end
		if colmult == 2 then
			coloura=9
			colourb=10
		elseif colmult == 3 then
			coloura=3
			colourb=11
		end
		--change colour palette
		pal(6,coloura)
		pal(7,colourb)
		--draw sprite
		spr(sprites[i],xcoords[i],ycoords[i],square.w,square.h)
		--reset colour palette
		pal()
	end
end

function compare_grids()
	scores.player=update_score(playergrid)
	scores.cpu=update_score(cpugrid)
	to_col()
	if lastplayed == "cpu" then
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
	if lastplayed == "player" then
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

	if count(pcol1,0)>0 then
		selector.cols[1]=true
	end
	if count(pcol2,0)>0 then
		selector.cols[2]=true
	end
	if count(pcol3,0)>0 then
		selector.cols[3]=true
	end
	if count(pcol1,0)==0 then
		selector.cols[1]=false
	end
	if count(pcol2,0)==0 then
		selector.cols[2]=false
	end
	if count(pcol3,0)==0 then
		selector.cols[3]=false
	end

	to_grid()
	if count(playergrid,0)==0 or count(cpugrid,0)==0 then
		selector.visible=false
		selector.position=1
		selector.mode="over"
		game.state="over"
		if scores.player >= scores.cpu then
			game.winner=true
		else
			game.winner=false
		end
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