clc, clear all
% 
% load data1 data1
% load data2 data2
load data6 data6
load data5 data5

data1 = data6;
data2 = data5;

k = 6;
p = 5;
[n, m] = size(data1);
data11 = zeros(n, m/p);
for i = 1 : m/p
    data11(:, i) = mean(data1(:, ((i-1)*p+1):i*p), 2);
end

[n, m] = size(data2);
data22 = zeros(n, m/p);
for i = 1 : m/p
    data22(:, i) = mean(data2(:, ((i-1)*p+1):i*p), 2);
end

plot(data11(1, :), data11(k, :), 'r', data22(1, :), data22(k, :), 'b');
% legend('late merge method', 'early merge method');
% legend('ETC toll', 'human staff toll');
legend('normal shape', 'test shape');
hold on
plot(data1(1, :), data1(k, :), 'r.', data2(1, :), data2(k, :), 'b.')
xlabel('traffic volume');
% ylabel('number of changing the lane');
% ylabel('number of speed reduction');
% ylabel('number of stopping the car');
ylabel('average time of passing the toll');

% hold on;
% plot(x1, y1, 'r.', x2, y2, 'b.');
grid on;