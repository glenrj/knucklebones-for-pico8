--knucklebones
--glen mccann

function _init()
	game={
		state="title",
		winner=""
	}
	init_board()
	init_score()
	init_die()
	init_selector()
	init_cpu()
	init_title()
end

function _update()
	update_title()
	scores.player=update_score(playergrid)
	scores.cpu=update_score(cpugrid)
	update_die()
	update_selector()
	update_cpu()
end

function _draw()
	cls()
	if game.state == "game" then
		draw_score()
		draw_board()
		draw_die()
		draw_selector()
		if rules then
			draw_rules()
		end
	elseif game.state == "title" then
		draw_title()
	elseif game.state == "over" then
		draw_board()
		draw_score()
		draw_title()
	end
end