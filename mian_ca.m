clc,
clear all

%init ui
plotbutton=uicontrol('style','pushbutton',...  
    'string','Run',...  
    'fontsize',12,...  
    'position',[100,400,50,20],...  
    'callback','run=1;');  
  
%define the stop button  
erasebutton=uicontrol('style','pushbutton',...  
    'string','Stop',...  
    'fontsize',12,...  
    'position',[200,400,50,20],...  
    'callback','freeze=1;');  
  
%define the Quit button  
quitbutton=uicontrol('style','pushbutton',...  
    'string','Quit',...  
    'fontsize',12,...  
    'position',[300,400,50,20],...  
    'callback','stop=1;close;');  
  
number=uicontrol('style','text',...  
    'string','1',...  
    'fontsize',12,...  
    'position',[20,400,50,20]);  

B = 3;
L = 7;
p = 0.6;
len = 101;
time = [1, 1, 3, 3, 3, 1, 1];
% time = ones(1, 7) * 3;
middle = floor(len/2) + 1;
side = (L-B)/2;
waitlen = 10;
road_s = (L-B)/2 + 1;
road_e = (L-B)/2 + B;
toll = [5, 8, 10, 10, 10, 8, 5];
% z = ones(L, len);
map = zeros(L, len);
map(road_s:road_e, 1:len) = 1;
map(1:L, middle) = 2;
for i = 1 : length(toll)
    map(i, middle-toll(i)+1: middle+toll(i)-1) = 1;
end

stop = 0;
run = 0;
freeze = 0;

rate = 1;
plus = zeros(1, L);
for i = 1 : L
    plus(i) = exp((i-1)*rate);
end

global vdown;
global vdownlist;
vdown = zeros(L, len);
vdownlist = [];

road = [];

v = zeros(L, len);
car = zeros(L, len);
line = zeros(L, len);
vmax = 5;
wait = zeros(1, L);

% imh = image(cat(3, z, map, ceils));
colormap('gray');
imh = image(generateImage(car, map, wait, middle));
set(gca,'xtick', [0.5: 1: len+0.5]);
set(gca,'ytick', [0.5: 1: L+0.5]);
set(gca,'xticklabel', '');
set(gca,'yticklabel', '');
axis equal  
axis tight  
grid on;

while (stop == 0)
    if (run == 1)
        [car, v] = border_handler(car, v, B, road_s, road_e, p);
        
        for j = len : -1 : middle+waitlen+2
            for i = road_s : road_e
                if map(i, j) == 1 && car(i, j) ~= 0
                    [new_i, new_j, car, v] = normalRun(car, v, vmax, i, j);
                end
            end             
        end
        
        for j = middle+waitlen+1 : -1 : middle+1
            for i = 1 : road_s-1
                if car(i, j) == 1
                    [new_i, new_j, car, v] = mergeRun(car, v, map, vmax, i, j);
                end
            end
            
            for i = L : -1 : road_e+1
                if car(i, j) == 1
                    [new_i, new_j, car, v] = mergeRun(car, v, map, vmax, i, j);
                end
            end
            
            for i = road_s : road_e
                if map(i, j) == 1 && car(i, j) ~= 0
                    [new_i, new_j, car, v] = normalRun(car, v, vmax, i, j);
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
                    [new_i, new_j, car, v] = normalRun(car, v, vmax, i, j);
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
                    [new_i, new_j, car, v] = enterRun(car, v, vmax, i, j, toll, count, map, plus, middle);
                end
            end
        end  
        
        for j = middle-waitlen-2 : -1 : 1
            for i = road_s : road_e
                if map(i, j) == 1 && car(i, j) ~= 0
                    [new_i, new_j, car, v] = normalRun(car, v, vmax, i, j);
                end
            end            
        end 
        
        set(imh, 'cdata', generateImage(car, map, wait, middle));
        stepnumber=1+str2num(get(number,'string'));  
        set(number,'string',num2str(stepnumber));
        road = [road ; car(3, :)];
    end
    
    if (freeze == 1)
        run = 0;
        freeze = 0;
    end
%     pause(0.1);
    drawnow
end