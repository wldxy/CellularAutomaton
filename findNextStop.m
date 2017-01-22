function p = findNextStop(car, map, n, m, vmax)
    [row, column] = size(car);
    p = column;
    mm = min(column, m+vmax+1);
    for i = m+1 : mm
        if car(n, i) == 1 || map(n, i) == 0
            p = i;
            break;
        end
    end

end

