using HorizonSideRobots

robot = Robot("8.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function search!(robot)
    n = 0
    side1 = West
    side2 = Sud

    while ! ismarker(robot)
        n += 1
        move_1!(robot, side1, n)
        move_1!(robot, side2, n)
        side1 = inverse(side1)
        side2 = inverse(side2)
    end    
    
end 

function move_1!(robot, side, n)
    while n > 0 && ! ismarker(robot)
        move!(robot, side)
        n -= 1
    end
end

search!(robot)
