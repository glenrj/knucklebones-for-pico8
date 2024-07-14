--title screen
function init_title()
    hero = {
        sprite=64,
        w=11,
        h=4
    }
end

function draw_title()
    spr(hero.sprite,10,20,hero.w,hero.h)
    print("by g𝘭𝘦𝘯 m𝘤c𝘢𝘯𝘯",10,95,7)
    print("press ❎ to start")
end