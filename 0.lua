--knucklebones
--glen mccann

--game loop
function _init()
	init_board()
	init_score()
	init_die()
	init_selector()
end

function _update()
	scores.player=update_score(playergrid)
	scores.cpu=update_score(cpugrid)
	update_board()
	update_die()
	update_selector()
end

function _draw()
	cls()
	draw_board()
	draw_score()
	draw_die()
	draw_selector()
end