function [new_i, new_j, new_car, new_v] = mergeRun(car, v, map, vmax, i, j)
    [L, len] = size(car);
    
    if i < L / 2
        if car(i+1, j) ~= 1
            p = findLastCar(car, i+1, j, vmax);
            d = j - p;
            if d > v(i+1, j)
                i = i+1;
                car(i+1 ,j) = 1;
                v(i+1, j) = v(i, j);
                car(i, j) = 0;
                v(i, j) = 0;
            end
        end
    else
        if car(i-1, j) ~= 1
            p = findLastCar(car, i-1, j, vmax);
            d = j - p;
            if d > v(i-1, j)
                i = i-1;
                car(i-1 ,j) = 1;
                v(i-1, j) = v(i, j);
                car(i, j) = 0;
                v(i, j) = 0;
            end
        end
    end
    
    v(i, j) = min(v(i, j) + 1, vmax);
    p = findNextStop(car, map, i, j, vmax);
    d = p - j - 1;
    v(i, j) = min(v(i, j), d);
    v(i, j) = randSlow(v(i, j));

    new_v = v(i, j);
    new_i = i;
    new_j = j+v(i, j);
    if new_j <= len
        car(i, new_j) = 1;
        v(i, new_j) = new_v;
    end

    if j ~= new_j || i ~= new_i
        car(i, j) = 0;
        v(i, j) = 0;
    end
    
    new_car = car;
    new_v = v;
    