using HorizonSideRobots

robot = Robot("6.sit", animate=true)

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

    while (n_Ost != 0) && (n_Sud != 0)
        if ! isborder(robot, West)
            move!(robot, West)
            n_Ost -= 1
        end
        if ! isborder(robot, Nord)
            move!(robot, Nord)
            n_Sud -= 1
        end
    end
end

function markers!(robot)
    n_Ost, n_Sud = corner(robot)

    for s in (Nord, West, Sud, Ost)
        mark_line!(robot, s)
    end

    back!(robot, n_Ost, n_Sud)
end

function mark_line!(robot, side)
    while ! isborder(robot, side) 
        move!(robot, side)
        putmarker!(robot)
    end
end

markers!(robot)
