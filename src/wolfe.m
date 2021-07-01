function value = wolfe(c)
   X = c(1);
   Y = c(2);
   Z = c(3);
   
   value = (4/3)*(((X .^ 2 + Y .^ 2) - (X .* Y)).^(0.75)) + Z;
end
