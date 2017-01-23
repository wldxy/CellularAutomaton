function solveCA(p)
    B = 3;
    L = 7;
    len = 101;
    toll = [8, 15, 20, 20, 20, 15, 8];
    time = [3, 3, 3, 3, 3, 3, 3];
    % B = 6;
    % L = 10;
    % len = 51;
    % toll = [12, 15, 20, 20, 20, 20, 20, 20, 15, 12];
    % time = ones(1, 10)*3;

%     p = 0.5;
    % time = ones(1, 7) * 3;
    middle = floor(len/2) + 1;
    side = (L-B)/2;
    road_s = (L-B)/2 + 1;
    road_e = (L-B)/2 + B;
    waitlen = toll(road_s);
    % z = ones(L, len);
    map = zeros(L, len);
    map(road_s:road_e, 1:len) = 1;
    map(1:L, middle) = 2;
    for i = 1 : length(toll)
        map(i, middle-toll(i)+1: middle+toll(i)-1) = 1;
    end

    % global vdown;
    % global vdownlist;
    % vdown = zeros(L, len);
    % vdownlist = [];
    global times
    global numcar
    global change
    global distlist
    global alltime
    global downtime
    global runtime
    global stoptime
    global runlist
    global stoplist
    numcar = 0;
    times = 0;
    alltime = 0;
    distlist = [];
    change = 0;
    downtime = 0;
    runtime = zeros(L, len);
    stoptime = zeros(L, len);
    runlist = [];
    stoplist = [];

    stop = 0;
    run = 0;
    freeze = 0;

    rate = 1;
    plus = zeros(1, L);
    for i = 1 : L
        plus(i) = exp((i-1)*rate);
    end

    road = [];

    v = zeros(L, len);
    car = zeros(L, len);
    line = zeros(L, len);
    vmax = 5;
    wait = zeros(1, L);
    run = 1;
    while (stop == 0)
        if (run == 1)
            [car, v] = border_handler(car, v, B, road_s, road_e, p);
            alltime = 0;
            for j = len : -1 : middle+waitlen+2
                for i = road_s : road_e
                    if map(i, j) == 1 && car(i, j) ~= 0
                        [new_i, new_j, car, v] = normalRun(car, map, v, vmax, i, j);
                    end
                end             
            end

            for j = middle+waitlen+1 : -1 : middle+1
                for i = 1 : road_s-1
                    if car(i, j) == 1
%                         [new_i, new_j, car, v] = mergeRun(car, map, v, vmax, i, j);
                        [new_i, new_j, car, v] = mergeRunV2(car, map, v, vmax, i, j);
                    end
                end

                for i = L : -1 : road_e+1
                    if car(i, j) == 1
%                         [new_i, new_j, car, v] = mergeRun(car, map, v, vmax, i, j);
                        [new_i, new_j, car, v] = mergeRunV2(car, map, v, vmax, i, j);
                    end
                end

                for i = road_s : road_e
                    if map(i, j) == 1 && car(i, j) ~= 0
                        [new_i, new_j, car, v] = normalRun(car, map, v, vmax, i, j);
                    end
                end     
            end

            count = zeros(1, L);
            for i = 1 : L
                for j = middle-toll(i) : middle
                    if car(i, j) == 1
                        count(i) = count(i) + 1;
                    end
                end
            end

            for i = 1 : L
                if car(i, middle) == 1
                    if wait(i) < time(i) && wait(i) ~= -1
                        wait(i) = wait(i) + 1;
                    else
                        [new_i, new_j, car, v] = normalRun(car, map, v, vmax, i, j);
                        if new_i == i && new_j == j
                            wait(i) = -1;
                        else
                            wait(i) = 0;
                        end
                    end
                end
            end

            for j = middle-1 : -1 : middle-waitlen-1
                for i = 1 : L
                    if map(i, j) == 1 && car(i, j) ~= 0
                        [new_i, new_j, car, v] = enterRun(car, map, v, vmax, i, j, toll, count, plus);
                    end
                end
            end  

            for j = middle-waitlen-2 : -1 : 1
                for i = road_s : road_e
                    if map(i, j) == 1 && car(i, j) ~= 0
                        [new_i, new_j, car, v] = normalRun(car, map, v, vmax, i, j);
                    end
                end            
            end 
            
            road = [road ; car(3, :)];
            distlist = [distlist, alltime / numcar];
            times = times + 1;
        end

        if (times == 1000)
            stop = 0;
            break;
        end

        if (freeze == 1)
            run = 0;
            freeze = 0;
        end
    %     pause(0.1);
    end