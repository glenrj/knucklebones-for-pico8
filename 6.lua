--menu screens
function init_title()
    hero = {
        sprite=64,
        w=11,
        h=4,
        x=10,
        y=20
    }
    rules=false
end

function update_title()
    if game.state == "title" then
        hero.sprite=64
        hero.x=10
        hero.y=20
    elseif game.state == "over" then
        hero.sprite=128
        hero.x=2
        hero.y=20
    end
end

function draw_title()
    spr(hero.sprite,hero.x,hero.y,hero.w,hero.h)
    if game.state == "title" then
        print("by g𝘭𝘦𝘯 m𝘤c𝘢𝘯𝘯",10,95,7)
        print("press ❎ to start")
    elseif game.state == "over" then
        print("❎ restart",hero.x,86,7)
        if game.winner then
            print("★you win!★",hero.x,76,11)
        else
            print("∧you lose∧",hero.x,76,8)
        end
    end
end

--rules screen
function draw_rules()
    rectfill(14,16,116,98,9)
    rectfill(14,16,116,27,1)
    print("Knucklebones",17,20,9)
    print("❎",100,20)
    --Score more points than your opponent by adding dice to your grid. If a newly placed die matches any in the opposing column, those matches are removed.
    print("Place dice on the grid.",18,30,1)
    print("Steal dice by matching",18,40)
    print("your opponent's columns.")
    print("The game ends when one",18,56)
    print("player's grid is")
    print("completely full.")
    print("Make columns with",18,78)
    print("doubles or triples to")
    print("multiply their value!")
end