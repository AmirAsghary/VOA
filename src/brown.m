function value = brown(c)
            n = numel(c);
            value = 0;
            
            for i = 1:(n-1)
                value = value + c(i)^(c(i+1)+1) + c(i+1)^(c(i)+1);
            end    
end