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
%%
% Particle Swarm Optimization
function [gBestScore,gBest,cg_curve]=PSO(N,Max_iteration,lb,ub,dim,fobj)

%PSO Infotmation

Vmax=6;
noP=N;
wMax=0.9;
wMin=0.6;
c1=2;
c2=2;

% Initializations
iter=Max_iteration;
vel=zeros(noP,dim);
pBestScore=zeros(noP);
pBest=zeros(noP,dim);
gBest=zeros(1,dim);
cg_curve=zeros(1,iter);
vel=zeros(N,dim);
pos=zeros(N,dim);

%Initialization
for i=1:size(pos,1) 
    for j=1:size(pos,2) 
        pos(i,j)=(ub(j)-lb(j))*rand()+lb(j);
        vel(i,j)=0.3*rand();
    end
end

for i=1:noP
    pBestScore(i)=inf;
end

% Initialize gBestScore for a minimization problem
 gBestScore=inf;
     
    
for l=1:iter 
    
    % Return back the particles that go beyond the boundaries of the search
    % space
     Flag4ub=pos(i,:)>ub;
     Flag4lb=pos(i,:)<lb;
     pos(i,:)=(pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    
    for i=1:size(pos,1)     
        %Calculate objective function for each particle
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

    %Update the W of PSO
    w=wMax-l*((wMax-wMin)/iter);
    %Update the Velocity and Position of particles
    for i=1:size(pos,1)
        for j=1:size(pos,2)       
            vel(i,j)=w*vel(i,j)+c1*rand()*(pBest(i,j)-pos(i,j))+c2*rand()*(gBest(j)-pos(i,j));
            
            if(vel(i,j)>Vmax)
                vel(i,j)=Vmax;
            end
            if(vel(i,j)<-Vmax)
                vel(i,j)=-Vmax;
            end            
            pos(i,j)=pos(i,j)+vel(i,j);
        end
    end
    cg_curve(l)=gBestScore;
end


end