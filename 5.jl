using HorizonSideRobots

robot = Robot("5.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


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
    while ! isborder(robot, Ost)
        n_Ost += 1
        move!(robot, Ost)
    end
    return n_Ost, n_Sud
end

function back!(robot, n_Ost, n_Sud)
    for _ in 1:n_Sud
        move!(robot, Nord)
    end
    for _ in 1:n_Ost
        move!(robot, West)
    end
end

function markers!(robot)
    n_Ost, n_Sud = corner(robot)

    last = Ost
    for s in (Nord, West, Sud, Ost)
        mark_line!(robot, s, last)
        last = s
    end
    
    side = West
    while ! isborder(robot, Nord) 
        line!(robot, side)
        if ! isborder(robot, Nord)
            move!(robot, Nord)
        end
        side = inverse(side)
    end
    
    last = Nord
    for s in (West, Nord, Ost, Sud, West)
        move!(robot, s)
        putmarker!(robot)
        mark_line!(robot, s, last)
        last = inverse(s)
    end

    corner(robot)

    back!(robot, n_Ost, n_Sud)
end

function mark_line!(robot, side1, side2)
    while ((! isborder(robot, side1)) && isborder(robot, side2)) 
        move!(robot, side1)
        putmarker!(robot)
    end
end

function line!(robot, side)
    while (! isborder(robot, side)) && (! isborder(robot, Nord))
        move!(robot, side)
    end
end

markers!(robot)
