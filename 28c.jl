function fibonacсi(n)
    if n == 0
        return 1, 0
    else
        current, prev = fibonacсi(n-1)
        return prev+current, current
    end
end

println(fibonacсi(1000)[1])
