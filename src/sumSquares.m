function value = sumSquares(c)
   [m, n] = size(c);
   x2 = c .^2;
   I = repmat(1:n, m, 1);
   value = sum( I .* x2, 2);
end


