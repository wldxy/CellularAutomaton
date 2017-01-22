function imh = generateImage(car, map, wait, middle)
    imh = car * 10 + map * 30;
    imh(:, middle) = imh(:, middle) + 20;
    for i = 1 : length(wait)
        if wait(i) > 0
            imh(i, middle) = 255;
        end
    end