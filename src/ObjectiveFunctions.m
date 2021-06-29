classdef ObjectiveFunctions < handle
  
    properties
        names = [
            "1) Ackley N Dimentional", "2) Ackley No.2","3) Bohachevsky No.1","4) Booth Funcion", "5) Brent Function","6) Brown Function","7) Drop-Wave Function"
        ];
        domains = [
            -32,32; -100,100; -10,10; -20,0; -1,4; -5.2,5.2;
        ];
        dimentions = [
            -1,2,2,2,2,4,2
        ];
    end    
    
    methods
        function value = ackley(obj, x, dims)
            a = 20;
            b = 0.2;
            c = 2*pi;
            
            value = -a * exp(-b * sqrt(sum(x.^2)/dims)) - exp(-b * sum(arrayfun(@cos, x.*c))) + a + exp(1);
        end
        function value = ackleyNo2(obj, c)
           x = c(1);
           y = c(2);
           value = -200 * exp( -0.02 * sqrt(x^2 + y^2) );
        end
        function value = bohachevskyNo1(obj, c)
            x = c(1);
            y = c(2);
            value = (x^2) + (2*y^2) - 0.3*cos(3*pi*x) - 0.4*cos(4*pi*y) + 0.7;
        end
        function value = booth(obj, c)
           x = c(1);
           y = c(2);
           value = (x+2*y-7)^2 + (2*x+y-5)^2;
        end    
        function value = brent(obj, c)
            x = c(1);
            y = c(2);
            value = (x + 2*y - 7)^2 + (2*x + y - 5)^2;
        end
        function value = brown(obj, c)
            n = numel(c);
            value = 0;
            
            for i = 1:(n-1)
                value = value + c(i)^(c(i+1)+1) + c(i+1)^(c(i)+1);
            end    
        end
        function value = dropWave(obj, c)
           x = c(1);
           y = c(2);
           numeratorcomp = 1 + cos(12 * sqrt(x^2 + y^2));
           denumeratorcom = (0.5 * (x^2 + y^2)) + 2;
           value = -numeratorcomp ./ denumeratorcom;
        end
        
        function f = getFunction(obj, i)
           switch i
               case 1
                   f = @obj.ackley;
               case 2
                   f = @obj.ackleyNo2;
               case 3
                   f = @obj.bohachevskyNo1;
               case 4
                   f = @obj.booth;
               case 5
                   f = @obj.brent;
               case 6
                   f = @obj.brown;
               case 7
                   f = @obj.dropWave;
           end         
        end    
    end
end    