B = 3;
L = 6;
len = 50;
toll = [10, 10, 10, 8, 5, 3];
z = ones(L, len);
map = zeros(L, len);
map(1:B, 1:len) = 1;
ceil = zeros(L, len);
for i = 1 : length(toll)
    map(i, len/2-toll(i): len/2+toll(i)) = 1;
end
ceil(2, 20) = 1;

imh = image(cat(3, z, map, ceil));
set(gca,'xtick', [0.5: 1: len+0.5]);
set(gca,'ytick', [0.5: 1: L+0.5]);
set(gca,'xticklabel', '');
set(gca,'yticklabel', '');
axis equal  
axis tight  
grid on;