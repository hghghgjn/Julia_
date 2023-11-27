include("edge_robot.jl")

crossmarker_robot = CrossmarkerRobot(Robot("31_3.sit"; animate = true), 0, 0)

function max_min_coord(edge_robot, crossmarker_robot)
    max_y, min_y, min_x, max_x = 0, 0, 0, 0
    x = crossmarker_robot.x
    y = crossmarker_robot.y
    move!(edge_robot)
    max_x = max(max_x, crossmarker_robot.x)
    max_y = max(max_y, crossmarker_robot.y)
    min_y = min(min_y, crossmarker_robot.y)
    min_x = min(min_x, crossmarker_robot. x)
    loc = 0
    while loc != 4
        move!(edge_robot)
        max_x = max(max_x, crossmarker_robot.x)
        max_y = max(max_y, crossmarker_robot.y)
        min_y = min(min_y, crossmarker_robot.y)
        min_x = min(min_x, crossmarker_robot. x)
        if ((crossmarker_robot.x, crossmarker_robot.y) == (x, y))
            loc += 1
        end
    end
    return max_x, max_y, min_y, min_x
end



function cross!(crossmarker_robot)
    
    while (! isborder(crossmarker_robot, Nord))
        move!(crossmarker_robot, Nord)
    end
    edge_robot = EdgeRobot{CrossmarkerRobot}(crossmarker_robot, Nord, Positive)

    max_x = max_min_coord(edge_robot, crossmarker_robot)[1]
    min_x = max_min_coord(edge_robot, crossmarker_robot)[4]
    loc = 0
    side = West
    while (loc != 2)
        if (crossmarker_robot.x == max_x)
            loc += 1
        end
        while (! isborder(crossmarker_robot, Nord))
            move!(crossmarker_robot, Nord)
        end
        while (! isborder(crossmarker_robot, Sud))
            move!(crossmarker_robot, Sud)
        end
        while (! isborder(crossmarker_robot, Nord))
            move!(crossmarker_robot, Nord)
        end
        edge_robot = EdgeRobot{CrossmarkerRobot}(crossmarker_robot, Nord, Positive)
        last_x = crossmarker_robot.x
        if (! isborder(crossmarker_robot, side))
            move!(crossmarker_robot, side)
        else
            while last_x == crossmarker_robot.x
                move!(edge_robot)
            end
        end
        if crossmarker_robot.x == min_x
            side = Ost
        end
    end
end

cross!(crossmarker_robot)
