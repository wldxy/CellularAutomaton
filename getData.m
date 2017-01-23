function getData(flag)
    load data1 data
    global numcar
    global change
    global distlist
    global alldist
    global downtime
    global runtime
    global stoptime
    global runlist
    global stoplist
    global times
    
    carflow = numcar / 10;
    dchange = change / 10;
    ddown = downtime / 10;
    dist = mean(distlist);
    dstop = mean(stoplist);
    drun = mean(runlist);
    
    d = [carflow, dchange, ddown, dist, dstop, drun]';
    if flag == 1
        data = [data, d];
        save data1 data
    else
        disp(d);
    end