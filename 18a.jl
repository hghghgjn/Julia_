using HorizonSideRobots

robot = Robot("18a.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function spiral!(stop_condition::Function, robot)
    n = 0
    side1 = West
    side2 = Sud

    while ! stop_condition()
        n += 1
        move_1!(stop_condition,robot, side1, side2, n)
        side1 = inverse(side1)
        side2 = inverse(side2)
    end    
end

function move_1!(stop_condition::Function, robot, side1, side2, n)
    memory = n
    while n > 0 && ! stop_condition()
        if isborder(robot, side1)
            detour!(robot, side1, side2)
        else
            move!(robot, side1)
        end
        n -= 1
    end
    n = memory
    while n > 0 && ! stop_condition()
        if isborder(robot, side2)
            detour!(robot, side2, side1)
        else
            move!(robot, side2)
        end
        n -= 1
    end
end

function detour!(robot, side1, side2)
    cnt = 0
    while isborder(robot, side1)
        move!(robot, side2)
        cnt += 1
    end
    move!(robot, side1)
    while cnt != 0
        cnt -= 1
        move!(robot, inverse(side2))
    end
end

stop_condition() = ismarker(robot)

spiral!(stop_condition, robot)
