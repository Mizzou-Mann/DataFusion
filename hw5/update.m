function [ x, P, v ] = update( x, P, z, R, H )
%update - update sensor estimate
%   incorporate information from new observation (z, R, H)

    S = (H * P * H') + R;
    W = (P * H') / S;
    P = P - (W * S * W');
    innovation = (z - H * x);
    x = x + W * innovation;
    v = sqrtm(S) \ innovation;
end