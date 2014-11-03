function [ t, x, P ] = transform( t, x, P, tz )
%TRANSFORM - transform (x, P) at time "t" to time "tz"
%   use basic F transformation respected to delta "t"

    delta_t = (tz-t);
    F = [1 0 delta_t 0; 0 1 0 delta_t; 0 0 1 0; 0 0 0 1];
    % (Fx, FPF')
    t = tz;
    x = F * x;
    P = F * P * F';
end