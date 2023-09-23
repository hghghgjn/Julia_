using HorizonSideRobots

robot = Robot("1.sit"; animate=true)

function mark_line!(robot, side)
    #Маркирует линию до упора заданного направления, в начале маркер не ставит. Возвращает число сделанных шагов
    cnt = 0
    while isborder(robot, side) == false
        move!(robot, side)
        putmarker!(robot)
        cnt += 1
    end
    return cnt
end

function move_2!(robot,side,num_steps)
    for k in 1:num_steps 
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function kross!(robot)
    for s in (Nord, West, Sud, Ost)
        n = mark_line!(robot, s)
        move_2!(robot, inverse(s), n)
    end
    putmarker!(robot)
end

kross!(robot)
