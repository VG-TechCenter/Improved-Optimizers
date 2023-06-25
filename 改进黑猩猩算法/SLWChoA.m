%% 黑猩猩优化算法
function [Attacker_score,Attacker_pos,Convergence_curve]=SLWChoA(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

% 初始化攻击/驱逐/阻碍/追赶猩猩的初始信息
Attacker_pos=zeros(1,dim); % 攻击猩猩位置
Attacker_score=inf;        % 攻击猩猩适应度

Barrier_pos=zeros(1,dim);
Barrier_score=inf;

Chaser_pos=zeros(1,dim);
Chaser_score=inf;

Driver_pos=zeros(1,dim);
Driver_score=inf;

% 所有种群初始化sobel  
p = sobolset(dim);

% 计算适应度值
for i = 1:SearchAgents_no
    temp(i,:)=p(i+2,:);
    Positions(i, :) = p(i+2, :).*(ub-lb)+lb;
end

% Positions=initialization(SearchAgents_no,dim,ub,lb);

Convergence_curve=zeros(1,Max_iter); %迭代曲线

l=0; %当前迭代次数
yitamax=10;yitamin=1;
%% 主循环
while l<Max_iter
    l   % 打印当前运行次数
    
    for i=1:size(Positions,1)   %进入种群更新 size(Positions,1)=N
        
        % 参数越界处理
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % 计算新种群的适应度
        fitness=fobj(Positions(i,:));
        
  
        
        % 更新四种猩猩的位置
        if fitness<Attacker_score       % 最优的猩猩
            Attacker_score=fitness;     % 如果新解更优，则进行更新
            Attacker_pos=Positions(i,:);
        end
        
        if fitness>Attacker_score && fitness<Barrier_score
            Barrier_score=fitness;      % 次优猩猩
            Barrier_pos=Positions(i,:);
        end
        
        if fitness>Attacker_score && fitness>Barrier_score && fitness<Chaser_score
            Chaser_score=fitness;      % 第三优的猩猩
            Chaser_pos=Positions(i,:);
        end
        if fitness>Attacker_score && fitness>Barrier_score && fitness>Chaser_score && fitness>Driver_score
            Driver_score=fitness;      % 最差的猩猩
            Driver_pos=Positions(i,:);
        end
    end
    
    % 攻击黑猩猩凸透镜反向学习
    yita=yitamax-(yitamax-yitamin)*(l/Max_iter)^2;
    Attacker_pos_temp=(ub+lb)./2+(ub+lb)./(2*yita)-Attacker_pos./yita;
    %% 越界处理
    Flag4ub=Attacker_pos_temp>ub;
    Flag4lb=Attacker_pos_temp<lb;
    Attacker_pos_temp=(Attacker_pos_temp.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    
    %% 贪婪选择机制
    Attacker_score_temp=fobj(Attacker_pos_temp);
    if Attacker_score_temp<Attacker_score
        Attacker_score=Attacker_score_temp;
        Attacker_pos=Attacker_pos_temp;
    end
    
    f=2-l*((2)/Max_iter); % 开发因子：平衡全局勘探到局部开发之间的过度 [0,2]
    
    %Group 1
    C1G1=1.95-((2*l^(1/3))/(Max_iter^(1/3)));
    C2G1=(2*l^(1/3))/(Max_iter^(1/3))+0.5;
    
    %Group 2
    C1G2= 1.95-((2*l^(1/3))/(Max_iter^(1/3)));
    C2G2=(2*(l^3)/(Max_iter^3))+0.5;
    
    %Group 3
    C1G3=(-2*(l^3)/(Max_iter^3))+2.5;
    C2G3=(2*l^(1/3))/(Max_iter^(1/3))+0.5;
    
    %Group 4
    C1G4=(-2*(l^3)/(Max_iter^3))+2.5;
    C2G4=(2*(l^3)/(Max_iter^3))+0.5;

    for i=1:size(Positions,1)  %size(Positions,1)=N
        
        for j=1:size(Positions,2) %size(Positions,2)=dim

            %% Please note that to choose a other groups you should use the related group strategies
            r11=C1G1*rand(); % r1 [0,1]之间的随机值
            r12=C2G1*rand(); % r2 is a random number in [0,1]
            
            r21=C1G2*rand(); % r1 is a random number in [0,1]
            r22=C2G2*rand(); % r2 is a random number in [0,1]
            
            r31=C1G3*rand(); % r1 is a random number in [0,1]
            r32=C2G3*rand(); % r2 is a random number in [0,1]
            
            r41=C1G4*rand(); % r1 is a random number in [0,1]
            r42=C2G4*rand(); % r2 is a random number in [0,1]
            
            A1=2*f*r11-f;   % 是决定黑猩猩与猎物距离的系数矢量
            C1=2*r12;       % 控制黑猩猩驱逐和追赶猎物的系数矢量
            
            %% % Please note that to choose various Chaotic maps you should use the related Chaotic maps strategies
            m=chaos(3,1,1); % 混沌映射：表示社会激励对黑猩猩个体位置的影响
            beta=1-sin((pi*l)/(2*Max_iter)+2*pi);%水波动态因子
            D_Attacker=abs(C1*Attacker_pos(j)-m*Positions(i,j));  %当前猩猩与猎物之间的距离
            X1=beta*Attacker_pos(j)-A1*D_Attacker;                     %攻击猩猩位置更新
            
            A2=2*f*r21-f; % Equation (3)
            C2=2*r22; % Equation (4)
            
            
            D_Barrier=abs(C2*Barrier_pos(j)-m*Positions(i,j)); % Equation (6)
            X2=Barrier_pos(j)-A2*D_Barrier; % Equation (7)
            
            
            
            A3=2*f*r31-f; % Equation (3)
            C3=2*r32; % Equation (4)
            
            D_Driver=abs(C3*Chaser_pos(j)-m*Positions(i,j)); % Equation (6)
            X3=Chaser_pos(j)-A3*D_Driver; % Equation (7)
            
            A4=2*f*r41-f; % Equation (3)
            C4=2*r42; % Equation (4)
            
            D_Driver=abs(C4*Driver_pos(j)-m*Positions(i,j)); % Equation (6)
            X4=Chaser_pos(j)-A4*D_Driver; % Equation (7)
            
            Positions(i,j)=(X1+X2+X3+X4)/4; % 取平均
            
        end
    end
    l=l+1;
    Convergence_curve(l)=Attacker_score;
end



