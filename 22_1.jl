using HorizonSideRobots

robot = Robot("1.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function move_1!(robot, side, loc, n)
    if loc
        if ! isborder(robot, side)
            move!(robot, side)
            move_1!(robot, side, loc, n + 1)
        else
            move_1!(robot, inverse(side), false, n * 2)
        end
    else
        if n > 0
            move!(robot, side)
            move_1!(robot, side, loc, n - 1)
        end
    end
end

move_1!(robot, Sud, true, 0)
