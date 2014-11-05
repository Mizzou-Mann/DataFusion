function [ x, P, vx ] = update( x, P, z, R )
%UPDATE - update sensor estimate
%   incorporate information from new observation (z, R)
%   returns
%       x  - updated mean x
%       P  - updated covariance P
%       vx - normalized unit innovations
    

    % Use dimensionality transformation matrix H
    %   to project down the state dimension
    %   since the observation doesn't come with velocity
    H = eye(2, 4);

    S = (H * P * H') + R;
    W = (P * H') / S;
    P = P - (W * S * W');
    innovation = (z - H * x);
    x = x + W * innovation;

    vx = innovation ./ sqrt(S([1;4]));
end