function [ t, x, P ] = predict( t, x, P, t_new, q )
%PREDICT - constant velocity precition for (x, P) at time "t_new"
%   F : constant velocity transformation matrix respected to "delta_t" 
%   Q : process noice covariance matrix to ensure that P is conservative

    delta_t = (t_new-t);
    F = [1 0 delta_t 0; 0 1 0 delta_t; 0 0 1 0; 0 0 0 1];
    Q = q * [1 0 0 0; 0 1 0 0; 0 0 0 0; 0 0 0 0] * delta_t; % velocity should not be inflated
    % (Fx, FPF' + Q)
    t = t_new;
    x = F * x;
    P = (F * P * F') + Q;
end