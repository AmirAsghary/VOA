function solutions = VOA(initPop, strongVCount, maxSolutions, dims, limits, FF)
             strongVirusGrowth = 1;
             commonVirusGrowth = 1;
             generations = 0;
            
             population = [];
             strength = [];
            
            solutions = [];
            tic;
            
            population = generatePopulation(limits(1), limits(2), dims, initPop);
            [s, p] = evaluateFFValue(population, FF);
            population = p;
            strength = s;
            
            while true
                performance = evaluatePopPerformance(strength);
            
                % classification
                StrongViruses = population(:, 1:strongVCount);
                CommonViruses = population(:, strongVCount+1:end);
                
                % replication
                newStrongViruses = replicate(StrongViruses, "strong", limits(1), limits(2), strongVirusGrowth, dims);
                newCommonViruses = replicate(CommonViruses, "common", limits(1), limits(2), commonVirusGrowth, dims);
                
                % combination and ranking
                newViruses = [newStrongViruses newCommonViruses];
                population = combine(population, newViruses);
                [s, p] = evaluateFFValue(population, FF);
                population = p;
                strength = s;
                
                % performance check (with a margin of error: 1)
                newPerformance = evaluatePopPerformance(strength);
                if newPerformance -1 > performance
                    strongVirusGrowth = intensifyExploitation(strongVirusGrowth);
                end
                
                % apply anti-virus
                newPop = attackViruses(strongVCount, population, strength);
                population = newPop;
                [s, p] = evaluateFFValue(population, FF);
                population = p;
                strength = s;
                
                % reduction
                if size(population, 2) > 1000
                    newPop = reduceViruses(1000, population, initPop);
                    population = newPop;
                end
                
                % check stopping criterion
                [gen, is_stoppable] = isStoppable(generations, maxSolutions);
                generations = gen;
                if is_stoppable == true
                    break;
                end
                
            end
            disp(strength(:, 1:5));
            solutions = population;
            
            toc;
end    
   

function population = generatePopulation(min, max, dims, initPop)
	population = (max-min).*rand(dims, initPop) + min;
	disp("generated population");
end

function [strength, pop] = evaluateFFValue(pop, ff)
	pop2cell = num2cell(pop, 1);
	strength = cellfun(ff, pop2cell);
            
	[strength,sortIdx] = sort(strength,'ascend');
	pop = pop(:, sortIdx);
end 

function popPerformance = evaluatePopPerformance(strength)
    popPerformance = mean(strength);
end

function newGrowth = intensifyExploitation(growth)
    newGrowth = growth + 1;
end

function randNum = randomInRange(min, max, intensity, thisPos)
	randNum = thisPos + ((max-min).*rand(1,1) + min)/intensity * thisPos;
	while (randNum < min) || (randNum > max)
        randNum = thisPos + ((max-thisPos-min).*rand(1,1) + min)/intensity * thisPos;
	end   
end

function newViruses = replicate(viruses, class, min, max, intensity, dims)
            newViruses = [];
            if class == "strong"
                for i= 1:size(viruses,2)
                    N1 = [];
                    for d = 1:dims
                        N1(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N1)];

                    N2 = [];
                    for d = 1:dims
                        N2(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N2)];
                    
                    N3 = [];
                    for d = 1:dims
                        N3(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N3)];
                    
                    N4 = [];
                    for d = 1:dims
                        N4(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N4)];
                end    
            else
                for i= 1:size(viruses,2)
                    
                    N1 = [];
                    for d = 1:dims
                        N1(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N1)];
                    
                    N2 = [];
                    for d = 1:dims
                        N2(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N2)];
                    
                    N3 = [];
                    for d = 1:dims
                        N3(end+1) = randomInRange(min, max, intensity, viruses(d, i));
                    end
                    newViruses = [newViruses(:,1:end) transpose(N3)];
                end   
            end    
  
end

function combinedPop = combine(oldPop, newPop)
	combinedPop = [oldPop newPop];
end

function newPop = attackViruses(strongCount, pop, strength)
            min = 0;
            max = size(pop,2) - strongCount;
            amount = int8( (max-min).*rand(1,1) + min );
            
            avgPerformance = evaluatePopPerformance(strength);
            
            avgVirusIndex = find(strength >= avgPerformance, 1);
            
            highPerfromanceViruses = pop(:, avgVirusIndex+1:end);
            lowPerfromanceViruses = pop(:, 1:avgVirusIndex);

            remainder = amount - size(lowPerfromanceViruses,2);
            
            if remainder <= 0
                lowPerfromanceViruses(:, booleanMaskGenerator([1, size(lowPerfromanceViruses, 2)], amount)) = [];
            else
                lowPerfromanceViruses = [];
                highPerfromanceViruses(:, booleanMaskGenerator([1, size(highPerfromanceViruses, 2)], remainder)) = [];
            end
            
            newPop = [highPerfromanceViruses lowPerfromanceViruses];
end

function newPop = reduceViruses(limit, pop, initPopCount)
    newPop = pop;
    
    if size(newPop,2) > limit
        newPop = newPop(:, 1:initPopCount);
    end
    
    % this is waaaay too slow...
    %if size(newPop, 2) > limit
    %    reductionSize = size(newPop, 2) - initPopCount;
    %    newPop(:, booleanMaskGenerator([1, size(newPop, 2)], reductionSize)) = [];
    %end
end

 function [newGen, isStoppable] = isStoppable(gen, maxGen)
    newGen = gen + 1;
    
    isStoppable = false;
            
    if newGen >= maxGen
        isStoppable = true;
    end
end
        