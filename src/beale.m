function value = beale(c)
    X = c(1);
    Y = c(2);
    value = (1.5 - X + (X .* Y)).^2 + ...
             (2.25 - X + (X .* (Y.^2))).^2 + ...
             (2.625 - X + (X .* (Y.^3))).^2;
end