--score
function init_score()
	scores={
        player=0,
        cpu=0
    }
end

function update_score(grid)
	col1={grid[1],grid[4],grid[7]}
	col2={grid[2],grid[5],grid[8]}
	col3={grid[3],grid[6],grid[9]}
	columns={col1,col2,col3}
	score=0
	for i=1,3 do
		score+=score_col(columns[i])
		print(score)
	end
	return score
end

function draw_score()
	print(scores.cpu,116,46,7)
	print(scores.player,116,76,7)
end

function score_col(col)
	colscore=0
    for i=1,6 do
        mult=count(col,i)
        colscore=colscore+(i*mult)*mult
        for i=1, mult do
            del(column,i)
        end
    end
	return colscore
end