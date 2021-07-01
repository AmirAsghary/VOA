function value = deckkersAarts(c)
    X = c(1);
    Y = c(2);
    
    value = (100000 * X.^2) + Y.^2 + - (X.^2 + Y.^2).^2 + (10^-5) * (X.^2 + Y.^2 ) .^4;
end
