clc, clear all

load data1 data1
load data2 data2

k = 2
x1 = data1(1, :);
y1 = data1(k, :);

x2 = data2(1, :);
y2 = data2(k, :);

[n, m] = size(data1);
data11 = zeros(n, m/10);
for i = 1 : m/10
    data11(:, i) = mean(data1(:, ((i-1)*10+1):i*10), 2);
end

[n, m] = size(data2);
data22 = zeros(n, m/10);
for i = 1 : m/10
    data22(:, i) = mean(data2(:, ((i-1)*10+1):i*10), 2);
end

plot(data11(1, :), data11(k, :), 'r', data22(1, :), data22(k, :), 'b');
legend('early merge method', 'late merge method');
hold on
plot(data1(1, :), data1(k, :), 'r.', data2(1, :), data2(k, :), 'b.')
xlabel('traffic volume');
ylabel('number of changing the lane');
% ylabel('number of stopping the car');
% ylabel('number of speed reduction');
% ylabel('average time of passing the toll');

% hold on;
% plot(x1, y1, 'r.', x2, y2, 'b.');
grid on;