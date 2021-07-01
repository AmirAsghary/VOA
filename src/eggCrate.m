function value = eggCrate(c)
    X = c(1);
    Y = c(2);
    
    value = X.^2 + Y.^2 + (25 * (sin(X).^2 + sin(Y).^2));
end


