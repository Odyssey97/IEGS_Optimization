function mgc = case_9_gas
    % bus type demand pressure
    mgc.bus = [
    [1, 1, 10, 100];
    [2, 1, 10, 100];
    [3, 1, 10, 100];
    [4, 1, 10, 100];
    [5, 1, 10, 100];
    [6, 1, 10, 100];
    [7, 1, 10, 100];
    [8, 1, 10, 100];
    [9, 2, 10, 100]];

    % fbus tbus Cbr have_compressor limit
    mgc.branch = [
    [1, 2, 3, 0, 100];
    [1, 5, 3, 0, 100];
    [2, 3, 4.5, 0, 100];
    [2, 6, 3, 0, 100];
    [4, 5, 4.5, 0, 100];
    [5, 7, 3, 0, 100];
    [6, 8, 3, 0, 100];
    [7, 8, 3, 0, 100];
    [8, 9, 3, 1, 100]
    ];

    % fbus tbus Ccom locate 
    mgc.compressors = [
    [8, 9, 0.5, 9]
    ];


    % bus smin smax
    mgc.source = [
    [3, 0, 200];
    [4, 0, 200]
    ];

    % cost of source
    mgc.cost = [
    [100];
    [200]
    ];
end
