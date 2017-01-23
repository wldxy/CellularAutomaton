function [new_i, new_j, new_car, new_v] = normalRun(car, map, v, vmax, i, j)
    [L, len] = size(car);
    middle = floor(len/2) + 1;
    
    v(i, j) = min(v(i, j) + 1, vmax);
    p = findNextStop(car, map, i, j, vmax);
    d = p - j - 1;  
    v(i, j) = min(v(i, j), d);
    v(i, j) = randSlow(v(i, j));
    
    global stoptime
    global runtime
    global runlist
    global stoplist
    if (v(i, j) == 0)
        stoptime(i, j) = stoptime(i, j)+1;
    end
    runtime(i, j) = runtime(i, j)+1;
    
    new_v = v(i, j);
    new_i = i;
    new_j = j+v(i, j);
    if j < middle && new_j >= middle
        new_j = middle;
        car(i, new_j) = 1;
        v(i, new_j) = 0;
    else
        if new_j <= len
            car(i, new_j) = 1;
            v(i, new_j) = new_v;
        else
            runlist = [runlist, runtime(i, j)];
            stoplist = [stoplist, stoptime(i, j)];
        end
    end
    
    if j ~= new_j || i ~= new_i
        car(i, j) = 0;
        v(i, j) = 0;
    end
    moveCar(i, j, new_i, new_j);
    
    new_car = car;
    new_v = v;
% 
% function [new_i, new_j, new_car, new_v] = normalRun(car, v, vmax, i, j)
%     [L, len] = size(car);
%     
%     v(i, j) = min(v(i, j) + 1, vmax);
%     p = findNextCar(car, i, j, vmax);
%     d = p - j - 1;
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