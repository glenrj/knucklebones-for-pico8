---cpu
function init_cpu()
    cpu={
        timer=1,
        move=false,
        roll=1,
        turn=false
    }
    route="none"
    column=0
end

function update_cpu()
    if cpu.move then
        cpu.timer+=1
        if cpu.timer==21 then
            die.rolling=false
		    die.timer=1
            die.value=flr(rnd(6)) + 1
        end
        if cpu.timer>=25 then
            cpu.move=false
            cpu.timer=0
            place_die(die.value)
        end
    end
end

function cpu_turn()
    roll_die()
    cpu.move=true
end

function place_die(roll)
    cpu.roll=roll
    cpu.turn=true
    route="no route"
    to_col()
    if count(cpugrid,cpu.roll)>0 then
        route="cpu match"
        --if it is in the cpu's grid
        --look for multiples and open spot
        if count(ccol1,cpu.roll)>0 and count(ccol1,0)>0 then
            open_spots=find_match(ccol1,0)
            ccol1[open_spots[1]]=cpu.roll
            cpu.turn=false
            column=1
        elseif count(ccol2,cpu.roll)>0 and count(ccol2,0)>0 then
            open_spots=find_match(ccol2,0)
            ccol2[open_spots[1]]=cpu.roll
            cpu.turn=false
            column=2
        elseif count(ccol3,cpu.roll)>0 and count(ccol3,0)>0 then
            open_spots=find_match(ccol3,0)
            ccol3[open_spots[1]]=cpu.roll
            cpu.turn=false
            column=3
        end
    elseif count(playergrid,cpu.roll)>0 then
        --if it's in the player's grid
        route="player match"
        --look for match and open spot
        if count(pcol1,cpu.roll)>0 and count(ccol1,0)>0 then
            open_spots=find_match(ccol1,0)
            ccol1[open_spots[1]]=cpu.roll
            cpu.turn=false
            column=1
        elseif count(pcol2,cpu.roll)>0 and count(ccol2,0)>0 then
            open_spots=find_match(ccol2,0)
            ccol2[open_spots[1]]=cpu.roll
            cpu.turn=false
            column=2
        elseif count(pcol3,cpu.roll)>0 and count(ccol3,0)>0 then
            open_spots=find_match(ccol3,0)
            ccol3[open_spots[1]]=cpu.roll
            cpu.turn=false
            column=3
        end
    end
    if cpu.turn and count(cpugrid,0)>0 then
        --random 0 in cpugrid
        route="no match"
        open_spots=find_match(cpugrid,0)
        random=rnd(#open_spots)
        if random == 0 then
            random=1
        end
        --first open spot in respective column
        if random <4 and count(ccol1,0)>0 then
            zeroes=find_match(ccol1,0)
            ccol1[zeroes[1]]=cpu.roll
            cpu.turn=false
            column=1
        elseif random <7 and count(ccol2,0)>0 then
            zeroes=find_match(ccol2,0)
            ccol2[zeroes[1]]=cpu.roll
            cpu.turn=false
            column=2
        elseif random <10 and count(ccol3,0)>0 then
            zeroes=find_match(ccol3,0)
            ccol3[zeroes[1]]=cpu.roll
            cpu.turn=false
            column=2
        end
    end
    to_grid()
    lastPlayed="cpu"
    compare_grids()
    roll_mode()
end

function find_match(t,v)
    match_index={}
    for i=1,#t do
        if t[i] == v then
            add(match_index,i)
        end
    end
    return match_index
end