function [ p ] = findNextCar( car, n, m, vmax )
    [row, column] = size(car);
    p = column + vmax;
    mm = min(column, m+vmax+1);
    for i = m+1 : mm
        if car(n, i) == 1
            p = i;
            break;
        end
    end

end

