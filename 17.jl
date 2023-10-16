using HorizonSideRobots

robot = Robot("8.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function spiral!(stop_condition::Function, robot)
    n = 0
    side1 = West
    side2 = Sud

    while ! stop_condition()
        n += 1
        move_1!(stop_condition,robot, side1, n)
        move_1!(stop_condition, robot, side2, n)
        side1 = inverse(side1)
        side2 = inverse(side2)
    end    
end

function move_1!(stop_condition::Function, robot, side, n)
    while n > 0 && ! stop_condition()
        move!(robot, side)
        n -= 1
    end
end

stop_condition() = ismarker(robot)

spiral!(stop_condition, robot)
