function new_v = randSlow(v)
    if v ~= 1
        p = 0.3;
        p_rand = rand();
        if p_rand < p
            v = max(v-1, 0);
        end
        new_v = v;
    else
        new_v = v;
    end