function value = bohachevskyNo2(c)
    X = c(1);
    Y = c(2);
    value = (X .^ 2) + (2 * Y .^ 2) - (0.3 * cos(3 * pi * X)) .* (cos(4 * pi * Y)) + 0.3;
end