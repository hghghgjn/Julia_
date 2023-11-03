function summa(array::Vector{T}, s::T=0) where T
    if length(array) == 0
        return s
    end
    return summa(Vector(@view(array[1:end-1])), s+array[end])
end

println(summa(Vector([1, 2, 3, 4, 5, 6])))
