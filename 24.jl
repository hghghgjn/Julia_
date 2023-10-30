using HorizonSideRobots

robot = Robot("1.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function half!(robot, side)
    if ! isborder(robot, side)
        move!(robot, side)
        action!(robot, side)
        move!(robot, inverse(side))
    end
end

function action!(robot,side)
    if ! isborder(robot, side)
        move!(robot, side)
        half!(robot, side)
    end
end

halfdist!(robot, Sud)
