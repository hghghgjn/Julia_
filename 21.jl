using HorizonSideRobots

robot = Robot("21.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

left(s::HorizonSide) = HorizonSide(mod(Int(s)+1, 4))

function side1(robot, side, loc, cnt)
    if loc && (! isborder(robot, side))
        move!(robot, side)
    elseif (! loc) && (! isborder(robot, side))
        move!(robot, side)
        side = inverse(left(side))
        while cnt > 0
            cnt -= 1
            move!(robot, side)
        end
    else
        loc = false
        move!(robot, left(side))
        cnt += 1
        side1(robot, side, loc, cnt)
    end
    
end

side1(robot, Ost, true, 0)
