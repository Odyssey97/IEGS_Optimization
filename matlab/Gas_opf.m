% 不含压缩机
gascase = case_9_gas;
nb = size(gascase.bus,1);
nbr = size(gascase.branch,1);
nc = size(gascase.compressors,1);
ns = size(gascase.source,1);
opt = sdpsettings('solver','cplex','verbose',1,'savesolveroutput',1);
opt.cplex.exportmodel = 'model.lp'

pressuremax = gascase.bus(:,4).^2;
pressuremin = zeros(nb,1);
total_source = sum(gascase.source(:,3));

source = sdpvar(ns,1);
flow = sdpvar(nbr,1);
pressure = sdpvar(nb,1);    % x^2


% 关联矩阵
[A,B,w] = relation(gascase);
% 不含压缩机只需要A,w

% 流量平衡约束
constraints_balance = [A*flow + w*source - gascase.bus(:,3) == 0];

% 气源约束
constraints_source = [zeros(ns,1)<= source];

% 流量容量约束
constraints_capacity_l = [-gascase.branch(:,5)-flow<=0];   % linear
constraints_capacity_u = [flow-gascase.branch(:,5)<=0];  % linear

% 流量-气压关系约束,凸约束
% 建立气流方向约束，0-1变量，bin(nbr,2)
% 保证凸松弛，建立中间变量，sdp(nbr,1)
y = binvar(nbr,2);
gama = sdpvar(nbr,1);
constraints_pressure = [zeros(nb,1)<=pressure];
for i = 1:nbr
    f = gascase.branch(i,1);
    t = gascase.branch(i,2);
    constraints_pressure = [constraints_pressure, -(1-y(i,1))*total_source<=flow(i)<=(1-y(i,2))*total_source];
    constraints_pressure = [constraints_pressure, (1-y(i,1))*(pressuremin(f)-pressuremax(t))<=pressure(f)-pressure(t)<=(1-y(i,2))*(pressuremax(f)-pressuremin(t))];
    constraints_pressure = [constraints_pressure, gama(i) >= (pressure(t) - pressure(f)) + (pressuremin(f) - pressuremax(t)) * (y(i, 1) - y(i, 2) + 1)];
    constraints_pressure = [constraints_pressure, gama(i) >= (pressure(f) - pressure(t)) + (pressuremax(f) - pressuremin(t)) * (y(i, 1) - y(i, 2) - 1)];
    constraints_pressure = [constraints_pressure, gama(i) <= (pressure(t) - pressure(f)) + (pressuremax(f) - pressuremin(t)) * (y(i, 1) - y(i, 2) + 1)];
    constraints_pressure = [constraints_pressure, gama(i) <= (pressure(f) - pressure(t)) + (pressuremin(f) - pressuremax(t)) * (y(i, 1) - y(i, 2) - 1)];
    constraints_pressure = [constraints_pressure, gama(i) >= flow(i)^2/gascase.branch(i,3)];
    constraints_pressure = [constraints_pressure, y(i,1)+y(i,2)==1];
end

constraints = constraints_balance + constraints_source + constraints_capacity_l + constraints_capacity_u + constraints_pressure;


F = gascase.cost'*source;

sol = optimize(constraints,F,opt);