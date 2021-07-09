function [time, approx] = euler(params, goal, tspan, x0, n)
    alpha2 = params(1);
    beta1 = params(2);
    beta2 = params(3);
    T1 = params(4);
    T2 = params(5);
    time = zeros(1, n+1);
    approx = zeros(n+1, 3);
    h = (tspan(2) - tspan(1)) / n;
    t = tspan(1);
    w = zeros(3, 1);
    u = zeros(n + 1);
    phi = zeros(n + 1);
    w(1) = x0(1);
    w(2) = x0(2);
    w(3) = x0(3);
    phi(1) = (h * beta1 * w(1) * w(2) - w(1) + goal(2) - T2 * w(1) + T2 * goal(1)) / (h * w(1));
    time(1) = t;
    approx(1, 1) = w(1);
    approx(1, 2) = w(2);
    approx(1, 3) = w(3);
    
    for i=1:n
        f1 = w(3) * w(1) - beta1 * w(1) * w(2);
        f2 = -alpha2 * w(2) + beta2 * w(1) * w(2);
        phi(i+1) = (h * beta1 * w(1) * w(2) - w(1) + goal(i + 2) - T2 * w(1) + T2 * goal(i+1)) / (h * w(1));
        u =  (phi(i + 1) + T1 * phi(i) - w(3) - T1 * w(3)) / h;
        
        w(1) = w(1) + h * f1;
        w(2) = w(2) + h * f2;
        w(3) = w(3) + h * u;

        t = tspan(1) + (i * h);
        time(i + 1) = t;
        approx(i+1, 1) = w(1);
        approx(i+1, 2) = w(2);
        approx(i+1, 3) = w(3);
    end
    
    