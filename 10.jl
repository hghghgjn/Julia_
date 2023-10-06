using HorizonSideRobots

robot = Robot("1.sit", animate=true)

function marker(robot, n)
    n_West, n_Sud = corner(robot)
    side = Ost
    loc = true
    loc2 = true
    while loc2
        loc2 = markers_line!(robot, side, loc, n)
        loc = ! loc
    end
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


function side!(robot, side)
    while ! isborder(robot, side)
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function markers_line!(robot, side, loc3, n)
    loc2 = true
    n2 = 0
    n1 = n
    loc = loc3
    while (n1 > 0) && (loc2)
        loc = loc3
        side = Ost
        if isborder(robot, Nord)
            loc2 = false
        end

        while ! isborder(robot, side)
            n2 = move_n!(robot, side, loc, n)
            loc = ! loc
        end

        side = inverse(side)
        if ! isborder(robot, Nord)
            move!(robot, Nord)
        end
        
        loc = ! loc
        n1 -= 1
        side!(robot, West)
    end
    side!(robot, West)
    return loc2
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

function move_n!(robot, side, loc, n)
    n2 = n
    if loc
        while(n > 0) && (! isborder(robot, side))
            putmarker!(robot)
            move!(robot, side)
            n -= 1
        end
        if isborder(robot, side) && (n > 0)
            putmarker!(robot)
        end
    else
        while(n > 0) && (! isborder(robot, side))
            move!(robot, side)
            n -= 1
        end
        if isborder(robot, side) && (n == 0)
            putmarker!(robot)
        end
    end
    return (n2 - n + 1) % n2
end

marker(robot, 6)
