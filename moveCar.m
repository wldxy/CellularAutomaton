function moveCar(old_i, old_j, new_i, new_j)
    global runtime
    global stoptime
    t = runtime(old_i, old_j);
    runtime(old_i, old_j) = 0;
    runtime(new_i, new_j) = t;
    
    t = stoptime(old_i, old_j);
    stoptime(old_i, old_j) = 0;
    stoptime(new_i, new_j) = t;
    