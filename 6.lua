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
        hero.x=6
        hero.y=20
    end
end

function draw_title()
    spr(hero.sprite,hero.x,hero.y,hero.w,hero.h)
    if game.state == "title" then
        print("by g𝘭𝘦𝘯 m𝘤c𝘢𝘯𝘯",10,95,7)
        print("press ❎ to start")
    elseif game.state == "over" then
        print("❎ restart",hero.x+4,86,7)
        if game.winner then
            print("★you win!★",hero.x,76,11)
        else
            print("∧you lose∧",hero.x,76,8)
        end
    end
end

--rules screen
function draw_rules()
    rectfill(12,21,116,107,9)
    rectfill(12,18,116,30,1)
    print("knucklebones",17,22,9)
    print("❎",107,22)
    --score more points than your opponent by adding dice to your grid. if a newly placed die matches any in the opposing column, those matches are removed.
    print("place dice on the grid.",16,36,1)
    print("steal dice by matching",16,47)
    print("your opponent's columns.")
    print("the game ends when one",16,62)
    print("player's grid is")
    print("completely full.")
    print("make columns with",16,84)
    print("doubles or triples to")
    print("multiply their value!")
end