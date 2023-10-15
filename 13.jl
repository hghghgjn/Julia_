using HorizonSideRobots

robot = Robot("1.sit"; animate=true)
HSR = HorizonSideRobots

function snake!(stop_condition::Function, robot, side1::HorizonSide, side2::HorizonSide)
    side = side1
    along!(stop_condition(), robot, side)
    while (! isborder(robot, side2)) && (! stop_condition())
        move!(robot, side2)
        side = inverse(side)
        along!(stop_condition(), robot, side)
    end
end

function along!(stop_condition::Bool, robot, side)
    while (! isborder(robot, side)) && (! stop_condition)
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

abstract type AbstractRobot end

HSR.move!(r::AbstractRobot, side) = move!(get_baserobot(r), side)

HSR.isborder(r::AbstractRobot, side) = isborder(get_baserobot(r), side)

mutable struct ChesmarkerRobot <: AbstractRobot
    robot::Robot 
    flag::Bool
end

get_baserobot(r::ChesmarkerRobot) = r.robot

HSR.move!(r::ChesmarkerRobot, side) = begin
    if r.flag
        putmarker!(r.robot)
    end
    move!(r.robot, side)
    r.flag = ! r.flag
end

function chess_mark!(robot::Robot)
    n_West, n_Sud = corner!(robot)
    r = ChesmarkerRobot(robot, iseven(n_Sud + n_West))
    snake!(stop_condition, r, Ost, Nord)
    corner!(robot)
    back!(robot, n_West, n_Sud)
end

function corner!(robot)
    n_West = 0
    n_Sud = 0
    while ! isborder(robot, West)
        n_West += 1
        move!(robot, West)
    end
    while ! isborder(robot, Sud)
        n_Sud += 1
        move!(robot, Sud)
    end
    return n_West, n_Sud
end

stop_condition() = false

function back!(robot, n_West, n_Sud)
    while (n_West != 0) || (n_Sud != 0)
        if ! isborder(robot, Ost)
            move!(robot, Ost)
            n_West -= 1
        end
        if ! isborder(robot, Nord)
            move!(robot, Nord)
            n_Sud -= 1
        end
    end
end

chess_mark!(robot)
