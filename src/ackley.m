function value = ackley(x)
            dims = length(x);
            a = 20;
            b = 0.2;
            c = 2*pi;
            
            value = -a * exp(-b * sqrt(sum(x.^2)/dims)) - exp(-b * sum(arrayfun(@cos, x.*c))) + a + exp(1);
end