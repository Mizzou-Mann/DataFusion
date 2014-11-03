function [ t, x, P ] = predict( t, x, P, t_new, q )
%TRANSFORM - transform (x, P) at time "t" to time "tz"
%   use basic F transformation respected to delta "t"

    delta_t = (t_new-t);
    F = [1 0 delta_t 0; 0 1 0 delta_t; 0 0 1 0; 0 0 0 1];
    Q = q * diag(ones(4, 1)) * delta_t;
    % (Fx, FPF' + Q)
    t = t_new;
    x = F * x;
    P = (F * P * F') + Q;
end