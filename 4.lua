--selector
function init_selector()
	selector={
		sprite=32,
		w=1,
		h=1,
		x=40,
		y=80,
		mode="title",
		position=1,
		options=0,
		visible=false
	}
end

function update_selector()
    --menu wrap
	if selector.position > selector.options then
		selector.position=1
	elseif selector.position < 1 then
		selector.position=selector.options
	end
	if selector.mode == "roll" then
		--roll mode positions
		xpos={8,8}
		ypos={80,88}
		if btnp(3) then
			selector.position+=1
		end
		if btnp(2) then
			selector.position-=1
		end
		if btnp(5) or btnp(4) then
			if selector.position == 1 then
				roll_die()
				place_mode()
			elseif selector.position == 2 then
				title_mode()
				cpugrid={0,0,0,0,0,0,0,0,0}
				playergrid={0,0,0,0,0,0,0,0,0}
				game.winner=false
			end
		end
	elseif selector.mode == "title" then
		xpos={0}
		ypos={0}
		--title/game over screen positions
		if btnp(5) then
			cpugrid={0,0,0,0,0,0,0,0,0}
			playergrid={0,0,0,0,0,0,0,0,0}
			game.winner=false
			game.state="game"
			roll_mode()
		end
	elseif selector.mode== "place" then
		--place mode positions
		xpos={56,74,92}
		ypos={70,70,70}

		if btnp(0) then
			selector.position-=1
		end
		if btnp(1) then
			selector.position+=1
		end
		if btnp(5) or btnp(4) then
            lastplayed="player"
			if selector.position == 1 then
				open_spots=find_match(pcol1,0)
	            pcol1[open_spots[1]]=die.value
			elseif selector.position == 2 then
				open_spots=find_match(pcol2,0)
	            pcol2[open_spots[1]]=die.value
			elseif selector.position == 3 then
				open_spots=find_match(pcol3,0)
	            pcol3[open_spots[1]]=die.value
			end
			to_grid()
			compare_grids()
			if game.state == "game" then
				cpu_mode()
				cpu_turn()
			end
		end
	end
		
	for i=1,selector.options do
		if selector.position == i then
			selector.x=xpos[i]
			selector.y=ypos[i]
		end
	end
end

function draw_selector()
	if selector.visible then
		if selector.mode == "place" then
			spr(selector.sprite,selector.x,selector.y,selector.w,selector.h)
			spr(selector.sprite+16,selector.x,selector.y+44,selector.w,selector.h)
		else
			spr(selector.sprite,selector.x,selector.y,selector.w,selector.h)
		end
	end
end

function roll_mode()
	selector.mode="roll"
	selector.x=8
	selector.y=80
	selector.w=1
	selector.h=1
	selector.sprite=32
	selector.position=1
	selector.options=2
	selector.visible=true
	xpos={8,8}
	ypos={80,88}
end

function place_mode()
	route="none"
	selector.mode="place"
	selector.w=2
	selector.h=1
	selector.sprite=0
	selector.position=1
	selector.options=3
	to_col()
end

function title_mode()
	game.state="title"
	selector.mode="title"
	selector.options=0
	selector.visible=false
end

function cpu_mode()
	selector.visible=false
	selector.mode="cpu"
end

function hide_selector()
	selector.visible=false
end

function show_selector()
	selector.visible=true
end