function value = dropWave(c)
           x = c(1);
           y = c(2);
           numeratorcomp = 1 + cos(12 * sqrt(x^2 + y^2));
           denumeratorcom = (0.5 * (x^2 + y^2)) + 2;
           value = -numeratorcomp ./ denumeratorcom;
end

