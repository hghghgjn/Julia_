using HorizonSideRobots

robot = Robot("16.sit", animate=true)

function shuttle!(stop_condition::Function, robot, start_side)
    n = 0
    side = start_side
    while (! stop_condition())
        n += 1
        move2!(robot, side, n)
        side = inverse(side)
    end   
end

function stop_condition()
    return (! isborder(robot, Nord))
end

function move2!(robot, side, n)
    while n > 0 && ! stop_condition()
        move!(robot, side)
        n -= 1
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

shuttle!(stop_condition, robot, Ost)
