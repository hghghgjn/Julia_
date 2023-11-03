using HorizonSideRobots

robot = Robot("29_1.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function mark_labirint!(robot)
    if !ismarker(robot)
        putmarker!(robot)
        for side in (Nord, West, Sud, Ost)
            move!(robot, side)
            mark_labirint!(robot)
            move!(robot, inverse(side))
        end
    end
end

mark_labirint!(robot)
