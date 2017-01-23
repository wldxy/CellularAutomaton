function [new_car, new_v] = border_handler(car, v, B, r_s, r_e, p)
    global numcar;
    for i = r_s : r_e
        if car(i, 1) == 0
            k = rand();
            if k < p
                numcar = numcar+1;
                car(i, 1) = 1;
                v(i, 1) = 3;
            end
        end
    end
    
%     q = 0.5;
%     t = 1;
%     x = 1;
%     p = (q*t)^x*exp(-q*t)/prod(x);
%     for i = r_s : r_e
%         if car(i, 1) == 0
%             rand('state',sum(100*clock)*rand(1)); 
%             k = rand();
%             v_n = round(rand())+3;
%             if k <= p
%                 car(i, 1) = 1;
%                 v(i, 1) = v_n;
%             end
%         end
%     end

    new_car = car;
    new_v = v;
    