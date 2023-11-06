using HorizonSideRobots

robot = Robot("26_1.sit"; animate=true)

HSR = HorizonSideRobots

abstract type AbstractRobot end

HSR.move!(r::AbstractRobot, side) = move!(get_baserobot(r), side)

HSR.isborder(r::AbstractRobot, side) = isborder(get_baserobot(r), side)

mutable struct ChesmarkerRobot <: AbstractRobot
    robot::Robot 
    x::Int
    y::Int
end

get_baserobot(r::ChesmarkerRobot) = r.robot

HSR.move!(r::ChesmarkerRobot, side) = begin
    if ((r.x + r.y) % 2) == 0
        putmarker!(r.robot)
    end
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

robot = ChesmarkerRobot(robot, 0, 0)

function lab!(robot, coords::Set)
    if ! ((robot.x , robot.y) in coords)
        push!(coords, (robot.x, robot.y))
        for side in (Nord, West, Sud, Ost)
            if ! isborder(robot, side)
                move!(robot, side)
                lab!(robot, coords)
                move!(robot, inverse(side))
            end
        end
    end
end

lab!(robot, Set())
