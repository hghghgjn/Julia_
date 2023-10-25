using HorizonSideRobots

robot = Robot("1.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function move_1!(robot, side, loc, n, k)
    if loc == 0
        if ! isborder(robot, side)
            move!(robot, side)
            move_1!(robot, side, loc, n + 1, k)
        else
            move_1!(robot, inverse(side), 1, n * 2, k)
        end
    elseif loc == 1
        if k != n
            if ! isborder(robot, side)
                move!(robot, side)
                move_1!(robot, side, loc, n, k + 1)
            else
                move_1!(robot, inverse(side), 2, n, k - n / 2)
            end
        end
    else
        if k != 0
            move!(robot, side)
            move_1!(robot, side, loc, n, k - 1)
        end
    end
end

move_1!(robot, Nord, 0, 0, 0)
