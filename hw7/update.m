function [ x, P, vx, vs ] = update( x, P, z, R )
%UPDATE - update sensor estimate
%   incorporate information from new observation (z, R)
%   return
%       x  - updated mean x
%       P  - updated covariance P
%       vx - normalized unit innovations
%       vs - normalized innovation size
    

    % Use dimensionality transformation matrix H
    %   to project down the state dimension
    %   since the observation doesn't come with velocity
    H = [1 0 0 0; 0 1 0 0];

    S = (H * P * H') + R;
    W = (P * H') / S;
    P = P - (W * S * W');
    innovation = (z - H * x);
    x = x + W * innovation;

    v = sqrtm(S) \ innovation;
    vx = innovation ./ sqrt(S([1;4]));
    vs = (v'*v) / length(v);
end