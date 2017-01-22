function [new_car, new_v] = border_handler(car, v, B, r_s, r_e)
    for i = r_s : r_e
        if car(i, 1) == 0
            k = rand();
            if k > 0.5
                car(i, 1) = 1;
                v(i, 1) = 3;
            end
        end
    end
    
    new_car = car;
    new_v = v;
    