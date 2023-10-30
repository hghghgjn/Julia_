using HorizonSideRobots

robot = Robot("1.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function mark!(robot, side)
    if ! isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        not_mark!(robot, side)
    end
end

function not_mark!(robot, side)
    if ! isborder(robot, side)
        move!(robot, side)
        mark!(robot, side)
    end
end

mark!(robot, Nord)
