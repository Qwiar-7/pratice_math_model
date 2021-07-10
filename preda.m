% параметры
alpha2 = 6;
beta1 = 2.8;
beta2 = 0.5;
T1 = 1;
T2 = 1;

h = 0.1;
t_start = 0;
t_end = 50;
n = floor(t_end / h);
t_arr = zeros(1, n + 1);

x1_0 = 10; % жертвы
x2_0 = 5;  % хищники
x3_0 = 1;  % питание

x1_goal = zeros(n + 2);
x1_goal_func = @(k) 48;
for i = 1:size(x1_goal)
   x1_goal(i) = x1_goal_func(i);
end


res = zeros(n + 1, 3);
x_k = zeros(3, 1);
x_k(1) = x1_0;
x_k(2) = x2_0;
x_k(3) = x3_0;

psi = @(k) (h * beta1 * x_k(1) * x_k(2) - x_k(1) + x1_goal(k + 1) - ...
    T2 * x_k(1) + T2 * x1_goal(k)) / (h * x_k(1));
psi_k = zeros(n + 1);

u = @(k) (psi(k + 1) + T1 * psi(k) - x_k(3) - T1 * x_k(3)) / h;
u_k = zeros(n + 1);



t = t_start;
for k = 1:n
    t_arr(k) = t;
    res(k + 1, 1) = x_k(1) + h * (x_k(3) * x_k(1) - beta1 * x_k(1) * x_k(2));
    res(k + 1, 2) = x_k(2) + h * (-alpha2 * x_k(2) + beta2 * x_k(1) * x_k(2));
    res(k + 1, 3) = x_k(3) + h * u(k);
    
    x_k(1) = res(k + 1, 1);
    x_k(2) = res(k + 1, 2);
    x_k(3) = res(k + 1, 3);
    
    t = t + h;
end


figure(1)
plot(t_arr, res(:, 1), 'r', t_arr, res(:, 2), 'b');
legend('Жертва', 'Хищник');
xlabel('Время');
ylabel('Популяция');
