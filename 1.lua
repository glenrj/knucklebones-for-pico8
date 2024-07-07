--board
function init_board()
	blank={
		w=2,
		h=2,
		space=18
	}
	
	playergridx={}
	playergridy={}
	cpugrid={1,2,3,4,5,6,5,4,3}
	playergrid={0,0,0,0,0,0,0,0,0}
	remaining={true,true,true,true,true,true,true,true,true}
	--available x coordinates for selector
	add(playergridx,56)
	add(playergridx,56+blank.space)
	add(playergridx,56+(blank.space*2))
	add(playergridx,56)
	add(playergridx,56+blank.space)
 add(playergridx,56+(blank.space*2))
	add(playergridx,56)
	add(playergridx,56+blank.space)
 add(playergridx,56+(blank.space*2))
 --available 7 coordinates for selector
	add(playergridy,70)
	add(playergridy,70)
	add(playergridy,70)
	add(playergridy,70+blank.space)
	add(playergridy,70+blank.space)
	add(playergridy,70+blank.space)
	add(playergridy,70+(blank.space*2))
	add(playergridy,70+(blank.space*2))
	add(playergridy,70+(blank.space*2))
end

function update_board()
	compare(playergrid,cpugrid)
end

function draw_board()
	--cpu side
	draw_grid(cpugrid,56,8,blank.space)
	--divider
	rectfill(50,64,116,65,13)
	--player side
	draw_grid(playergrid,56,70,blank.space)
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
	spr(sprites[1],x,y,blank.w,blank.h)
	spr(sprites[2],x+space,y,blank.w,blank.h)
	spr(sprites[3],x+(space*2),y,blank.w,blank.h)
	--row two
	spr(sprites[4],x,y+space,blank.w,blank.h)
	spr(sprites[5],x+space,y+space,blank.w,blank.h)
	spr(sprites[6],x+(space*2),y+space,blank.w,blank.h)
	--row three
	spr(sprites[7],x,y+(space*2),blank.w,blank.h)
	spr(sprites[8],x+space,y+(space*2),blank.w,blank.h)
	spr(sprites[9],x+(space*2),y+(space*2),blank.w,blank.h)
end