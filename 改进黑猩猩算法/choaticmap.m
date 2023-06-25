%%  %  Chimp Optimization Algorithm (ChOA) source codes version 1.0   
% By: M. Khishe, M. R. Musavi
% m_khishe@alumni.iust.ac.ir
%For more information please refer to the following papers:
% M. Khishe, M. R. Mosavi, “Chimp Optimization Algorithm,” Expert Systems
% With Applications, 2020.
% Please note that some files and functions are taken from the GWO algorithm
% such as: Get_Functions_details, PSO, initialization.
%  For more information please refer to the following papers:
% Mirjalili, S., Mirjalili, S. M., & Lewis, A. (2014). Grey Wolf Optimizer. Advances in engineering software, 69, 46-61.
%% --------------------------------------------------------------------------------------------------------------------%

%Chebyshev map
x=1:1:100;
y=chaos(1,100,1);
subplot(321);plot(x,y,'LineWidth',3);
title([['\fontsize{20}\bf ', 'Quadradic Map']],'FontName','Times New Roman');
xlabel('\fontsize{16}\bf Time scale');ylabel('\fontsize{14}\bf Amplitude');

% %Gauss/mouse map
y=chaos(3,100,1);
subplot(322);plot(x,y,'LineWidth',3);
title([['\fontsize{20}\bf ', 'Gauss/mouse Map']],'FontName','Times New Roman');
xlabel('\fontsize{16}\bf Time scale');ylabel('\fontsize{14}\bf Amplitude');

%Logistic map
y=chaos(5,100,1);
subplot(323);plot(x,y,'LineWidth',3);
title([['\fontsize{20}\bf ', 'Logistic Map']],'FontName','Times New Roman');
xlabel('\fontsize{16}\bf Time scale');ylabel('\fontsize{14}\bf Amplitude');

%  %Singer map 
y=chaos(8,100,1);
subplot(324);plot(x,y,'LineWidth',3);
title([['\fontsize{20}\bf ', 'Singer Map']],'FontName','Times New Roman');
xlabel('\fontsize{16}\bf Time scale');ylabel('\fontsize{14}\bf Amplitude');

%Sinusoidal map
y=chaos(9,100,1);
subplot(325);plot(x,y,'LineWidth',3);
title([['\fontsize{20}\bf ', 'Bernoulli Map']],'FontName','Times New Roman');
xlabel('\fontsize{16}\bf Time scale');ylabel('\fontsize{14}\bf Amplitude');

 %Tent map
 y=chaos(10,100,1);
subplot(326);plot(x,y,'LineWidth',3);
title([['\fontsize{20}\bf ', 'Tent Map']],'FontName','Times New Roman');
xlabel('\fontsize{16}\bf Time scale');ylabel('\fontsize{14}\bf Amplitude');

