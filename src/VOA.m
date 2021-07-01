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
            min = obj.limits(1);
            max = obj.limits(2);
            obj.population = (max-min).*rand(obj.dims, obj.initialPopulation) + min;
            disp("generated population");
        end
        function evaluateFFValue(obj)
            strn = [];

            pop2cell = num2cell(obj.population, 1);
            strn = cellfun(@obj.ff, pop2cell);
            
            obj.strength = strn;
            
            [obj.strength,sortIdx] = sort(obj.strength,'ascend');
            obj.population = obj.population(:, sortIdx);
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
            
            avgVirusIndex = find(obj.strength >= avgPerformance, 1);
            
            highPerfromanceViruses = obj.population(:, avgVirusIndex+1:end);
            lowPerfromanceViruses = obj.population(:, 1:avgVirusIndex);

            remainder = amount - size(lowPerfromanceViruses,2);
            
            if remainder <= 0
                lowPerfromanceViruses(:, booleanMaskGenerator([1, size(lowPerfromanceViruses, 2)], amount)) = [];
            else
                lowPerfromanceViruses = [];
                highPerfromanceViruses(:, booleanMaskGenerator([1, size(highPerfromanceViruses, 2)], remainder)) = [];
            end
            
            obj.population = [highPerfromanceViruses lowPerfromanceViruses];
        end
        function reduceViruses(obj, limit)
            if size(obj.population, 2) > limit
                reductionSize = size(obj.population, 2) - obj.initialPopulation;
                obj.population(:, booleanMaskGenerator([1, size(obj.population, 2)], reductionSize)) = [];
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