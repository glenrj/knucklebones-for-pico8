--menu screens
function init_title()
    hero = {
        sprite=64,
        w=11,
        h=4
    }
    gameover={
        sprite=64,
        w=11,
        h=4,
        winner=true
    }
end

function draw_title()
    if game.state == "title" then
        spr(hero.sprite,10,20,hero.w,hero.h)
        print("by g𝘭𝘦𝘯 m𝘤c𝘢𝘯𝘯",10,95,7)
        print("press ❎ to start")
    elseif game.state == "over" then
        spr(gameover.sprite,10,20,gameover.w,gameover.h)
        print("press ❎ to play again",10,95,7)
        if gameover.winner then
            print("★you win!★",10,60)
        else
            print("you lose",10,60)
        end
        print("final score:",10,70)
        print(scores.player,80,70)
        print("cpu score:",10,76)
        print(scores.cpu,80,76)
    end
end