--menu screens
function init_title()
    hero = {
        sprite=64,
        w=11,
        h=4
    }
end

function update_title()
    if game.state == "title" then
        hero.sprite=64
    elseif game.state == "over" then
        hero.sprite=128
    end
end

function draw_title()
    spr(hero.sprite,10,20,hero.w,hero.h)
    if game.state == "title" then
        print("by g𝘭𝘦𝘯 m𝘤c𝘢𝘯𝘯",10,95,7)
        print("press ❎ to start")
    elseif game.state == "over" then
        print("press ❎ to play again",10,95,7)
        if game.winner then
            print("★you win!★",10,60,11)
        else
            print("∧you lose∧",10,60,8)
        end
        print("final score:",10,70,6)
        print(scores.player,80,70)
        print("cpu score:",10,76)
        print(scores.cpu,80,76)
    end
end