using HorizonSideRobots
robot = Robot("12.sit", animate=true)

function num_borders!(robot)
    n_Ost, n_Sud = corner(robot)
    side = West
    cnt = num_borders!(robot, side)
    while ! isborder(robot, Nord)
        move!(robot, Nord)
        side = inverse(side)
        cnt += num_borders!(robot, side)
    end
    corner(robot)
    back(robot, n_Ost, n_Sud)
    return cnt - 1
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function num_borders!(robot, side)
    state = 0
    cnt_str = 0
    while ! isborder(robot, side)
        move!(robot, side)
        if state == 0
            if isborder(robot, Nord)
                cnt_str += 1
                state = 2
            end
        elseif state == 2
            if ! isborder(robot, Nord) 
                state = 1
            end
        else
            if isborder(robot, Nord)
                state = 2
            else
                state = 0
            end
        end
    end
    return cnt_str
end

function corner(robot)
    n_Ost = 0
    n_Sud = 0
    while ! isborder(robot, Ost)
        n_Ost += 1
        move!(robot, Ost)
    end
    while ! isborder(robot, Sud)
        n_Sud += 1
        move!(robot, Sud)
    end
    return n_Ost, n_Sud
end

function back(robot, n_Ost, n_Sud)
    for _ in 1:n_Sud
        move!(robot, Nord)
    end
    for _ in 1:n_Ost
        move!(robot, West)
    end
end

println(num_borders!(robot))
