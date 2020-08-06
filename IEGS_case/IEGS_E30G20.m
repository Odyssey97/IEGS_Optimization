function mp = IEGS_E30G20

    mp.convert.P2G = 96.6; % Mwh 2 sm3
    mp.convert.G2P = 0.01035;  % sm3 2 mwh

    %% -----------------------------------------
      %                   电力系统数据
     %-------------------------------------------------
    % 标幺值
    mp.PS.baseMVA = 100;
    % 负荷节点
    mp.PS.LoadNode = [3;5;7;8;12;16;19;21;24;30];
    % 总负荷
    mp.PS.Load = [302.2,295.3,289.5,285.4,278.8,281.9,281.6,290.8,305.8,328.4,343.4,353.4,360.9,363.5,366,376,380,367,365,355.9,354.4,340.9,300.8,293.8];
    mp.PS.Load = mp.PS.Load .* 1.1; % 比例提高
    % 负荷分配
    mp.PS.LoadFactor = [0.09231,0.12871,0.09552,0.08736,0.09668,0.0894,0.10163,0.1092,0.10309,0.0961];
    % [31.7,44.2,32.8,30,33.2,30.7,34.9,37.5,35.4,33];
    
    % 机组信息
    % 燃气机组 售电 购气 两个角色 社会福利是否要考虑？
    % node max min
    % cost
    % a*x^2 + b*x + c
    % a + b + c
    mp.PS.CoalGen = [
        1   140	  0;
        2   100	  0;
        27	100	  0;
        23	100   0;
        %13  55  0;  % gas
        %22  55  0;  % gas
    ];

    mp.PS.CoalCost =[
        0.00375,    2,  0;
        0.01759,    1.75,   0;
        0.025,  3,  0;
        0.025,  3,  0;
        %0.0625, 1,  0;  % gas
        %0.0625, 1,  0;  % gas
    ];

    mp.PS.GasGen = [
        13  60  0;  % gas
        22  60  0;  % gas
    ];

    mp.PS.GasCost = [
        0.0625, 1,  0;  % gas
        0.0625, 1,  0;  % gas
    ];

    % 燃气机组效率，考虑能量转换
    mp.PS.GFU = [
        0.52;
        0.54;
    ];

    % 线路参数，线路容量
    % f t x rate
    mp.PS.branch = [
            1	2	0.06    130;
            1	3	0.19    130;
            2	4	0.17    65;
            2	5	0.2     130;
            2	6	0.18    65;
            3	4	0.04    130;
            4	6	0.04    90;
            4	12	0.26    65;
            5	7	0.12    70;
            6	7	0.08    130;
            6	8	0.04    40;
            6	9	0.21    65;
            6	10	0.56    40;
            6	28	0.06    32;
            8	28	0.2     32;
            9	11	0.21    65;
            9	10	0.11    65;
            10	20	0.21    32;
            10	17	0.08    32;
            10	21	0.07    32;
            10	22	0.15    32;
            12	13	0.14    65;
            12	14	0.26    32;
            12	15	0.13    32;
            12	16	0.2     32;
            14	15	0.2     32;
            15	18	0.22    32;
            15	23	0.2     32;
            16	17	0.19    32;
            18	19	0.13    32;
            19	20	0.07    32;
            21	22	0.02    32;
            22	24	0.18    32;
            23	24	0.27    32;
            24	25	0.33    32;
            25	26	0.38    32;
            25	27	0.21    32;
            28	27	0.4     65;
            27	29	0.42    32;
            27	30	0.6     32;
            29	30	0.45    32;
            
            
            ];
    %% --------------------------------------------------------
    %                   天然气系统数据
    % ---------------------------------------------------------
    
    % 10^6 sm3
    % ($/SM3)
    mp.GAS.baseSM3 = 10^6;

    % 天然气负荷参数
    mp.GAS.GasNode = [
       1     0         0         77
       2     0        0         77
       3     3.918     30        80
       4     0         0         80
       5     0         0         77
       6     4.034     30        80
       7     5.256     30        80
       8     0         50        66.2
       9     0         0         66.2
       10    6.365     30        66.2
       11    0         0         66.2
       12    2.120     0         66.2
       13    0         0         66.2
       14    0         0         66.2
       15    6.848     0         66.2
       16    15.616    50        66.2
       17    0         0         66.2
       18    0         0         63.0
       19    0.222     0         66.2
       20    1.919     25        66.2;
       ];
    
    mp.GAS.LoadNode = [3,4,6,7,10,12,15,16,19,20];
    mp.GAS.Load = [40000;34000;31000;32500;37000;42800;42200;47000;50000;51500;49500;49500;48400;45000;45500;44000;48400;50500;52600;54500;53000;52000;49000;46000]';   
    mp.GAS.LoadFactor = [0.09231,0.12871,0.09552,0.08736,0.09668,0.0894,0.10163,0.1092,0.10309,0.0961];
    % 天然气网络参数
    %  f t Capacity C_ij^2
    mp.GAS.Pipeline = [
        1   2   0.6  36.2908;
        2   3   0.6  24.1872;
        3   4   0.6  1.3954;
        4   7   0.6  0.2268;
        4   14  0.6  0.6596;
        5   6   0.6  0.1002;
        7   6   0.6  0.1486;
        %8   9    0.6   9.1347;  % 压缩机
        9   10   0.6  1.4623;
        10  11  0.4  1.8269;
        11  12  0.4  0.8638;
        12  13  0.4  0.9070;
        13  14  0.4  7.2562;
        14  15  0.4  3.6281;
        15  16  0.4  1.4512;
        11  17  0.4  0.0514;
        %17   18   0.4   0.064;      % 压缩机       
        18  19  0.4  0.00170; % 改动：0.0017
        19  20  0.4  0.0278;
                    ];
    % 压缩机
    mp.GAS.Compressor = [
        8    9    30   9.1347  % 压缩机支路
        17   18   10   0.064   % 压缩机支路
    ];

    % 天然气供应
    % node min max
    mp.GAS.GasSource = [
        1   0       0.3
        2   0       0.24
        5   0       0.34
        8   0       0.34
        13  0       0.33
        14  0       0.2;
    ];

    % 天然气供应成本
    mp.GAS.Cost = [
        0.06;
        0.061;
        0.054;
        0.081;
        0.071;
        0.075;
    ];

    %% -----------------------------------------------------------
    %                       耦合数据
    %-------------------------------------------------------------
    mp.GAS.GFUNode = [5, 18];   % GFU天然气节点
    mp.GAS.G2P = [0,3,3,3]; % 负荷侧耦合
    mp.GAS.EtaGas = [0.4, 0.45, 0.5];    % 负荷侧报价转换相关数据

    %% --------------------------------------------------------
    %                       标幺化
    % --------------------------------------------------------
    mp.PS.branch(:,4) = mp.PS.branch(:,4) / mp.PS.baseMVA;
    mp.PS.CoalGen(:,2) = mp.PS.CoalGen(:,2) / mp.PS.baseMVA;
    mp.PS.GasGen(:,2) = mp.PS.GasGen(:,2) / mp.PS.baseMVA;
    mp.PS.Load = mp.PS.Load / mp.PS.baseMVA;
    
    % gas
    mp.GAS.Load = mp.GAS.Load / mp.GAS.baseSM3; % 10^6sm3
    mp.GAS.Cost = mp.GAS.Cost * mp.GAS.baseSM3; % $/10^6sm3
    

    %% --------------------------------------------------------
    %                   负荷报价
    % -----------------------------------------------------------------
    
    Price = 3.1 ./ mp.GAS.EtaGas; % 假设价格($/MWh)    3.2 better
    
    % 节点负荷
    LoadInNode_PS = mp.PS.Load .* mp.PS.LoadFactor';
    LoadInNode_GAS = mp.GAS.Load .* mp.GAS.LoadFactor';
    
    % 电报价($/MWh)
    mp.PS.LoadBidding = BiddingPS(Price, LoadInNode_PS, mp.GAS.G2P, mp.PS.baseMVA);

    % Gas
    [mp.GAS.LoadBidding, mp.GAS.Price] = BiddingGAS(Price, LoadInNode_GAS, mp.GAS.G2P, mp.GAS.EtaGas, mp.convert.P2G, mp.GAS.baseSM3);


end

function B = BiddingPS(Price, E_Load, G2PofLoad, baseMVA)
    % 标幺值 * baseMVA (x坐标)
    % scatter(mp.ps.LoadBidding{1,1}(1:2:7),mp.ps.LoadBidding{1,1}(2:2:8))
    % 计算电力报价曲线，返回(x,y)(x1,y1)(x2,y2)的形式
    [XShape, YShape] = size(E_Load);
    E_Load = E_Load .* baseMVA; % 有名值 MW
    B = cell(XShape, YShape);
    X = cell(1,4);   % 存储报价的x轴数据，与分段有关
    X{1} = E_Load - ones(XShape, YShape) .* sum(G2PofLoad(:,2:4),2);    % MW
    X{2} = E_Load - ones(XShape, YShape) .* sum(G2PofLoad(:,3:4),2);    % MW
    X{3} = E_Load - ones(XShape, YShape) .* G2PofLoad(:,4); % MW
    X{4} = E_Load;
    % 计算y
    Y = cell(1,4);  % 存储报价的y轴数据，与分段有关
    Y{1} = X{1} .* Price(1);
    Y{2} = (X{2}-X{1}) .* Price(1) + Y{1};
    Y{3} = (X{3}-X{2}) .* Price(2) + Y{2};
    Y{4} = (X{4}-X{3}) .* Price(3) + Y{3};
    for i = 1:XShape
        for j = 1:YShape
            for k = 1:4
                B{i,j}(1,2*k-1) = X{k}(i,j);
                B{i,j}(1,2*k) = Y{k}(i,j);
            end
        end
    end
    % $/MWh
end

function [B, Price] = BiddingGAS(Price, G_Load, G2PofLoad, mu, conv, baseSM3)
    % 天燃气报价曲线
    % 计算报价曲线，返回(x,y)(x1,y1)(x2,y2)的形式
    
    G2PofLoad(:,2:4) = G2PofLoad(:,2:4) ./ mu * conv;   % ($/sm3)
    G2PofLoad= G2PofLoad / baseSM3; % ($/10^6sm3)
    
    % Price ($/MWh) - > ($/10^6sm3)
    Price  = Price / conv * baseSM3;    % ($/10^6sm3)
    
    [XShape, YShape] = size(G_Load);
    B = cell(XShape, YShape);
    X = cell(1,4);   % 存储报价的x轴数据，与分段有关
    X{1} = G_Load;
    X{2} = G_Load + ones(XShape, YShape) .* G2PofLoad(:,4);
    X{3} = G_Load + ones(XShape, YShape) .* sum(G2PofLoad(:,3:4),2);
    X{4} = G_Load + ones(XShape, YShape) .* sum(G2PofLoad(:,2:4),2);
    % 计算y
    Y = cell(1,4);  % 存储报价的y轴数据，与分段有关
    Y{1} = X{1} .* Price(3);
    Y{2} = (X{2}-X{1}) .* Price(3) + Y{1};
    Y{3} = (X{3}-X{2}) .* Price(2) + Y{2};
    Y{4} = (X{4}-X{3}) .* Price(1) + Y{3};
    for i = 1:XShape
        for j = 1:YShape
            for k = 1:4
                B{i,j}(1,2*k-1) = X{k}(i,j);
                B{i,j}(1,2*k) = Y{k}(i,j);
            end
        end
    end
end
