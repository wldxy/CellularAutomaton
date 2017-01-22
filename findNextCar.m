function [ p ] = findNextCar( car, n, m, vmax )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
    [row, column] = size(car);
    p = column;
    mm = min(column, m+vmax+1);
    for i = m+1 : mm
        if car(n, i) == 1
            p = i;
            break;
        end
    end

end

