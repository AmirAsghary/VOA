function value = ackleyNo3(c)
    x = c(1);
    y = c(2);
    value = -200*exp( -0.02 * sqrt(x^2 + y^2) ) + 5*exp(cos(3*x) + sin(3*y));
end