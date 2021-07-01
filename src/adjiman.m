function value = adjiman(c)
    x = c(1);
    y = c(2);
    value = cos(x)*sin(y) - x/(y^2 + 1);
end