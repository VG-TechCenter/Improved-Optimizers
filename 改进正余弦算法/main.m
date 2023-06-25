%% 清除环境变量
clear 
clc

%% 参数设置
N = 40;             % 种群规模
Function_name = 'F23';       % 从F1到F23的测试函数的名称（本文中的表1、2、3）
Max_iteration = 501;       % 最大迭代次数
% 加载所选基准函数的详细信息
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

cnt_max = 1;

Curve_SCA = zeros(1, Max_iteration);
Curve_PSO = zeros(1, Max_iteration);
Curve_BAS_SCA = zeros(1, Max_iteration);
Curve_PSCA = zeros(1, Max_iteration);
Curve_ESCA = zeros(1, Max_iteration);

for cnt = 1:cnt_max
    % 初始化种群位置
    X = initialization(N, dim, ub, lb);

    [SCA_Best_score(cnt), SCA_Best_pos(cnt, :), SCA_Curve] = SCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [PSO_Best_score(cnt), PSO_Best_pos(cnt, :), PSO_Curve] = PSO(X, N, Max_iteration, lb, ub, dim, fobj);
    [BAS_SCA_Best_score(cnt), BAS_SCA_Best_pos(cnt, :), BAS_SCA_Curve] = BAS_SCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [PSCA_Best_score(cnt), PSCA_Best_pos(cnt, :), PSCA_Curve] = PSCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [ESCA_Best_score(cnt), ESCA_Best_pos(cnt, :), ESCA_Curve] = ESCA(X, N, Max_iteration, lb, ub, dim, fobj);
    
    Curve_SCA = Curve_SCA+SCA_Curve;
    Curve_PSO = Curve_PSO+PSO_Curve;
    Curve_BAS_SCA = Curve_BAS_SCA+BAS_SCA_Curve;
    Curve_PSCA = Curve_PSCA+PSCA_Curve;
    Curve_ESCA = Curve_ESCA+ESCA_Curve;
    
end

Curve_SCA = Curve_SCA/cnt_max;
Curve_PSO = Curve_PSO/cnt_max;
Curve_BAS_SCA = Curve_BAS_SCA/cnt_max;
Curve_PSCA = Curve_PSCA/cnt_max;
Curve_ESCA = Curve_ESCA/cnt_max;

std_sca = std(SCA_Best_score);
std_pso = std(PSO_Best_score);
std_bas_sca = std(BAS_SCA_Best_score);
std_psca = std(PSCA_Best_score);
std_esca = std(ESCA_Best_score);

best_sca = min(SCA_Best_score);
best_pso = min(PSO_Best_score);
best_bas_sca = min(BAS_SCA_Best_score);
best_psca = min(PSCA_Best_score);
best_esca = min(ESCA_Best_score);

worst_sca = max(SCA_Best_score);
worst_pso = max(PSO_Best_score);
worst_bas_sca = max(BAS_SCA_Best_score);
worst_psca = max(PSCA_Best_score);
worst_esca = max(ESCA_Best_score);

mean_sca = mean(SCA_Best_score);
mean_pso = mean(PSO_Best_score);
mean_bas_sca = mean(BAS_SCA_Best_score);
mean_psca = mean(PSCA_Best_score);
mean_esca = mean(ESCA_Best_score);

%% 画图
% 1、画出所选基准函数的三维立体图形
figure;
func_plot(Function_name);
title(Function_name)
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

% 2、画出目标函数值变化曲线图
figure;
t = 1:Max_iteration;
semilogy(t, Curve_SCA, 'go-', t, Curve_PSO, 'mx-', t, Curve_BAS_SCA, 'rd-', t, Curve_PSCA, 'ks-', t, Curve_ESCA, 'bv-', ...
'linewidth', 1.5, 'markersize', 8, 'MarkerIndices', 1:50:Max_iteration);
title(Function_name)
xlabel('迭代次数');
ylabel('目标函数值(Log)');
axis tight
grid on
box on
legend('SCA', 'PSO', 'BAS-SCA', 'PSCA', 'ESCA');

%% 显示结果
disp(['函数：', num2str(Function_name)]);
disp(['SCA：最优值: ', num2str(best_sca), ',最差值:', num2str(worst_sca), ',平均值:', num2str(mean_sca), ',标准差:', num2str(std_sca)]);
disp(['PSO：最优值: ', num2str(best_pso), ',最差值:', num2str(worst_pso), ',平均值:', num2str(mean_pso), ',标准差:', num2str(std_pso)]);
disp(['BAS-SCA：最优值: ', num2str(best_bas_sca), ',最差值:', num2str(worst_bas_sca), ',平均值:', num2str(mean_bas_sca), ',标准差:', num2str(std_bas_sca)]);
disp(['PSCA：最优值: ', num2str(best_psca), ',最差值:', num2str(worst_psca), ',平均值:', num2str(mean_psca), ',标准差:', num2str(std_psca)]);
disp(['ESCA：最优值: ', num2str(best_esca), ',最差值:', num2str(worst_esca), ',平均值:', num2str(mean_esca), ',标准差:', num2str(std_esca)]);


