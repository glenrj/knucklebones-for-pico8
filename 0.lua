--knucklebones
--glen mccann

--game loop
function _init()
	state="title"
	init_board()
	init_score()
	init_die()
	init_selector()
	init_cpu()
	init_title()
end

function _update()
	scores.player=update_score(playergrid)
	scores.cpu=update_score(cpugrid)
	update_die()
	update_selector()
	update_cpu()
end

function _draw()
	cls()
	if state == "game" then
		draw_board()
		draw_score()
		draw_die()
		draw_selector()
		draw_cpu()
	elseif state == "title" then
		draw_title()
	end
end