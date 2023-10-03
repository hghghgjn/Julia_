using HorizonSideRobots

robot = Robot("6.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function side!(robot, side)
    n = 0
    while ! isborder(robot, side)
        n += 1
        move!(robot, side)
    end
    return n
end

function corner(robot)
    n_Ost = 0
    n_Sud = 0
    while (! isborder(robot, Ost)) && (! isborder(robot, Sud))
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

function markers!(robot)
    n_Ost, n_Sud = corner(robot)
    m = side!(robot, Nord)
    n = side!(robot, West)
    mark_line!(robot, Sud, m - n_Sud)
    mark_line!(robot, Ost, n - n_Ost)
    mark_line!(robot, Nord, n_Sud)
    mark_line!(robot, West, n_Ost)
    corner(robot)
    back!(robot, n_Ost, n_Sud)
end

function mark_line!(robot, side, n)
    while ! isborder(robot, side) 
        move!(robot, side)
        n -= 1
        if n == 0
            putmarker!(robot)
        end
    end
end

markers!(robot)
