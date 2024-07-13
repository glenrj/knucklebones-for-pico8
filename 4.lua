--selector
function init_selector()
	selector={
		sprite=32,
		w=1,
		h=1,
		x=40,
		y=80,
		mode="roll",
		position=1,
		options=2,
		visible=true
	}
end

function update_selector()
    --menu wrap
	if selector.position > selector.options then
		selector.position=1
	elseif selector.position < 1 then
		selector.position=selector.options
	end
    --roll mode positions
	if selector.mode == "roll" then
		xpos={8,8}
		ypos={80,88}
		if btnp(3) then
			selector.position+=1
		end
		if btnp(2) then
			selector.position-=1
		end
		if btnp(5) then
			if selector.position == 1 then
				roll_die()
				place_mode()
			elseif selector.position == 2 then
				cpugrid={0,0,0,0,0,0,0,0,0}
				playergrid={0,0,0,0,0,0,0,0,0}
			end
		end
	end
	--place mode positions
	if selector.mode== "place" then
		xpos=playergridx
		ypos=playergridy
		if btnp(3) then
			selector.position+=3
		end
		if btnp(2) then
			selector.position-=3
		end
		if btnp(0) then
			selector.position-=1
		end
		if btnp(1) then
			selector.position+=1
		end
		if btnp(4) then
            lastPlayed="player"
			playergrid[selector.position]=die.value
			compare_grids()
			cpu_mode()
			cpu_turn()
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
		spr(selector.sprite,selector.x,selector.y,selector.w,selector.h)
	end
	print("mode:",0,0)
	print(selector.mode)
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
end

function place_mode()
	route="none"
	selector.mode="place"
	selector.w=2
	selector.h=2
	selector.sprite=0
	selector.position=1
	selector.options=9
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