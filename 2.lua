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

function compare()
    lastPlayed=""
    if selector.mode == "roll" then
        lastPlayed="player"
    elseif selector.mode == "cpu" then
        lastPlayed="cpu"
    end
	for i=1,3 do
		pcol={playergrid[i],playergrid[i+3],playergrid[i+6]}
		ccol={cpugrid[i],cpugrid[i+3],cpugrid[i+6]}
        for x=1,6 do
            if count(pcol,i)>0 and count(ccol,i)>0 then
                if lastPlayed == "cpu" then
                    if pcol[1]==x then
                        pcol[1]=0
                    end
                    if pcol[2]==x then
                        pcol[2]=0
                    end
                    if pcol[3]==x then
                        pcol[3]=0
                    end
                elseif lastPlayed == "player" then
                    if ccol[1]==x then
                        ccol[1]=0
                    end
                    if ccol[2]==x then
                        pcol[2]=0
                    end
                    if ccol[3]==x then
                        ccol[3]=0
                    end
                end

                playergrid[i]=pcol[1]
                playergrid[i+3]=pcol[2]
                playergrid[i+6]=pcol[3]
                cpugrid[i]=ccol[1]
                cpugrid[i+3]=ccol[2]
                cpugrid[i+6]=ccol[3]
            end
        end
    end
end