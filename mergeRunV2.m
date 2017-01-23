function [new_i, new_j, new_car, new_v] = mergeRunV2(car, map, v, vmax, i, j)
    [L, len] = size(car);
    global change;
    
    if map(i, j+1) == 0
        if i < L / 2
            if car(i+1, j) ~= 1
                p = findLastCar(car, i+1, j, vmax);
                d = j - p;
                if d > v(i+1, j)
                    change = change + 1;
                    car(i+1 ,j) = 1;
                    v(i+1, j) = v(i, j);
                    car(i, j) = 0;
                    v(i, j) = 0;
                    i = i+1;
                end
            end
        else
            if car(i-1, j) ~= 1
                p = findLastCar(car, i-1, j, vmax);
                d = j - p;
                if d > v(i-1, j)
                    change = change + 1;
                    car(i-1 ,j) = 1;
                    v(i-1, j) = v(i, j);
                    car(i, j) = 0;
                    v(i, j) = 0;
                    i = i-1;
                end
            end
        end
    end
    
    [new_i, new_j, new_car, new_v] = normalRun(car, map, v, vmax, i, j);