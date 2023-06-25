
%%  %  Chimp Optimization Algorithm (ChOA) source codes version 1.0   
% By: M. Khishe, M. R. Musavi
% m_khishe@alumni.iust.ac.ir
%For more information please refer to the following papers:
% M. Khishe, M. R. Mosavi, “Chimp Optimization Algorithm,” Expert Systems
% With Applications, 2020.
%https://www.sciencedirect.com/science/article/abs/pii/S0957417420301639
% Please note that some files and functions are taken from the GWO algorithm
% such as: Get_Functions_details, PSO, initialization.
%  For more information please refer to the following papers:
% Mirjalili, S., Mirjalili, S. M., & Lewis, A. (2014). Grey Wolf Optimizer. Advances in engineering software, 69, 46-61.
%% --------------------------------------------------------------------------------------------------------------------%
Max_iteration=500;
 l=1:Max_iteration; 
       
  %Group 1
    C1G1=2.5+2*(l/Max_iteration).^2-2*(2*l/Max_iteration);
%     C2G1=3-c1;
    
    %Group 2
    C1G2=0.5+2*exp(-(4*l/Max_iteration).^2);
%     C2G2=2.2-2*exp(-(4*l/Max_iteration).^2); 
    
    %Group 3
    C1G3=(-2*(l.^3)/(Max_iteration.^3))+2.5;
%     C2G3=(2*(l.^3)/(Max_iteration.^3))+0.5;
    
    %Group 4
    C1G4=2.5-(2*log(l)/log(Max_iteration));
%     C2G4=(2*log(l)/log(Max_iteration))+0.5;
%     PLOT GROUP1
  hold on
plot(C1G1,'--m','Linewidth',3);
hold on
plot(C1G2,'-.k','Linewidth',3);
hold on
plot(C1G3,'g','Linewidth',3);
hold on
plot(C1G4,':b','Linewidth',3)


title('f (ChOA2)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
xlabel('Iteration','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('Amplitude','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('Attacker','Barrier','Driver','Chaser');
axis tight
box on