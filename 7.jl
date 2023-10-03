using HorizonSideRobots

robot = Robot("7.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function search!(robot)
    n = 0
    side = West
    while isborder(robot, Nord)
        n += 1
        move_1!(robot, side, n)
        side = inverse(side)
    end    
end 

function move_1!(robot, side, n)
    while n > 0 && isborder(robot, Nord)
        move!(robot, side)
    end
end

search!(robot)
