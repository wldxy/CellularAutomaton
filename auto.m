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
L = 6;
len = 100;
toll = [10, 10, 10, 8, 5, 3];
z = ones(L, len);
map = zeros(L, len);
map(1:B, 1:len) = 1;
ceils = zeros(L, len);
for i = 1 : length(toll)
    map(i, len/2-toll(i): len/2+toll(i)) = 1;
end

imh = image(cat(3, z, map, ceils));
set(gca,'xtick', [0.5: 1: len+0.5]);
set(gca,'ytick', [0.5: 1: L+0.5]);
set(gca,'xticklabel', '');
set(gca,'yticklabel', '');
axis equal  
axis tight  
grid on;

stop = 0;
run = 0;
freeze = 0;

v = zeros(L, len);
car = zeros(L, len);
vmax = 5;
while (stop == 0)
    if (run == 1)
        [car, v] = border_handler(car, v, B);
        for j = len :-1 : 1
            for i = 1 : L
                if map(i, j) == 1 && car(i, j) ~= 0 
                    v(i, j) = min(v(i, j) + 1, vmax);
                    p = findNextCar(car, i, j);
                    d = p - i;
                    v(i,  j) = min(v(i, j), d);
                    
                    new_v = v(i, j);
                    new_j = j+v(i, j);
                    if new_j <= len
                        car(i, new_j) = 1;
                        v(i, new_j) = new_v;
                    end
                    
                    car(i, j) = 0;
                    v(i, j) = 0;
                end
            end
        end
        
        ceils = car;
        set(imh, 'cdata', cat(3, z, map, ceils));
        stepnumber=1+str2num(get(number,'string'));  
        set(number,'string',num2str(stepnumber))  
    end
    
    if (freeze == 1)
        run = 0;
        freeze = 0;
    end
    pause(0.1);
    drawnow
end


