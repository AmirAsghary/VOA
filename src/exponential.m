function value = exponential(c)
    x2 = c .^2;
    
    value = -exp(-0.5 * sum(x2, 2));
end
