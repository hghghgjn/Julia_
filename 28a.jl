function fib_norecurs(n)
    F_prev = F_next = 1
    while n > 0
        F_next, F_prev = F_prev + F_next, F_next
        n -= 1
    end
    return F_prev
end

println(fib_norecurs(10))
