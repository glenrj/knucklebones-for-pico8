--board
function init_board()
	square={
		w=2,
		h=2,
		space=18
	}
	cpugrid={0,0,0,0,0,0,0,0,0}
	playergrid={0,0,0,0,0,0,0,0,0}
	--remaining={true,true,true,true,true,true,true,true,true}
    lastPlayed="cpu"
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
	print("❎ select",4,36,9)
	print("🅾️ place die")
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
	for i=1,3 do
		pcol={playergrid[i],playergrid[i+3],playergrid[i+6]}
		ccol={cpugrid[i],cpugrid[i+3],cpugrid[i+6]}
            if count(pcol,die.value)>0 and count(ccol,die.value)>0 then
                if lastPlayed == "cpu" then
                    if pcol[1]==die.value then
                        pcol[1]=0
                    end
                    if pcol[2]==die.value then
                        pcol[2]=0
                    end
                    if pcol[3]==die.value then
                        pcol[3]=0
                    end
                elseif lastplayed == "player" then
                    if ccol[1]==die.value then
                        ccol[1]=0
                    end
                    if ccol[2]==die.value then
                        ccol[2]=0
                    end
                    if ccol[3]==die.value then
                        ccol[3]=0
                    end
                end

        end
        playergrid[i]=pcol[1]
        playergrid[i+3]=pcol[2]
        playergrid[i+6]=pcol[3]
        cpugrid[i]=ccol[1]
        cpugrid[i+3]=ccol[2]
        cpugrid[i+6]=ccol[3]
		if count(playergrid,0)==0 or count(cpugrid,0)==0 then
			--change game state to over
		end
    end
end