using HorizonSideRobots

robot = Robot("1.sit", animate=true)

function numsteps_along!(robot, side)
    n = 0
    while ! isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function along!(robot, side)
    while ! isborder(robot, side)
        move!(robot, side)
    end
end

function mark_line!(robot, side)
    while ! isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
end

function move_2!(robot, side, num_steps)
    for i in 1:num_steps
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function kross!(robot)
    n_West = numsteps_along!(robot, West)
    n_Sud = numsteps_along!(robot, Sud)
    side = Ost
    while ! isborder(robot, Nord) 
        putmarker!(robot)
        mark_line!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end
    putmarker!(robot)
    mark_line!(robot, side)
    along!(robot, Sud)
    along!(robot, West)
    move_2!(robot, Ost, n_West)
    move_2!(robot, Nord, n_Sud)
end

kross!(robot)
