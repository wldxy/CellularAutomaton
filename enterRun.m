function [new_i, new_j, new_car, new_v] = enterRun(car, map, v, vmax, i, j, toll, count, plus)
    [L, len] = size(car);

    p_turn = zeros(1, 3);
    if i > 1 && map(i-1, j) == 1 && car(i-1, j) ~= 1
        p_l = findLastCar(car, i-1, j, vmax);
        if p_l ~= -1
            d_l = j - p_l;
            if d_l > v(i-1, p_l) && d_l > 1
                extra = toll(i-1)-count(i-1);
                p_turn(1) = plus(2)*extra;
            end
        end
    end

    if i < L && map(i+1, j) == 1 && car(i+1, j) ~= 1
        p_r = findLastCar(car, i+1, j, vmax);
        if p_r ~= -1
            d_r = j - p_r;
            if d_r > v(i+1, p_r) && d_r > 1
                extra = toll(i+1) - count(i+1);
                p_turn(3) = plus(2)*extra;
            end
        end
    end

    p_turn(2) = plus(1) * count(i);
    if sum(p_turn) ~= 0
        p_turn = p_turn / sum(p_turn);
        pp = rand();
        for h = 1 : 3
            if pp <= sum(p_turn(1:h))
                flag = h;
                break;
            end
        end
    else
        flag = 2;
    end

    turn_i = i;
    if flag == 1
        car(i-1, j) = car(i, j);
        v(i-1, j) = v(i, j);
        car(i, j) = 0;
        v(i, j) = 0;
        turn_i = i-1;
    end

    if flag == 3
        car(i+1, j) = car(i, j);
        v(i+1, j) = v(i, j);
        car(i, j) = 0;
        v(i, j) = 0;
        turn_i = i+1;
    end
    
    i = turn_i;
    [new_i, new_j, new_car, new_v] = normalRun(car, map, v, vmax, i, j);
%     v(i, j) = min(v(i, j) + 1, vmax);
%     p = findNextCar(car, i, j, vmax);
%     d = p - j - 1;
%     v(i, j) = min(v(i, j), d);
%     v(i, j) = randSlow(v(i, j));
% 
%     new_v = v(i, j);
%     new_i = i;
%     new_j = j+v(i, j);
%     
%     if new_j >= middle
%         new_j = middle;
%         car(i, new_j) = 1;
%         v(i, new_j) = 0;
%     else
%         if new_j <= len
%             car(i, new_j) = 1;
%             v(i, new_j) = new_v;
%         end
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