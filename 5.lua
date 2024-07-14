---cpu
function init_cpu()
    cpu={
        timer=1,
        move=false,
        roll=1,
        turn=false
    }
    route="none"
end

function update_cpu()
    if cpu.move then
        cpu.timer+=1
        if cpu.timer>=21 then
            cpu.move=false
            cpu.timer=0
            die.rolling=false
		    die.timer=1
		    die.value=flr(rnd(6)) + 1
            place_die(die.value)
        end
    end
end

function draw_cpu()
    print(route,0,0)
end

function cpu_turn()
    roll_die()
    cpu.move=true
end

function place_die(roll)
    cpu.roll=roll
    cpu.turn=true
    -- 1. is there a match
    --      a. where is the match
    --      b. place in corraponding column
    -- 2. if there is no match 
    --      a. Find zeros 
    --      b. place in a zero 
    while cpu.turn do
        for i=1,3 do
            --sort column by column
            pcol={playergrid[i],playergrid[i+3],playergrid[i+6]}
            ccol={cpugrid[i],cpugrid[i+3],cpugrid[i+6]}
            if count(ccol,cpu.roll)>0 and count(ccol,0)>0 then
                --if it's not in player column but it is in the cpu column AND it has room
                --detecting correctly
                --placing correctly
                route="cpu match"
                zeroindex=findzeros(ccol)
                ccol[zeroindex[1]]=cpu.roll
                --update the board
                cpugrid[i]=ccol[1]
                cpugrid[i+3]=ccol[2]
                cpugrid[i+6]=ccol[3]
                cpu.turn=false
            elseif count(pcol,cpu.roll)>0 and count(ccol,0)>0 then
                --if there is a matching die in the player column and an open spot in ccol
                --detecting correctly
                --not placing at all once detected
                route="player match"
                zeroindex=findzeros(ccol)
                ccol[zeroindex[1]]=cpu.roll
                --update the board
                cpugrid[i]=ccol[1]
                cpugrid[i+3]=ccol[2]
                cpugrid[i+6]=ccol[3]
                cpu.turn=false
            elseif cpu.turn == true and i==3 then
                --no matches
                --detecting correctly
                --placing correctly
                route="no match"
                --place cpu.roll in a random empty spot (0) in cpugrid
                zeroindex=findzeros(cpugrid)
                zero=flr(rnd(#zeroindex))
                if zero == 0 then
                    zero=1
                end
                randomindex=zeroindex[zero]
                --update the board
                cpugrid[i]=ccol[1]
                cpugrid[i+3]=ccol[2]
                cpugrid[i+6]=ccol[3]
                cpugrid[randomindex]=roll
                cpu.turn=false
            end
        end
    end
    compare_grids()
    roll_mode()
end

function found(t, value)
    for i=1,#t do 
        if t[i] == value then
            return true
        end
    end
    return false
end

function findzeros(t)
    zeroindex={}
    for i=1,#t do
        if t[i] == 0 then
            add(zeroindex,i)
        end
    end
    return zeroindex
end