---cpu
function init_cpu()
    cpu={
        timer=1,
        move=false
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
    print(route)
end

function cpu_turn()
    roll_die()
    cpu.move=true
end

function place_die(roll)
    newval=roll
    for i=1,3 do
        --sort column by column
        pcol={playergrid[i],playergrid[i+3],playergrid[i+6]}
        ccol={cpugrid[i],cpugrid[i+3],cpugrid[i+6]}
        isFound=found(pcol, newval)
        if isFound and count(ccol,0)>0 then 
            --if there is a matching die in the player column and an open spot in ccol
            route="player match"
            zeroindex=findzeros(ccol)
            ccol[zeroindex[1]]=newval
            newval=0
        elseif count(ccol,newval)>0 and count(ccol,0)>0 then
            --if it's not in player column but it is in the cpu column AND it has room
            route="cpu match"
            zeroindex=findzeros(ccol)
            ccol[zeroindex[1]]=newval
            newval=0
        else
            --no matches
            route="no match"
            --place newval in a random empty spot (0) in cpugrid
            zeroindex=findzeros(cpugrid)
            zero=flr(rnd(#zeroindex))
            randomindex=zeroindex[zero]
            ccol[randomindex]=newval
            newval=0
        end
        --update the board
        cpugrid[i]=ccol[1]
        cpugrid[i+3]=ccol[2]
        cpugrid[i+6]=ccol[3]
    end
    compare_grids()
    roll_mode()
    selector.visible=true
end

function found(array, value)
    for i=1,#array do 
        if array[i] == value then
            return true
        end
    end
    return false
end

function findzeros(array)
    zeroindex={}
    for i=1,#array do
        if array[i] == 0 then
            add(zeroindex,i)
        end
    end
    return zeroindex
end