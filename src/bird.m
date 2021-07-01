function value = bird(c)
    X = c(1);
    Y = c(2);
    value = sin(X) .* exp((1 - cos(Y)).^2) + ... 
        cos(Y) .* exp((1 - sin(X)) .^ 2) + ...
        (X - Y) .^ 2;
end