using HorizonSideRobots

robot = Robot("1.sit", animate=true)

function marker(robot)
    n_Sud = diagonal(robot)
    n_West = n_Sud
    n_West2, n_Sud2 = corner(robot)
    n_West += n_West2
    n_Sud += n_Sud2
    side = Ost
    if div(n_Sud2 + n_West2, 2) == 0
        loc = true
    else
        loc = false
    end
    while ! isborder(robot, Nord)
        loc = markers_line!(robot, side, loc)
        move!(robot, Nord)
        side = inverse(side)
    end
    markers_line!(robot, side, loc)
    corner(robot)
    back(robot, n_West, n_Sud)
end

function back(robot, n_West, n_Sud)
    for _ in 1:n_Sud
        move!(robot, Nord)
    end
    for _ in 1:n_West
        move!(robot, Ost)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function diagonal(robot)
    n = 0
    while ! (isborder(robot, Sud) || isborder(robot, West))
        move_2!(robot, Sud, West)
        n += 1
    end
    return n
end

function move_2!(robot, side1, side2)
    move!(robot, side1)
    move!(robot, side2)
end

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

function corner(robot)
    n_West = 0
    n_Sud = 0
    while ! isborder(robot, West)
        n_West += 1
        move!(robot, West)
    end
    while ! isborder(robot, Sud)
        n_Sud += 1
        move!(robot, Sud)
    end
    return n_West, n_Sud
end

marker(robot)
