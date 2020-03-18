function mgc = case_4_gas
    % bus type demand pressure
    mgc.bus = [
    [1, 1, 10, 100];
    [2, 1, 10, 100];
    [3, 1, 10, 100];
    [4, 1, 10, 100]];

    % fbus tbus Cbr have_compressor limit
    mgc.branch = [
    [1, 2, 3, 0, 100];
    [2, 3, 3, 1, 100];
    [3, 4, 4.5, 0, 100]];

    % fbus tbus Ccom locate
    mgc.compressors = [
    [2, 3, 0.5, 2]
    ];


    % bus smin smax
    mgc.source = [
    [1, 0, 300]
    ];

    % cost of source
    mgc.cost = [
    [100]
    ];
end
