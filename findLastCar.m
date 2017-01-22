function p = findLastCar(car, n, m, vmax)
    mm = max(1, m-vmax);
    p = mm;
    for i = mm : m-1
        if car(n, i) == 1
            p = i;
            break;
        end
    end