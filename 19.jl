using HorizonSideRobots

robot = Robot("1.sit", animate=true)

function side!(robot, side)
    if ! isborder(robot, side)
        move!(robot, side)
        side!(robot, side)
    end
end

side!(robot, Ost)
