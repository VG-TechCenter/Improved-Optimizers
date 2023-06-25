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
Max_iter=500;
 l=1:Max_iter; 
       
   %Group 1
    C1G1=1.95-((2*l.^(1/4))/(Max_iter.^(1/3)));
%     C2G1=(2*l.^(1/3))/(Max_iter.^(1/3))+0.5;
        
   %Group 2
    C1G2= 1.95-((2*l.^(1/3))/(Max_iter.^(1/4)));
%     C2G2=(2*(l.^3)/(Max_iter.^3))+0.5;
    
    %Group 3
    C1G3=(-3*(l.^3)/(Max_iter.^3))+1.5;
%     C2G3=(2*l.^(1/3))/(Max_iter.^(1/3))+0.5;
    
    %Group 4
    C1G4=(-2*(l.^3)/(Max_iter.^3))+1.5;
%     C2G4=(2*(l.^3)/(Max_iter.^3))+0.5;
    % PLOT c1
    hold on
plot(C1G1,'--m','Linewidth',3);
hold on
plot(C1G2,'-.k','Linewidth',3);
hold on
plot(C1G3,'g','Linewidth',3);
hold on
plot(C1G4,':b','Linewidth',3)


title('f (ChOA1)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
xlabel('Iteration','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('Amplitude','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('Attacker','Barrier','Driver','Chaser');
axis tight
box on

    