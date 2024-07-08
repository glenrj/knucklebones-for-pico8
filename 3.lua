--die
function init_die()
	die={
		value=1
		sprite=4
	}
end

function update_die()
	die.sprite=(die.value+1)*2
end

function draw_die()
	spr(die.sprite,8,57,2,2)
end

function roll_die()
	roll=flr(rnd(6)) + 1
	die.value=roll
end