function value = brent(c)
            x = c(1);
            y = c(2);
            value = (x+10).^2 + (y+10).^2 + exp(- x.^2 - y.^2);
end
