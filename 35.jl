include("edge_robot.jl")

along!(stop_condition::Function, edge_robot::EdgeRobot) = while !stop_condition() 
    move!(edge_robot) 
end

along!(edge_robot::EdgeRobot, num_steps) = for _ in 1:num_steps 
    move!(edge_robot) 
end

function along!(edge_robot::EdgeRobot, stop_condition::Function, num_steps)
    while ((! stop_condition()) && (num_steps != 0))
        move!(edge_robot)
        num_steps -= 1
    end
    if num_steps > 0
        return num_steps
    end
end
