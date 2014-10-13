function [ x, P, v ] = update( x, P, z, R, H )
%update - update sensor estimate
%   incorporate information from new observation (z, R, H)

    S = (H * P * H') + R;
    W = (P * H') / S;
    P = P - (W * S * W');
    v = (z - H * x);
    x = x + W * v;
    v = sqrtm(S) \ v;
end

