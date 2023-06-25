function [fitnessgbest, gbest, Curve] = BAS_SCA(X, N, maxgen, lb, ub, dim, fobj)

%% BAS-SCA参数
alpha = 0.05;
c = 5;
s0 = 0.9; s1 = 0.4;
for i = 1:N    %为种群规模30
    fitness(i) = fobj(X(i, :));
end
% 初始最优
[bestfitness, bestindex] = min(fitness);
gbest = X(bestindex, :);              % 群体最优极值
fitnessgbest = bestfitness;         % 种群最优适应度值

%% 迭代寻优
for t = 1:maxgen   %为最大迭代次数500
    %%  递减参数r1的改变
    r1 = alpha*exp(cos(pi*t/(maxgen+t)));
    %% 引入自适应权重
    w = 0.2*cos(pi/2*(1-t/maxgen));
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
                X(i, j) = w*X(i, j)+(r1*sin(r2)*abs(r3*gbest(j)-X(i, j)));
            else
                % Eq. (3.2)
                X(i, j) = w*X(i, j)+(r1*cos(r2)*abs(r3*gbest(j)-X(i, j)));
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
    %%  变步长搜索机制
    delta = s1*(s0/s1)^(maxgen/(maxgen+10*t));
    d0 = delta/c;
    dir = rands(1, dim);%dim=inputnum*hiddenLayerSize+outputnum*hiddenLayerSize+hiddenLayerSize+outputnum;
    dir = dir/(eps+norm(dir)); %归一化
    Xleft = gbest+dir*d0/2;
    Xright = gbest-dir*d0/2;
    % 边界处理
    Xleft = boundcheck(Xleft, lb, ub);
    Xright = boundcheck(Xright, lb, ub);
    fright = fobj(Xright);
    fleft = fobj(Xleft);
    new_gbest = gbest-delta*dir*sign(fleft-fright);
    % 边界处理
    new_gbest = boundcheck(new_gbest, lb, ub);
    % 贪婪选择
    if fobj(new_gbest) < fitnessgbest
        fitnessgbest = fobj(new_gbest);
        gbest = new_gbest;
    end
    % 记录每代最优解
    Curve(t) = fitnessgbest;
    % 显示迭代信息
    display(['BAS-SCA:At iteration ', num2str(t), ' the best fitness is ', num2str(Curve(t))]);
end

%% 边界处理函数
function x = boundcheck(x, lb, ub)
x = min(x, ub);
x = max(x, lb);
end

end

