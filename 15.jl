using HorizonSideRobots

robot = Robot("6.sit", animate=true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function kross!(robot)
    n_Ost, n_Sud = corner!(robot)
    n1 = side!(robot, West)
    n2 = side!(robot, Nord)
    corner!(robot)
    snake!(robot, West, Nord, n_Ost, n_Sud, n1, n2)
    corner!(robot)
    back!(robot, n_Ost, n_Sud)
end

function back!(robot, n_Ost, n_Sud)
    while (n_Ost != 0) || (n_Sud != 0)
        if (! isborder(robot, West)) && (n_Ost != 0)
            move!(robot, West)
            n_Ost -= 1
        end
        if (! isborder(robot, Nord)) && (n_Sud != 0)
            move!(robot, Nord)
            n_Sud -= 1
        end
    end
end

function detour(robot, side, n2, n1)
    cnt = 0
    while isborder(robot, side) && (n2 + cnt != n1)
        move!(robot, Nord)
        cnt += 1
    end
    move!(robot, side)
    n = 0
    if isborder(robot, Sud)
        while isborder(robot, Sud)
            n += 1
            move!(robot, side)
        end
    end
    while cnt != 0
        cnt -= 1
        move!(robot, Sud)
    end
    return n + 1
end

function side!(robot, side)
    n = 0
    while ! isborder(robot, side)
        n += 1
        move!(robot, side)
    end
    return n
end

function snake!(robot, side1::HorizonSide, side2::HorizonSide, n_Ost, n_Sud, n1, n2)
    cnt = 0
    side = side1
    n = 0
    m = 0
    along!(robot, side, n_Ost, n_Sud, n, m, n1, n2)
    loc = true
    while (! isborder(robot, side2)) && (cnt != 2)
        n_Sud -= 1
        n = 0
        move!(robot, side2)
        m += 1
        side = inverse(side)
        n, cnt_ = along!(robot, side, n_Ost, n_Sud, n, m, n1, n2)
        cnt += cnt_
    end
end

function along!(robot, side, n_Ost, n_Sud, n, m, n1, n2)
    cnt = 0
    while n != n1
        if side == West
            if (abs(n_Ost - n_Sud) == n) || (abs(n_Ost + n_Sud) == n)
                putmarker!(robot)
            end
        else
            if (abs(n1 - abs(n_Ost - n_Sud)) == n) || (abs(n1 - (n_Ost + n_Sud)) == n)
                putmarker!(robot)
            end
        end
        if (n == 0) && ismarker(robot)
            cnt += 1
        end
        if (isborder(robot, side)) && (n1 != n)
            n += detour(robot, side, n, n1)
        else
            n += 1
            move!(robot, side)
        end
    end
    return n, cnt
end


function corner!(robot)
    n_Ost = 0
    n_Sud = 0
    while (! isborder(robot, Ost)) || (! isborder(robot, Sud))
        while ! isborder(robot, Ost)
            n_Ost += 1
            move!(robot, Ost)
        end
        while ! isborder(robot, Sud)
            n_Sud += 1
            move!(robot, Sud)
        end
    end
    return n_Ost, n_Sud
end

kross!(robot)
