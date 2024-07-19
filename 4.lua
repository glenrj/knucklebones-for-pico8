--selector
function init_selector()
	selector={
		sprite=32,
		w=1,
		h=1,
		x=14,
		y=72,
		mode="title",
		position=1,
		options=1,
		visible=false,
		cols={true,true,true}
	}
end

function update_selector()
	if selector.position > selector.options then
		selector.position=1
		if selector.mode=="place" and count(pcol1,0)==0 then
			selector.position=2
		end
		if selector.mode=="place" and count(pcol2,0)==0 then
			selector.position=3
		end
	elseif selector.position < 1 then
		selector.position=selector.options
		if selector.mode=="place" and count(pcol3,0)==0 then
			selector.position=2
		end
		if selector.mode=="place" and count(pcol2,0)==0 then
			selector.position=1
		end
	end

	if selector.mode == "roll" then
		xpos={14,9,12}
		ypos={72,88,80}
		if btnp(3) then
			selector.position-=1
		end
		if btnp(2) then
			selector.position+=1
		end
		if btnp(5) or btnp(4) then
			if selector.position == 1 then
				roll_die()
				to_col()
				place_mode()
			elseif selector.position == 2 then
				title_mode()
				cpugrid={0,0,0,0,0,0,0,0,0}
				playergrid={0,0,0,0,0,0,0,0,0}
				game.winner=false
			elseif selector.position == 3 then
				rules=true
				popup_mode()
			end
		end
	elseif selector.mode == "title" then
		xpos={0}
		ypos={0}
		if btnp(5) or btnp(4) then
			cpugrid={0,0,0,0,0,0,0,0,0}
			playergrid={0,0,0,0,0,0,0,0,0}
			game.winner=false
			game.state="game"
			roll_mode()
		end
	elseif selector.mode == "over" then
		xpos={0}
		ypos={0}
		if btnp(5) then
			cpugrid={0,0,0,0,0,0,0,0,0}
			playergrid={0,0,0,0,0,0,0,0,0}
			game.winner=false
			game.state="game"
			title_mode()
		end
	elseif selector.mode== "place" then
		xpos={59,77,95}
		ypos={70,70,70}

		if btnp(0) then
			selector.position-=1
			if selector.cols[selector.position] == false then
				selector.position-=1
			end
		end
		if btnp(1) then
			selector.position+=1
			if selector.cols[selector.position] == false then
				selector.position+=1
			end
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
	elseif selector.mode == "popup" then
		if btnp(4) then
			rules=false 
			roll_mode()
			selector.position=3
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
	selector.position=1
	selector.options=3
	selector.x=8
	selector.y=80
	selector.w=1
	selector.h=1
	selector.sprite=32
	selector.visible=true
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
	if count(pcol1,0)==0 then
		selector.position=2
	end
	if count(pcol2,0)==0 and selector.position == 2 then
		selector.position=3
	end
	if count(pcol3,0)==0 and selector.position == 3 then
		selector.position=1
	end
end

function title_mode()
	game.state="title"
	selector.mode="title"
	selector.position=1
	selector.options=1
	selector.visible=false
end

function cpu_mode()
	selector.visible=false
	selector.mode="cpu"
	selector.position=1
end

function popup_mode()
	selector.mode="popup"
end

function hide_selector()
	selector.visible=false
end

function show_selector()
	selector.visible=true
end