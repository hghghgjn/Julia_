using HorizonSideRobots

robot = Robot("6.sit", animate=true)

function marker(robot)
    n_Ost, n_Sud = corner!(robot)
    m = side!(robot, West)
    n = side!(robot, Ost)
    corner!(robot)
    side = West
    loc = ((n_Sud + n_Ost) % 2 == 0)

    snake!(stop_condition, robot, side, Nord, loc, m, n)

    corner!(robot)
    back!(robot, n_Ost, n_Sud)
end

function side!(robot, side)
    n = 0
    while ! isborder(robot, side)
        n += 1
        move!(robot, side)
    end
    return n
end

function back!(robot, n_Ost, n_Sud)
    while (n_Ost != 0) || (n_Sud != 0)
        if (! isborder(robot, West)) && (n_Ost != 0)
            move!(robot, West)
            n_Ost -= 1
        end
        if (! isborder(robot, Nord)) && (n_Sud != 0)
            move!(robot, Nord)
            n_Sud -= 1
        end
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function markers_line!(robot, side, loc)
    while ! isborder(robot, side)
        if loc
            putmarker!(robot)
            loc = false
            move!(robot, side)
        else
            loc = true
            move!(robot, side)
        end
    end
    return ! loc
end

function corner!(robot)
    n_Ost = 0
    n_Sud = 0
    while (! isborder(robot, Ost)) || (! isborder(robot, Sud))
        while ! isborder(robot, Ost)
            n_Ost += 1
            move!(robot, Ost)
        end
        while ! isborder(robot, Sud)
            n_Sud += 1
            move!(robot, Sud)
        end
    end
    return n_Ost, n_Sud
end

function snake!(stop_condition::Function, robot, side1::HorizonSide, side2::HorizonSide, loc, m, n)
    side = side1
    while (n != 0) && (! stop_condition())
        n -= 1
        loc = markers_line!(robot, side, loc, m)
        if loc
            putmarker!(robot)
            loc = false
        else
            loc = true
        end
        move!(robot, side2)
        side = inverse(side)
    end
    loc = markers_line!(robot, side, loc, m)
    if loc
        putmarker!(robot)
    end
end

function markers_line!(robot, side, loc,  m)
    while m != 0
        m -= 1
        if ! isborder(robot, side)
            if loc
                putmarker!(robot)
                loc = false
                move!(robot, side)
            else
                loc = true
                move!(robot, side)
            end
        else
            if loc
                putmarker!(robot)
            end
            n = detour(robot, side)
            m -= n
            if n % 2 == 0
                loc = ! loc
            end
        end
    end
    return loc
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function stop_condition()
    return false
end

function detour(robot, side)
    cnt = 0
    while isborder(robot, side)
        move!(robot, Nord)
        cnt += 1
    end
    move!(robot, side)
    n = 0
    if isborder(robot, Sud)
        while isborder(robot, Sud)
            n += 1
            move!(robot, side)
        end
    end
    while cnt != 0
        cnt -= 1
        move!(robot, Sud)
    end
    return n
end

marker(robot)
