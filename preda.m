alpha2 = 0.1;
beta1 = 1;
beta2 = 1;
T1 = 1;
T2 = 1;
 
h = 0.0001;
t_start = 0;
t_end = 50;
n = floor(t_end / h);
t_arr = zeros(1, n + 1);
 
x1_0 = 0.8;
x2_0 = 0.7; 
x3_0 = 0;
 
x1_goal = zeros(1, n + 2);
x1_goal_func = @(k) 50;
for i = 1:n+2
   x1_goal(1, i) = x1_goal_func(i);
end
 
res = zeros(n + 1, 3);
x_k = zeros(1, 3);
x_k(1, 1) = x1_0;
x_k(1, 2) = x2_0;
x_k(1, 3) = x3_0;
 
 
psi = @(k) (h * beta1 * x_k(1,1) * x_k(1,2) - x_k(1, 1) + x1_goal(1,k + 1) - ...
    T2 * x_k(1,1) + T2 * x1_goal(1, k)) / (h * x_k(1, 1));
psi_arr = zeros(n+1, 1);
 
u = @(k) (psi_arr(k + 1) + T1 * psi_arr(k) - x_k(1,3) - T1 * x_k(1,3)) / h;
 
 
t = t_start;
for k = 1:n
    t_arr(k) = t;
    
    psi_arr(k + 1, 1) = (h * beta1 * x_k(1,1) * x_k(1,2) - x_k(1, 1) + x1_goal(1,k + 1) - ...
    T2 * x_k(1,1) + T2 * x1_goal(1, k)) / (h * x_k(1, 1));
    res(k + 1, 1) = x_k(1,1) + h * (x_k(1,3) * x_k(1,1) - beta1 * x_k(1,1) * x_k(1,2));
    res(k + 1, 2) = x_k(1,2) + h * (-alpha2 * x_k(1,2) + beta2 * x_k(1,1) * x_k(1,2));
    res(k + 1, 3) = x_k(1,3) + h * u(k);
    
 
    x_k(1,1) = res(k + 1, 1);
    x_k(1,2) = res(k + 1, 2);
    x_k(1,3) = res(k + 1, 3);
    
    t = t + h;
end
 
 
figure(1)
plot(t_arr, res(:, 1), 'r')
hold on
plot(t_arr, res(:, 2), 'b');
