using HorizonSideRobots

robot = Robot("1.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function side!(robot, side, cnt, loc)
    if ! isborder(robot, side) && loc
        move!(robot, side)
        cnt += 1
    elseif ! loc
        move!(robot, side)
        cnt -= 1
    else
        putmarker!(robot)
        loc = false
        side = inverse(side)
    end
    if cnt != 0
        side!(robot, side, cnt, loc)
    end
end

side!(robot, Nord, 0, true)
