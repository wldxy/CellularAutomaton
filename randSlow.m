function new_v = randSlow(v)
    p = 0.2;
    p_rand = rand();
    if p_rand < p
        v = max(v-1, 0);
    end
    new_v = v;