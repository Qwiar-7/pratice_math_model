function predator_prey
   %параметры
    a2 = 0.01;
    b1 = 0.02;
    b2 = 0.023;
    T1 = 1;
    T2 = 1;
    t_max = 30;
    tspan = [0, t_max];
    x0 = [20, 10, 1];
    h = 0.1;
    n = ceil(t_max / h);
    
    goal = zeros(n + 2) + 5;
    params = [a2, b1, b2, T1, T2]; 
    
    figure(1)
    [time_1, w_1] = euler(params, goal, tspan, x0, n);
    plot(time_1, w_1(:,1), 'b', time_1, w_1(:,2), 'r');
    legend('Жертва', 'Хищник');
    xlabel('Время');
    ylabel('Популяция');
    

   