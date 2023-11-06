using HorizonSideRobots

r = Robot("26_1.sit"; animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function lab!(robot, x, y, coords::Set)
    if ! ((x , y) in coords)
        push!(coords, (x, y))
        if ((x + y) % 2) == 0
            putmarker!(robot)
        end
        for side in (Nord, West, Sud, Ost)
            if ! isborder(robot, side)
                move!(robot, side)
                if side == Nord
                    lab!(robot, x, y + 1, coords)
                elseif side == West
                    lab!(robot, x - 1, y, coords)
                elseif side == Sud
                    lab!(robot, x, y - 1, coords)
                else
                    lab!(robot, x + 1, y, coords)
                end
                move!(robot, inverse(side))
            end
        end
    end
end

lab!(r, 0, 0, Set())
