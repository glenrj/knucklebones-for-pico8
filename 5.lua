---cpu
function init_cpu()
    cpu={
        timer=1,
        move=false,
        roll=1,
        turn=false
    }
end

function update_cpu()
    if cpu.move then
        cpu.timer+=1
        if cpu.timer==21 then
            die.rolling=false
		    die.timer=1
            die.value=flr(rnd(6)) + 1
        end
        if cpu.timer>=28 then
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
        if count(ccol1,cpu.roll)>0 and count(ccol1,0)>0 then
            open_spots=find_match(ccol1,0)
            ccol1[open_spots[#open_spots]]=cpu.roll
            cpu.turn=false
            column=1
        elseif count(ccol2,cpu.roll)>0 and count(ccol2,0)>0 then
            open_spots=find_match(ccol2,0)
            ccol2[open_spots[#open_spots]]=cpu.roll
            cpu.turn=false
            column=2
        elseif count(ccol3,cpu.roll)>0 and count(ccol3,0)>0 then
            open_spots=find_match(ccol3,0)
            ccol3[open_spots[#open_spots]]=cpu.roll
            cpu.turn=false
            column=3
        end
    elseif count(playergrid,cpu.roll)>0 then
        route="player match"
        if count(pcol1,cpu.roll)>0 and count(ccol1,0)>0 then
            open_spots=find_match(ccol1,0)
            ccol1[open_spots[#open_spots]]=cpu.roll
            cpu.turn=false
            column=1
        elseif count(pcol2,cpu.roll)>0 and count(ccol2,0)>0 then
            open_spots=find_match(ccol2,0)
            ccol2[open_spots[#open_spots]]=cpu.roll
            cpu.turn=false
            column=2
        elseif count(pcol3,cpu.roll)>0 and count(ccol3,0)>0 then
            open_spots=find_match(ccol3,0)
            ccol3[open_spots[#open_spots]]=cpu.roll
            cpu.turn=false
            column=3
        end
    end
    if cpu.turn and count(cpugrid,0)>0 then
        route="no match"
        open_spots=find_match(cpugrid,0)
        random=rnd(#open_spots)
        if random == 0 then
            random=1
        end
        if random <4 and count(ccol1,0)>0 then
            zeroes=find_match(ccol1,0)
            ccol1[zeroes[#zeroes]]=cpu.roll
            cpu.turn=false
            column=1
        elseif random <7 and count(ccol2,0)>0 then
            zeroes=find_match(ccol2,0)
            ccol2[zeroes[#zeroes]]=cpu.roll
            cpu.turn=false
            column=2
        elseif random <10 and count(ccol3,0)>0 then
            zeroes=find_match(ccol3,0)
            ccol3[zeroes[#zeroes]]=cpu.roll
            cpu.turn=false
            column=2
        end
    end
    to_grid()
    lastPlayed="cpu"
    compare_grids()
    if game.state=="game" then
        roll_mode()
    end
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