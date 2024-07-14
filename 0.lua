--knucklebones
--glen mccann

--game loop
function _init()
	game={
		state="title"
	}
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
	if game.state == "game" then
		draw_board()
		draw_score()
		draw_die()
		draw_selector()
	elseif game.state == "title" or game.state == "over" then
		draw_title()
	end
end