function main()
    names = ["1) Ackley", "2) Ackley No.2", "3) Ackley No.3", "4) Ackley No.4" ...
        "5) Booth Funcion", "6) Brent Function", "7) Brown Function","8) Drop-Wave Function" ...
        ,"9) Adjiman", "10) Alpnie No.1", "11) Alpine No.2", "12) Bartels Conn", "13) Beale" ...
        ,"14) Bird", "15) Bohachevsky No.1", "16) Bohachevsku No.2" ...
        ,"17) Bukin No.6", "18) Cross-in-Tray", "19) Deckkers-Aarts", "20) Easom" ...
        ,"21) Egg Crate", "22) Exponential", "23) Goldstein-Price", "24) Gramacy & Lee" ...
        ,"25) Sphere", "26) Wolfe", "27) Three-Hump Camel", "28) Sum Squares"
        ];
    domains = [-32,32;-32,32;-32,32;-35,35;  -10,10;-20,0;-1,4;-5.2,5.2;   -1,2;0,10; 0,10;-500,500;    -4.5, 4.5; -2*pi, 2*pi; -100,100; -100, 100; ...
        -15, 3; -10,10; -20,20; -100,100;    -5,5; -1,1; -2,2; -0.5, 2.5;     -5.12,5.12; 0,2;-5,5;-10,10;
    
    ];
    dimentions = [10,2,2,10,2,2,10,2,2,10,10,2,2,2,2,2 ...
    ,2,2,2,2,    2,10,2,1     10,3,2,10
  ];
    
    disp("Choose an Objective Function:");
    
    for i = 1:length(names)
        disp(names(i));
    end
    
    fNo = input("Your Choice: ");

    chosenFunction = getFunction(fNo);
    
    dimentions = dimentions(fNo);
    %nDim = false;
    %if dimentions == -1
    %    dimentions = input("Problem Dimentions: ");
    %    nDim = true;
    %end
    
    population = input("Initial Population: ");
    strongViruses = input("Strong Viruses: ");
    maxIterations = input("Max Iterations: ");
    
    solutions = VOA(population,strongViruses,maxIterations, dimentions, domains(fNo, :), chosenFunction);
    disp(solutions(:, 1:5));
end

function f = getFunction(i)
           switch i
               case 1
                   f = @ackley;
               case 2
                   f = @ackleyNo2;
               case 3
                   f = @ackleyNo3;
               case 4
                   f = @ackleyNo4;    
               case 5
                   f = @booth;
               case 6
                   f = @brent;
               case 7
                   f = @brown;
               case 8
                   f = @dropWave;
               case 9
                   f = @adjiman;
               case 10
                   f = @alpineNo1;
               case 11
                   f = @alpineNo2;
               case 12
                   f = @bartelsConn;
               case 13
                   f = @beale;
               case 14
                   f = @bird;
               case 15
                   f = @bohachevskyNo1;
               case 16
                   f = @bohachevskyNo2;    
               case 17
                   f = @bukinNo6;
               case 18
                   f = @crossInTray;
               case 19
                   f = @deckkersAarts;
               case 20
                   f = @easom;
               case 21
                   f = @eggCrate;
               case 22
                   f = @exponential;
               case 23
                   f = @goldsteinPrice;
               case 24
                   f = @gramacyNlee;
               case 25
                   f = @sphere;
               case 26
                   f = @wolfe;
               case 27
                   f = @threeHumpCamel;
               case 28
                   f = @sumSquares;
           end
end    