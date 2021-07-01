function value = threeHumpCamel(c)
   X = c(1);
   Y = c(2);
   
   value = (2 * X .^ 2) - (1.05 * (X .^ 4)) + ((X .^ 6) / 6) + X .* Y + Y .^2;
end

