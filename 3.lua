--die
function init_die()
	die={
		value=1,
		sprite=4,
		rolling=false,
		timer=1
	}
end

function update_die()
	die.sprite=(die.value+1)*2
	if die.rolling then
		die.timer+=1
	end
	if die.timer % 2 == 0 then
		die.value=flr(rnd(6)) + 1
	end
	if die.timer>=20 then
		die.rolling=false
		die.timer=1
		if selector.mode == "place" then
			show_selector()
		end
	end
end

function draw_die()
	spr(die.sprite,8,57,2,2)
end

function roll_die()
	hide_selector()
	die.timer=0
	die.rolling=true
end