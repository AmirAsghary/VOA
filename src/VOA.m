classdef VOA < handle
    properties
        initialPopulation = 0;
        numberOfStrongViruses = 0;
        strongVirusGrowth= 0;
        commonVirusGrowth= 0;
        maxSolutions = 0;
        generations = 0;
        limits = [];
        population = [];
        strength = [];
        ff = {};
        dims = 0;
        nDim = false;
    end
    
    methods
        function obj = VOA(initPop, strongV, maxSolutions, dims, limits, FF, nDim)
            obj.initialPopulation = initPop;
            obj.numberOfStrongViruses = strongV;
            obj.strongVirusGrowth = 1;
            obj.commonVirusGrowth = 1;
            obj.maxSolutions = maxSolutions;
            obj.generations = 0;
            obj.dims = dims;
            obj.limits = limits;
            obj.ff = FF;
            obj.nDim = nDim;
            
            obj.population = [];
            obj.strength = [];
        end
        
        function generatePopulation(obj)
            for i = 1:obj.initialPopulation
                virus = [];
                for d = 1:obj.dims
                    min = obj.limits(1);
                    max = obj.limits(2);
                    virus(end+1) = (max-min).*rand(1,1) + min;
                end
                obj.population = [obj.population transpose(virus)];
            end
            
            disp("generated population");
            %disp(obj.population);
            %disp("");
        end
        function evaluateFFValue(obj)
            strn = [];
            
            for i= 1:size(obj.population,2)
               if obj.nDim == true
                  strn(i) = obj.ff(obj.population(:, i), obj.dims); 
               else
                  strn(i) = obj.ff(obj.population(:, i)); 
               end
            end
            
            obj.strength = strn;
            
            [obj.strength,sortIdx] = sort(obj.strength,'ascend');
            %disp(sortIdx);
            obj.population = obj.population(:, sortIdx);
             
            %disp("sorted population by FF val");
            %disp(obj.population);
            %disp("FF val");
            %disp(obj.strength);
            %disp("");
        end 
        function popPerformance = evaluatePopPerformance(obj)
            popPerformance = mean(obj.strength);
        end
        function intensifyExploitation(obj)
           obj.strongVirusGrowth = obj.strongVirusGrowth + 1;
        end
        function randNum = randomInRange(obj, thisPos, class)
            if class == "strong"
                intensity = obj.strongVirusGrowth;
            else
                intensity = obj.commonVirusGrowth;
            end
            
            min = obj.limits(1);
            max = obj.limits(2);
            randNum = thisPos + ((max-min).*rand(1,1) + min)/intensity * thisPos;
            while (randNum < min) || (randNum > max)
                randNum = thisPos + ((max-min).*rand(1,1) + min)/intensity * thisPos;
            end   
        end    
        function newViruses = replicate(obj, viruses, class)
            newViruses = [];
            
            if class == "strong"
                for i= 1:size(viruses,2)
                    N1 = [];
                    for d = 1:obj.dims
                        N1(end+1) = obj.randomInRange(viruses(d, i), "strong");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N1)];

                    N2 = [];
                    for d = 1:obj.dims
                        N2(end+1) = obj.randomInRange(viruses(d, i), "strong");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N2)];
                    
                    N3 = [];
                    for d = 1:obj.dims
                        N3(end+1) = obj.randomInRange(viruses(d, i), "strong");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N3)];
                    
                    N4 = [];
                    for d = 1:obj.dims
                        N4(end+1) = obj.randomInRange(viruses(d, i), "strong");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N4)];
                end    
            else
                for i= 1:size(viruses,2)
                    N1 = [];
                    for d = 1:obj.dims
                        N1(end+1) = obj.randomInRange(viruses(d, i), "common");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N1)];

                    N2 = [];
                    for d = 1:obj.dims
                        N2(end+1) = obj.randomInRange(viruses(d, i), "common");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N2)];
                    
                    N3 = [];
                    for d = 1:obj.dims
                        N3(end+1) = obj.randomInRange(viruses(d, i), "common");
                    end
                    newViruses = [newViruses(:,1:end) transpose(N3)];
                end   
            end    
  
        end
        function combine(obj, newPop)
            obj.population = [obj.population newPop];
        end
        function attackViruses(obj)
            min = 0;
            max = size(obj.population,2) - obj.numberOfStrongViruses;
            amount = int8( (max-min).*rand(1,1) + min );
            
            avgPerformance = obj.evaluatePopPerformance();
            avgVirusIndex = 0;
            for i= 1:length(obj.strength)
                if obj.strength(i) >= avgPerformance
                    avgVirusIndex = i;
                    break;
                end
            end
            highPerfromanceViruses = obj.population(:, i+1:end);
            lowPerfromanceViruses = obj.population(:, 1:i);
            
            %disp("amount");
            %disp(amount);
            %disp("max low");
            %disp(size(lowPerfromanceViruses,2));
            %disp(lowPerfromanceViruses);
            
            
            remainder = amount - size(lowPerfromanceViruses,2);
            
            %disp("remainder");
            %disp(remainder);
            if remainder <= 0
                for i= 1:amount
                    tbk = floor((size(lowPerfromanceViruses,2)-1).*rand(1,1) + 1); % tbk = to be killed index :)
                    lowPerfromanceViruses(:,tbk) = [];
                end
            else
                lowPerfromanceViruses = [];
                for i= 1:remainder
                    tbk = floor((size(highPerfromanceViruses,2)-1).*rand(1,1) + 1); % tbk = to be killed index :)
                    highPerfromanceViruses(:,tbk) = [];
                end
            end
            
            obj.population = [highPerfromanceViruses lowPerfromanceViruses];
        end
        function reduceViruses(obj, limit)
            while size(obj.population, 2) > limit
                tbk = floor((size(obj.population, 2)-1).*rand(1,1) + 1); % to be killed
                obj.population(:,tbk) = [];
            end
        end
        function isStoppable = isStoppable(obj)
            obj.generations = obj.generations + 1;
            disp(obj.generations);
            isStoppable = false;
            
            if obj.generations >= obj.maxSolutions
                isStoppable = true;
            end
        end
        
        function solutions = start(obj)
            solutions = [];
            
            obj.generatePopulation();
            obj.evaluateFFValue();
            
            while true
                performance = obj.evaluatePopPerformance();
                %disp("first performance");
                %disp(performance);
            
                % classification
                StrongViruses = obj.population(:, 1:obj.numberOfStrongViruses);
                CommonViruses = obj.population(:, obj.numberOfStrongViruses+1:end);
                
                % replication
                newStrongViruses = obj.replicate(StrongViruses, "strong");
                newCommonViruses = obj.replicate(CommonViruses, "common");
                
                % combination and ranking
                newViruses = [newStrongViruses newCommonViruses];
                obj.combine(newViruses);
                obj.evaluateFFValue();
                
                % performance check (with a margin of error: 1)
                newPerformance = obj.evaluatePopPerformance();
                %disp("last performance");
                %disp(newPerformance);
                if newPerformance -1 > performance
                    obj.intensifyExploitation();
                end
                
                % apply anti-virus
                obj.attackViruses();
                obj.evaluateFFValue();
                
                % reduction
                if size(obj.population, 2) > 1000
                    obj.reduceViruses(1000);
                end
                
                % check stopping criterion
                if obj.isStoppable()
                    break;
                end
                
            end
            disp(obj.strength(:, 1:5));
            solutions = obj.population;
        end    
    end
end            