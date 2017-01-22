function [ p ] = findNextCar( car, n, m )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
    [row, column] = size(car);
    p = column;
    for i = m+1 : column
        if car(n, i) == 1
            p = i;
            break;
        end
    end

end

