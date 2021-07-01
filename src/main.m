function main()
    OF = ObjectiveFunctions();
    fNames = OF.names;
    fDomains = OF.domains;
    fDimentions = OF.dimentions;
    
    disp("Choose an Objective Function:");
    
    for i = 1:fNames.length
        disp(fNames(i));
    end
    
    fNo = input("Your Choice: ");

    chosenFunction = @ackleyNo2;
    
    dimentions = fDimentions(fNo);
    nDim = false;
    if dimentions == -1
        dimentions = input("Problem Dimentions: ");
        nDim = true;
    end
    
    population = input("Initial Population: ");
    strongViruses = input("Strong Viruses: ");
    maxIterations = input("Max Iterations: ");
    
    solutions = VOA(population,strongViruses,maxIterations, dimentions, fDomains(fNo, :), chosenFunction, nDim);
    disp(solutions(:, 1:5));
end
