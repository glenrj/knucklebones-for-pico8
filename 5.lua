---cpu
function cpu_turn()
    placed=false
    roll_die()
    --TODO add a wait for the rolling to stop before firing place_die
    place_die(die.value)
end

function place_die(roll)
    newVal=roll
    isFound=found(playergrid, newval)
    if isFound then 
        ---this is firing but not doing anything
        for i=1,3 do
            pcol={playergrid[i],playergrid[i+3],playergrid[i+6]}
            ccol={cpugrid[i],cpugrid[i+3],cpugrid[i+6]}
            if count(pcol,newVal)>0 then
                placed=true
                ccol[0]=newVal
            end
        end
    else
        --this is also firing and not doing anything visible other than update the "placed" value 
        zeroindex=findzeros(cpugrid)
        randomIndex=zeroIndex[ math.random(#zeroindex)]
        cpugrid[randomIndex]=newVal
        placed=true
    end
    compare_grids()
end

function draw_cpu()
    print(placed,0,20)
    print(newVal)
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
            add(zeroindex,i,value)
        end
    end
    return zeroindex
end