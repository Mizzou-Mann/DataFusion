function [ x, P, v ] = update( x, P, z, R )
%UPDATE - update sensor estimate
%   incorporate information from new observation (tz, z, R)
    
    H = [1 0 0 0; 0 1 0 0]; % dimensionality transformation matrix H
    S = (H * P * H') + R;
    W = (P * H') / S;
    P = P - (W * S * W');
    innovation = (z - H * x);
    x = x + W * innovation;
    v = innovation ./ sqrt(S([1 4]));
%     v = sqrtm(S) \ innovation
%     v_x = innovation(1) / sqrt(S(1,1))
end