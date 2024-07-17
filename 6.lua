--menu screens
function init_title()
    hero = {
        sprite=64,
        w=11,
        h=4,
        x=10,
        y=20
    }
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