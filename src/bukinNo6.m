function value = bukinNo6(c)
    X = c(1);
    X2 = X .^ 2;
    Y = c(2);
    value = 100 * sqrt(abs(Y - 0.01 * X2)) + 0.01 * abs(X  + 10);
end