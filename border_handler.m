function [new_car, new_v] = border_handler(car, v, B)
    for i = 1 : B
        if car(i, 1) == 0
            k = rand();
            if k > 0.3
                car(i, 1) = 1;
                v(i, 1) = 0;
            end
        end
    end
    
    new_car = car;
    new_v = v;
    