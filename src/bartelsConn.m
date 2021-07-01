function value = bartelsConn(c)
    X = c(1);
    Y = c(2);
    value = abs((X .^ 2) + (Y .^ 2) + (X .* Y)) + abs(sin(X)) + abs(cos(Y));
end