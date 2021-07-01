function value = ackleyNo4(x)
   [m, n] = size(x);
    
   value = zeros(m, 1); 
   
   for i = 1:m
      for j = 1:(n - 1)
            value = value + exp(-0.2) .* sqrt( x(i, j) .^ 2 + x(i, j + 1) .^ 2 ) + 3 * ( cos(2 * x(i, j)) + sin(2 * x(i, j + 1)) );
      end
   end
   
   disp(value);
end