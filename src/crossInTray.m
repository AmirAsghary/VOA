function value = crossInTray(c)
    X = c(1);
    Y = c(2);
    expcomponent = abs(100 - (sqrt(X .^2 + Y .^2) / pi));
    
    value = -0.0001 * ((abs(sin(X) .* sin(Y) .* exp(expcomponent)) + 1) .^ 0.1);
end
