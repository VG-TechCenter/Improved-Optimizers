close all
clear all 
clc

SearchAgents_no=40; % 种群数目
N=SearchAgents_no;
Function_name='F15'; % 测试函数

Max_iteration=500;  % 迭代次数
%Max_iter=Max_iteration;

% 加载适应度函数
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
cnt_max =1;
for cnt = 1:cnt_max
    %[ABest_scoreChimp(cnt),ABest_posChimp,Chimp_curve]=Chimp(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    %[ABest_scoreChimp_2(cnt),ABest_posChimp_2,Chimp_curve_SLWChoA]=SLWChoA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    [PSO_gBestScore(cnt),PSO_gBest,PSO_cg_curve]=PSO(N,Max_iteration,lb,ub,dim,fobj);
    [TACPSO_gBestScore(cnt),TACPSO_gBest,TACPSO_cg_curve]=TACPSO(N,Max_iteration,lb,ub,dim,fobj);
    [MPSO_gBestScore(cnt),MPSO_gBest,MPSO_cg_curve]=MPSO(N,Max_iteration,lb,ub,dim,fobj);
    %[IPSO_gBestScore(cnt),HHO_gBest,HHO_cg_curve]=HHO(N,Max_iteration,lb,ub,dim,fobj);
    %[AO_gBestScore(cnt),AO_gBest,AO_cg_curve]=AO(N,Max_iteration,lb,ub,dim,fobj);
end


figure
func_plot(Function_name);
title('搜索空间')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%%
figure;
t = 1:Max_iteration;
semilogy(t, MPSO_cg_curve, 'rd-',t,  PSO_cg_curve, 'c^-',t, TACPSO_cg_curve, 'g<-',...
    'linewidth', 1.5, 'MarkerSize', 6, 'MarkerIndices', 1:25:Max_iteration);
title(Function_name)
xlabel('迭代次数');
ylabel('log(适应度值)');
axis fill
grid on
box on
legend('MPSO','PSO','TACPSO');
set(gca,'fontname','宋体 ')
%display(['The best optimal value of the objective funciton found by SLWChoa is : ', num2str(ABest_scoreChimp_2)])
display(['The best optimal value of the objective funciton found by TACPSO is : ', num2str(TACPSO_gBestScore)]);
display(['The best optimal value of the objective funciton found by PSO is : ', num2str(PSO_gBestScore)]);
display(['The best optimal value of the objective funciton found by MPSO is : ', num2str(MPSO_gBestScore)]);
%display(['The best optimal value of the objective funciton found by Chimp is : ', num2str(ABest_scoreChimp)]);
%display(['The best optimal value of the objective funciton found by HHO is : ', num2str(HHO_gBestScore)]);
%display(['The best optimal value of the objective funciton found by AO is : ', num2str(AO_gBestScore)]);
%%
disp(['函数：', num2str(Function_name)]);
%worst_SLWchoa = max(ABest_scoreChimp_2);best_SLWchoa = min(ABest_scoreChimp_2);mean_SLWchoa = mean(ABest_scoreChimp_2);std_SLWchoa= std(ABest_scoreChimp_2);
worst_PSO = max(PSO_gBestScore);best_PSO = min(PSO_gBestScore);mean_PSO = mean(PSO_gBestScore);std_PSO = std(PSO_gBestScore);
%worst_Chimp= max(ABest_scoreChimp);best_Chimp = min(ABest_scoreChimp);mean_Chimp = mean(ABest_scoreChimp);std_Chimp = std(ABest_scoreChimp);
worst_TACPSO = max(TACPSO_gBestScore);best_TACPSO = min(TACPSO_gBestScore);mean_TACPSO = mean(TACPSO_gBestScore);std_TACPSO = std(TACPSO_gBestScore);
worst_MPSO= max(MPSO_gBestScore);best_MPSO = min(MPSO_gBestScore);mean_MPSO = mean(MPSO_gBestScore);std_MPSO = std(MPSO_gBestScore);
%worst_HHO= max(HHO_gBestScore);best_HHO = min(HHO_gBestScore);mean_HHO = mean(HHO_gBestScore);std_HHO = std(HHO_gBestScore);
%worst_AO= max(AO_gBestScore);best_AO = min(AO_gBestScore);mean_AO = mean(AO_gBestScore);std_AO = std(AO_gBestScore);

% disp(['SLWChoa：最差值: ', num2str(worst_SLWchoa), ', 最优值: ', num2str(best_SLWchoa), ',平均值: ', num2str(mean_SLWchoa), ',标准差: ', num2str(std_SLWchoa), ...
%     ', 秩和检验: ', num2str(ranksum(ABest_scoreChimp_2, ABest_scoreChimp_2))]);
% disp(['PSO：最差值: ', num2str(worst_PSO), ', 最优值: ', num2str(best_PSO), ',平均值: ', num2str(mean_PSO), ',标准差: ', num2str(std_PSO), ...
%     ', 秩和检验: ', num2str(ranksum(PSO_gBestScore, ABest_scoreChimp_2))]);
% disp(['Chimp：最差值: ', num2str(worst_Chimp), ', 最优值: ', num2str(best_Chimp), ',平均值: ', num2str(mean_Chimp), ',标准差: ', num2str(std_Chimp), ...
%     ', 秩和检验: ', num2str(ranksum(ABest_scoreChimp, ABest_scoreChimp_2))]);
% disp(['TACPSO：最差值: ', num2str(worst_TACPSO), ', 最优值: ', num2str(best_TACPSO), ',平均值: ', num2str(mean_TACPSO), ',标准差: ', num2str(std_TACPSO), ...
%     ', 秩和检验: ', num2str(ranksum(TACPSO_gBestScore, ABest_scoreChimp_2))]);
% disp(['MPSO：最差值: ', num2str(worst_MPSO), ', 最优值: ', num2str(best_MPSO), ', 平均值: ', num2str(mean_MPSO), ', 标准差: ', num2str(std_MPSO), ...
%     ', 秩和检验: ', num2str(ranksum(MPSO_gBestScore, ABest_scoreChimp_2))]);
% disp(['HHO：最差值: ', num2str(worst_HHO), ', 最优值: ', num2str(best_HHO), ', 平均值: ', num2str(mean_HHO), ', 标准差: ', num2str(std_HHO), ...
%     ', 秩和检验: ', num2str(ranksum(HHO_gBestScore, ABest_scoreChimp_2))]);
% disp(['AO：最差值: ', num2str(worst_AO), ', 最优值: ', num2str(best_AO), ', 平均值: ', num2str(mean_AO), ', 标准差: ', num2str(std_AO), ...
%     ', 秩和检验: ', num2str(ranksum(AO_gBestScore, ABest_scoreChimp_2))]);

        



