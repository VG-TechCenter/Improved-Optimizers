function [fitnessgbest, gbest, zz] = PSO(X, N, maxgen, lb, ub, dim, fobj)

%% 参数初始化
c1 = 2.5;                           % 社会认知参数
c2 = 2.5;                           % 自我认知参数
Vmax = 2;                      % 最大速度
Vmin = -2;                      % 最小速度
Wmax = 0.9; Wmin = 0.4;
V = rand(N, dim).*(Vmax-Vmin)+Vmin;
for i = 1:N
    fitness(i) = fobj(X(i, :));
end
%% 
[bestfitness, bestindex] = min(fitness);
gbest = X(bestindex, :);                      % 群体最优极值
zbest = X;                         % 个体最优极值
fitnessgbest = bestfitness;     % 种群最优适应度值
fitnesszbest = fitness;           % 个体最优适应度值

%% 初始结果显示
disp(['初始位置：' , num2str(gbest)]);
disp(['初始函数值：', num2str(fitnessgbest)]);

%% 迭代寻优
for i = 1:maxgen
    W = Wmax-((Wmax-Wmin)/maxgen)*i;
    for j=1:N
        % 速度更新
        V(j, :) = W*V(j, :) + c1*rand*(zbest(j, :) - X(j, :)) + c2*rand*(gbest - X(j, :));
        V(j,find(V(j,:)>Vmax)) = Vmax;
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        % 种群更新
        X(j,:) = X(j,:) + V(j,:);
        X(j,find(X(j,:)>ub)) = ub;
        X(j,find(X(j,:)<lb)) = lb;
        
        % 适应度值更新
        fitness(j) = fobj(X(j,:));
    end
    %% 个体和群体极值更新
    for j = 1:N
        % 个体最优更新
        if fitness(j) < fitnesszbest(j)
            zbest(j,:) = X(j,:);
            fitnesszbest(j) = fitness(j);
        end
        
        % 群体最优更新
        if fitness(j) < fitnessgbest
            gbest = X(j,:);
            fitnessgbest = fitness(j);
        end
    end
    %% 每一代群体最优值存入zz数组
    zz(i) = fitnessgbest;
    
    disp(['PSO: At iteration ', num2str(i), ' ,the best fitness is ', num2str(zz(i))]);
end
% %% 最终结果显示
% disp(['最终位置：' , num2str(gbest)]);
% disp(['最终函数值：', num2str(zz(end))]);
% %% 绘图
% figure;
% plot(zz, 'r', 'lineWidth', 2);          %  画出迭代图
% xlabel('迭代次数', 'fontsize', 12);
% ylabel('目标函数值', 'fontsize', 12);
