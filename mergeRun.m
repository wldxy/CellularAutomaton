function [new_i, new_j, new_car, new_v] = mergeRun(car, map, v, vmax, i, j)
    [L, len] = size(car);
    global change;
    
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
    
    [new_i, new_j, new_car, new_v] = normalRun(car, map, v, vmax, i, j);
%     v(i, j) = min(v(i, j) + 1, vmax);
%     p = findNextStop(car, map, i, j, vmax);
%     d = p - j - 1;
%     
%     global vdown;
%     global vdownlist;
%     if (v(i, j) > d)
%         vdown(i, j) = vdown(i, j) + 1;
%     end
%     
%     v(i, j) = min(v(i, j), d);
%     v(i, j) = randSlow(v(i, j));
%     
%     new_v = v(i, j);
%     new_i = i;
%     new_j = j+v(i, j);
%     if new_j <= len
%         car(i, new_j) = 1;
%         v(i, new_j) = new_v;
%     end
% 
%     if j ~= new_j || i ~= new_i
%         car(i, j) = 0;
%         v(i, j) = 0;
%     end
%     
%     new_car = car;
%     new_v = v;
%     