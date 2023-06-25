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
% Mirjalili, S., Mirjalili, S. M., & Lewis, A. (2014). Grey Wolf Optimizer. Advances in engineering software, 69, 46-61.                        %
%%                                                                                    %

function [gBestScore,gBest,cg_curve]=IPSO(N,Max_iteration,lb,ub,dim,fobj)

wMax=0.9;
wMin=0.4;
c1=2;
c2=2;

vel=zeros(N,dim);
pos=zeros(N,dim);
pBestScore=zeros(N);
pBest=zeros(N,dim);
gBestScore=0;
gBest=zeros(1,dim);

%Initialization
for i=1:size(pos,1) 
    for j=1:size(pos,2) 
        pos(i,j)=(ub(j)-lb(j))*rand()+lb(j);
        vel(i,j)=0.3*rand();
    end
end
for i=1:N
    pBestScore(i)=inf;
end

%initialize gBestScore for min
gBestScore=inf;
     
    
for l=1:Max_iteration
    %Calculate Score Function
    for i=1:size(pos,1)  
        fitness=0;
        
        Tp=pos(i,:)>ub;Tm=pos(i,:)<lb;pos(i,:)=(pos(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;                   
        
        fitness=fobj(pos(i,:));
       
        if(pBestScore(i)>fitness)
            pBestScore(i)=fitness;
            pBest(i,:)=pos(i,:);
        end
        if(gBestScore>fitness)
            gBestScore=fitness;
            gBest=pos(i,:);
        end
    end

    c1=2.5+2*(l/Max_iteration)^2-2*(2*l/Max_iteration);
    c2=3-c1;  
    
    %update the W of PSO
    w=wMax-l*((wMax-wMin)/Max_iteration);
    
    %Update the Velocity and Position of particles
    for i=1:size(pos,1)
        for j=1:size(pos,2)       
            vel(i,j)=w*vel(i,j)+c1*rand()*(pBest(i,j)-pos(i,j))+c2*rand()*(gBest(j)-pos(i,j));
            pos(i,j)=pos(i,j)+vel(i,j);
        end
    end
    cg_curve(l)=gBestScore;
end
end
