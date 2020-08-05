function mp = IEGS_E8G12
    %% 转化参数
    % 用标准单位计算MMBTU
    % conversion_constant;
    % MMBTU
    % 1 BTU - 0.293 Wh
    % 1 MMBTU = 0.293 MWh
    % 1 MMBTU = 28.3 SM3 
    % 1 Sm3 = 10.35 kWh     1 单位天然气 相当于 用10.35度电 价格转化 1元/度电 10元 
    % 1 Sm3 = 0.01035 MWh  
    % [natural gas price ($/mmBtu) * heat rate (mmBtu/MWh)]
    % power price ($/MWh) 
    % One kWh has a heat content of 3,412 Btu. A generator that uses 7,000 Btu to produce one kWh has a conversion efficiency slightly below 50%.
    % eia.gov.sparkprice
    
    mp.convert.P2M = 1 / 0.293;
    mp.convert.G2M = 1 / 28.3;
    mp.convert.PS = 1 / 1;
    % mp.convert.G2M = 1 / 1;
    
    mp.ps.baseMVA = 100;
    %% power system data 
    % 电网线路(MW)
        %f  %t   %B(b.u) % capacity
    mp.ps.branch = [
        1,  2,  0.17,   150;
        1,  5,  0.17,   150;
        2,  3,  0.17,   150;
        2,  5,  0.17,   150;
        3,  4,  0.17,   150;
        3,  6,  0.17,   150;
        4,  7,  0.17,   150;
        4,  8,  0.17,   150;
        5,  6,  0.17,   150;
        6,  7,  0.17,   150;
        7,  8,  0.17,   150;];
    mp.ps.branch(:,4) = mp.ps.branch(:,4) / mp.ps.baseMVA;
    
        
    % 煤电机组(MW)
        %bus %Pmin %Pmax %Ramp(min)  
    mp.ps.coal_gen = [
        1,  50,  155;
        1,  80,    360;
        3,  50,  155;
        3,  80,    360;
    ];
    mp.ps.coal_gen(:,2:3) = mp.ps.coal_gen(:,2:3) / mp.ps.baseMVA;

    % 煤电机组耗费 ($/MW)
        %a*x^2 + b*x + c
        % a + b + c
    mp.ps.coal_cost = [
        0.008	9.1061	0;
        0.0035	11.9340	0;
        0.008	9.1061	0;
        0.1225	17.8123	0;
    ];

    % 燃气机组性能 (MW)
        %bus Pmin Pmax Ramp(min)
    mp.ps.gas_gen = [
        6,  19, 90;
        6,  51, 197;
    ];
    mp.ps.gas_gen(:,2:3) = mp.ps.gas_gen(:,2:3) / mp.ps.baseMVA;

    % 燃气机组效率(%)
    mp.ps.gas_efficiency = [
        0.57;
        0.58;
    ];
    
    % P2G性能 (MW)
        % bus , min, max
    mp.ps.p2g = [
        3,  0,  50;
        8,  0,  50;
    ];
    mp.ps.p2g(:,2:3) = mp.ps.p2g(:,2:3) / mp.ps.baseMVA;
    
    % P2G转换效率,*\mu(%)
    mp.ps.p2g_efficiency = [
        49;
        55
    ];
    
    
    % 电负荷的报价与电力数据（24时段）另一个文件中体现
    % 总负荷x比例分到每个节点，然后报价曲线默认相同
    % [2,4,5,7,8] [0.14, 0.14, 0.24, 0.24, 0.24] 
    
    %% gas system data
    
    % 气网络 (SM3)
        %f  t  Capacity
    mp.gas.passive_pineline = [
        1,  2,  30000;
        2,  3,  30000;
        4,  7,  20000;
        4,  5,  30000;
        5,  6,  30000;
        3,  4,  30000;
        8,  9,  30000;
        9,  10, 20000;
        9,  11, 25000;
        9,  12, 30000;
    ];
    mp.gas.active_pineline = [
        4,  8,  35000;
    ];
    
    % 气源 (SM3)
        % node  min  max
    mp.gas.source = [
        1,  0,  33000;
        4,  0,  34000;
        6,  0,  33000;
        12, 0,  33000;
    ];
    
    % 气源成本 ($/SM3)
    mp.gas.source_cost = [
        0.6;
        0.5;
        0.7;
        0.6;
    ];

    % 燃气机组节点
    mp.gas.gas_gen_node = [
        1;
        5;
    ];
    
    % P2G气节点
    mp.gas.p2g_node = [
        2;
        11;
    ];
    
    % 气负荷
    % 按比例分到每个节点，报价相同。
    % 总负荷x比例分到每个节点，然后报价曲线默认相同
    % [2,4,5,7,8] [0.14, 0.14, 0.24, 0.24, 0.24]
    

    %% 报价相关数据
    % 价格的比较 电的节点电价 / 气的节点气价
    mp.mu_gas2power = [0.4; 0.45; 0.5];  % 3级报价的相关系数
    
    %% 负荷数据
    % 24时间 (MW)
    mp.ps.load = [
        500;480;460;450;455;475;510;580;610;655;685;705;720;725;730;750;758;732;728;710;707;680;600;586;
    ];
    mp.ps.load = mp.ps.load / mp.ps.baseMVA;

    % gas (SM3)
    mp.gas.load = [
        55000;49000;46000;46500;51000;56800;56200;61000;62000;62500;61500;61500;59400;57000;57500;58000;60400;62500;65600;67500;66000;65000;61000;55000;
    ];

    % 负荷中气转电的大小
    % LOAD G2P (MW)
    mp.gas.G2P_load = [
        0,  15,  15, 15;
        0,  15,  15, 15;
        0,  15,  15, 15;
        0,  10, 10, 10;
        0,  10, 10, 10;
    ];
    mp.gas.G2P_load = mp.gas.G2P_load / mp.ps.baseMVA;
    

    %% 归一化
    % 报价归一， 能量归一
    % ps
    mp.ps.branch(:,4) = mp.ps.branch(:,4) * mp.convert.PS;
    mp.ps.coal_gen(:,2:3) = mp.ps.coal_gen(:,2:3) * mp.convert.PS;
    mp.ps.coal_cost(:,1) = mp.ps.coal_cost(:,1) * (1 / mp.convert.PS).^2;
    mp.ps.coal_cost(:,2) = mp.ps.coal_cost(:,2) * (1 / mp.convert.PS);
    mp.ps.gas_gen(:,2:3) = mp.ps.gas_gen(:,2:3) * mp.convert.PS;
    mp.ps.load = mp.ps.load * mp.convert.PS;
    mp.ps.p2g(:,2:3) = mp.ps.p2g(:,2:3) * mp.convert.PS;
    
    % gas
    mp.gas.passive_pineline(:,3) = mp.gas.passive_pineline(:,3) * mp.convert.G2M;
    mp.gas.active_pineline(:,3) = mp.gas.active_pineline(:,3) * mp.convert.G2M;
    mp.gas.source(:,2:3) = mp.gas.source(:,2:3) * mp.convert.G2M;
    mp.gas.source_cost = mp.gas.source_cost * (1 / mp.convert.G2M);
    mp.gas.load = mp.gas.load * mp.convert.G2M;
    mp.gas.G2P_load = mp.gas.G2P_load * mp.convert.PS;
    
    %% 分配到节点
    % 负荷节点 
    % [0.24, 0.24, 0.24, 0.14, 0.14]
    mp.ps.LoadNode = [
        2,  0.24;
        4,  0.24;
        5,  0.24;
        7,  0.14;
        8,  0.14;
    ];

    mp.gas.LoadNode = [
        3,  0.24;
        7,  0.24;
        8,  0.24;
        10, 0.14;
        11, 0.14;
    ];
    
    mp.ps.LoadinNode = mp.ps.LoadNode(:,2) * mp.ps.load';
    mp.gas.LoadinNode = mp.gas.LoadNode(:,2) * mp.gas.load';
    
    %% 报价
    Price = 10 ./ mp.mu_gas2power;
    mp.ps.LoadBidding = BiddingFuncE(Price, mp.ps.LoadinNode, mp.gas.G2P_load);
    mp.gas.LoadBidding = BiddingFuncG(Price, mp.gas.LoadinNode, mp.gas.G2P_load, mp.mu_gas2power);
end


function B = BiddingFuncE(Price, E_Load, G2PofLoad)
    % scatter(mp.ps.LoadBidding{1,1}(1:2:7),mp.ps.LoadBidding{1,1}(2:2:8))
    % 计算报价曲线，返回(x,y)(x1,y1)(x2,y2)的形式
    [XShape, YShape] = size(E_Load);
    B = cell(XShape, YShape);
    X = cell(1,4);   % 存储报价的x轴数据，与分段有关
    X{1} = E_Load - ones(XShape, YShape) .* sum(G2PofLoad(:,2:4),2);
    X{2} = E_Load - ones(XShape, YShape) .* sum(G2PofLoad(:,3:4),2);
    X{3} = E_Load - ones(XShape, YShape) .* G2PofLoad(:,4);
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
end

function B = BiddingFuncG(Price, G_Load, G2PofLoad, mu)
    % 天燃气报价曲线
    % 计算报价曲线，返回(x,y)(x1,y1)(x2,y2)的形式
    G2PofLoad(:,2:4) = G2PofLoad(:,2:4) ./ mu';
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
    
    
    