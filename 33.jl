using HorizonSideRobots

r = Robot("26_1.sit"; animate=true)

HSR = HorizonSideRobots

abstract type AbstractRobot end

HSR.move!(r::AbstractRobot, side) = move!(get_baserobot(r), side)

HSR.isborder(r::AbstractRobot, side) = isborder(get_baserobot(r), side)

mutable struct CoordRobot <: AbstractRobot
    robot::Robot 
    x::Int
    y::Int
end

get_baserobot(r::CoordRobot) = r.robot

HSR.move!(r::CoordRobot, side) = begin
    move!(r.robot, side)
    if side == Nord
        r.y += 1
    elseif side == West
        r.x -= 1
    elseif side == Sud
        r.y -= 1
    else
        r.x += 1
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

robot = CoordRobot(r, 0, 0)
max_t = temperature(r)
c = (0, 0)

function temp!(robot, r,  coords::Set, max_t)
    if ! ((robot.x , robot.y) in coords)
        push!(coords, (robot.x, robot.y))
        if max_t < temperature(r)
            max_t = max(max_t, temperature(r))
            c = (robot.x, robot.y)
        end
        for side in (Nord, West, Sud, Ost)
            if ! isborder(robot, side)
                move!(robot, side)
                temp!(robot, r, coords, max_t)
                move!(robot, inverse(side))
            end
        end
    end
end
function t!(robot, r, max_t)
    temp!(robot, r, Set(), max_t)
    if c[1] < 0
        side_x = West
    else
        side_x = Ost
    end

    if c[2] < 0
        side_y = West
    else
        side_y = Ost
    end

    while (! ((robot.x, robot.y) == c))
        if ((! isborder(robot, side_x)) && ( ! (robot.x == c[1])))
            move!(robot, side_x)
        end

        if ((! isborder(robot, side_y)) && ( ! (robot.y == c[2])))
            move!(robot, side_y)
        end
    end
end

t!(robot, r, max_t)
