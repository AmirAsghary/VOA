function value = easom(c)
    X = c(1);
    Y = c(2);
    
    value = -cos(X) .* cos(Y) .* exp(-( ((X - pi) .^2) + ((Y - pi) .^ 2)) );
end
