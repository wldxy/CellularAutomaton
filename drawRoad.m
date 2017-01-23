function drawRoad(road)
    [n, m] = size(road);
    
    figure();
    for i = 200 : 400
        for j = 1 : m
            if road(i, j) == 1
                plot(i, j, 'k.');
                hold on;
            end
        end
    end