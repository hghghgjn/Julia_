using HorizonSideRobots

robot = Robot("1.sit", animate=true)

function mark_line_numsteps_along!(robot, side1, side2)
    n = 0
    while (! isborder(robot, side1)) && (! isborder(robot, side2))
        move!(robot, side1)
        move!(robot, side2)
        putmarker!(robot)
        n += 1
    end
    return n
end

function along!(robot, side1, side2, num_steps)
    for k in 1:num_steps
        move!(robot, side1)
        move!(robot, side2)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function kross!(robot)
    putmarker!(robot)
    for s1 in (Nord, Sud)
        for s2 in (West, Ost)
            n = mark_line_numsteps_along!(robot, s1, s2)
            along!(robot, inverse(s1), inverse(s2), n)
        end
    end
end

kross!(robot)
