function [fitnessgbest, gbest, Curve] = PSCA(X, N, maxgen, lb, ub, dim, fobj)
%% 改进的抛物线函数正余弦算法(Parabolic Sine Cosine Algorithm, PSCA)
%% PSCA参数
for i = 1:N
    fitness(i) = fobj(X(i, :));
end
% 初始最优
[bestfitness, bestindex] = min(fitness);
gbest = X(bestindex, :);              % 群体最优极值
fitnessgbest = bestfitness;         % 种群最优适应度值

%% 迭代寻优
for t = 1:maxgen
    % Eq. (3.4)
    a = 2;
    r1 = a*(1-t/maxgen)^2;    % r1从a非线性递减到0
    % 更新个体位置
    for i = 1:N
        for j = 1:dim 
            % 由Eq. (3.3)更新r2,r3,r4
            r2 = (2*pi)*rand();
            r3 = 2*rand;
            r4 = rand();
            
            % Eq. (3.3)
            if r4 < 0.5
                % Eq. (3.1)
                X(i, j) =  X(i, j)+(r1*sin(r2)*abs(r3*gbest(j)-X(i, j)));
            else
                % Eq. (3.2)
                X(i, j) = X(i, j)+(r1*cos(r2)*abs(r3*gbest(j)-X(i, j)));
            end
        end
    end
    
    for i = 1:N
        % 边界处理
        Flag4ub = X(i, :) > ub;
        Flag4lb = X(i, :) < lb;
        X(i, :) = (X(i, :).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        % 更新适应度值
        fitness(i) = fobj(X(i, :));
        
        % 更新最优解
        if fitness(i) < fitnessgbest
            gbest = X(i, :);
            fitnessgbest = fitness(i);
        end
    end
   
    % 记录每代最优解
    Curve(t) = fitnessgbest;
    % 显示迭代信息
    display(['PSCA:At iteration ', num2str(t), ' the best fitness is ', num2str(Curve(t))]);
end

