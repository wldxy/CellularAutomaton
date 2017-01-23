clc, clear all

data = [];
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

for i = 0.45 : 0.01 : 0.65
    for j = 1 : 10
        solveCA(i);
        disp(i)
        carflow = numcar / 10;
        dchange = change / 10;
        ddown = downtime / 10;
        dist = mean(distlist);
        dstop = mean(stoplist);
        drun = mean(runlist);

        d = [carflow, dchange, ddown, dist, dstop, drun]';
        data = [data , d];
    end
end