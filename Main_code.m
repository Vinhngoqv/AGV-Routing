%%%NOTE:

clc
clear all
close all


%% Khoi tao bien kiem tra
% kqdt = cell(0,4);


%% Khoi tao bien ban dau
global time alpha POS_MAP AGV AGV_number change_path start_time
start_time = datenum(datetime);
alpha = 2;
res = 2; %Khoang thoi gian de chia nho duong
AGV_number = input('So luong AGV: ');

%% Khoi tao map
MAX_X=40;
MAX_Y=23;
MAX_VAL=10;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y)); %Create matrix 10x10 with the value is 2
MAP_2 = MAP;

%Khoi tao ma tran luu so luong AGV tai cac vi tri
POS_MAP = cell(MAX_Y,MAX_X);

% Obtain Obstacle, Target and Robot Position
% Initialize the MAP with input values
% Obstacle=-1,Target = 0,AGV = 1,Space = 2
j=0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1]);
set(gcf, 'Position', get(0, 'Screensize'));
grid on;
grid minor;
hold on;
n=0;%Number of Obstacles

% Create initial racks
% for v = 6:34 %Layout nho
%     if (v~=16 && v~=27)
%         for l = 2:12
%             if (l ~= 4 && l ~= 7 && l ~= 10)
%                 MAP(v,l) = -1; %Put on the closed list as well
%                 plot(v+.5,l+.5,'s','MarkerSize',20,'MarkerFaceColor',[0.5,0.5,0.5]);
%             end
%         end
%     end
% end

for v = 6:37 %Layout to
    if (v~=16 && v~=27)
        for l = 2:21
            if (l ~= 4 && l ~= 7 && l ~= 10 && l~= 13 && l~= 16 && l~= 19)
                MAP(v,l) = -1; %Put on the closed list as well
                plot(v+.5,l+.5,'s','MarkerSize',20,'MarkerFaceColor',[0.5,0.5,0.5]);
            end
        end
    end
end

%% Khoi tao AGV
for i = 1:AGV_number
    AGV{1,i}.IDNumber = i;
    AGV{1,i}.power = 100;
    AGV{1,i}.travel_dist = 0;
    AGV{1,i}.local = [];
    AGV{1,i}.distination = [];
    AGV{1,i}.path = [];
    AGV{1,i}.path1 = [];
    AGV{1,i}.path_time = {};
end

%% Chon vi tri ban dau cho AGV
% h=msgbox('Select the position of AGVs');
% uiwait(h,2);
for i = 1:AGV_number
    but=0;
    while (but ~= 1) %Repeat until the Left button is not clicked
        [xval,yval,but]=ginput(1);
    end
    xval_1=floor(xval);
    yval_1=floor(yval);
    xStart_1=xval_1;
    yStart_1=yval_1;
    AGV{1,i}.local = [xval_1 yval_1];
    draw_agv(1,i) = plot(AGV{1,i}.local(1,1)+.5,AGV{1,i}.local(1,2)+.5,'s','MarkerSize',20,'MarkerFaceColor',[0,1,0]);
    draw_agv(2,i) = text(AGV{1,i}.local(1,1)+.25,AGV{1,i}.local(1,2)+.5,strcat('A_',num2str(i)));
    drawnow;
    MAP(xval_1,yval_1)=1;
end

%% Chon vi tri den
% h=msgbox('Select Targets (Left Mouse)');
% uiwait(h,2);
for i = 1:AGV_number
    but=0;
    while (but ~= 1) %Repeat until the Left button is not clicked
        [xval,yval,but]=ginput(1); %get location of target node
    end

    %Get the location of the Target_1st
    xTarget_1=floor(xval);
    yTarget_1=floor(yval);
    AGV{1,i}.distination = [xTarget_1 yTarget_1];
    plot(xTarget_1+.5,yTarget_1+.5,'d','MarkerSize',10,'MarkerFaceColor',[1,0,0]);
    target_text = strcat('Target_',string(i));
    text(xTarget_1+1,yTarget_1+.5,target_text);
    drawnow;
    MAP(xTarget_1,yTarget_1)=0;
end
pause(0.1);

%% Finding path for AGV
for agv = 1:AGV_number
    AGV{1,agv}.path = Astar_finding(AGV{1,agv}.local(1,1),AGV{1,agv}.local(1,2), AGV{1,agv}.distination(1,1),AGV{1,agv}.distination(1,2),MAP);
%     %Khoi tao tap OPEN, CLOSE ban dau
%     OPEN=[];
%     CLOSED=[]; %Tap hop cac diem khong di qua duoc
% 
%     %Luu cac chuong ngai vat vao tap CLOSE
%     k=1;%Dummy counter
%     for i=1:MAX_X
%         for j=1:MAX_Y
%             if(MAP(i,j) == -1)
%                 CLOSED(k,1)=i; %cot 1 la x
%                 CLOSED(k,2)=j; %cot 2 la y
%                 k=k+1;
%             end
%         end
%     end
%     CLOSED_COUNT = size(CLOSED,1);
%     %%%%%%%%%%%%%%%%%%%%%set the starting node of the 1st AGV as the first node
%     xNode=AGV{1,agv}.local(1,1);
%     yNode=AGV{1,agv}.local(1,2);
%     OPEN_COUNT = 1;
%     path_cost=0;
%     goal_distance=distance(xNode,yNode,xTarget_1,yTarget_1);
%     
%     OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
%     OPEN(OPEN_COUNT,1)=0;
%     CLOSED_COUNT=CLOSED_COUNT+1;
%     CLOSED(CLOSED_COUNT,1)=xNode;
%     CLOSED(CLOSED_COUNT,2)=yNode;
%     NoPath=1;
%     
%     time = start_time;
%     % START ALGORITHM
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     while((xNode ~= AGV{1,agv}.distination(1,1) || yNode ~= AGV{1,agv}.distination(1,2)) && NoPath == 1)
%     %  plot(xNode+.5,yNode+.5,'go');
%      exp_array=expand_array(xNode,yNode,path_cost,AGV{1,agv}.distination(1,1),AGV{1,agv}.distination(1,2),CLOSED,MAX_X,MAX_Y);
%      time = time + 2/24/3600;
%      
%      
% %      fprintf('%s\n',datetime(time,'ConvertFrom','datenum'));
%      
%      
%      exp_count=size(exp_array,1);
% 
%      for i=1:exp_count
%         flag=0;
%         for j=1:OPEN_COUNT
%             if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
%                 OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
%                 if OPEN(j,8)== exp_array(i,5)
%                     %UPDATE PARENTS,gn,hn
%                     OPEN(j,4)=xNode;
%                     OPEN(j,5)=yNode;
%                     OPEN(j,6)=exp_array(i,3);
%                     OPEN(j,7)=exp_array(i,4);
%                 end;%End of minimum fn check
%                 flag=1;
%             end;%End of node check
%     %         if flag == 1
%     %             break;
%         end;%End of j for
%         if flag == 0
%             OPEN_COUNT = OPEN_COUNT+1;
%             OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
%          end;%End of insert new element into the OPEN list
%      end;%End of i for
%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      %END OF WHILE LOOP
%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      %Find out the node with the smallest fn 
%       index_min_node = min_fn(OPEN,OPEN_COUNT,AGV{1,agv}.distination(1,1),AGV{1,agv}.distination(1,2));
%       if (index_min_node ~= -1)    
%        %Set xNode and yNode to the node with minimum fn
%        xNode=OPEN(index_min_node,2);
%        yNode=OPEN(index_min_node,3);
%        path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
%       %Move the Node to list CLOSED
%       CLOSED_COUNT=CLOSED_COUNT+1;
%       CLOSED(CLOSED_COUNT,1)=xNode;
%       CLOSED(CLOSED_COUNT,2)=yNode;
%       OPEN(index_min_node,1)=0;
%       else
%           %No path exists to the Target!!
%           NoPath=0;%Exits the loop!
%       end;%End of index_min_node check
%     end;%End of While Loop
%     %Once algorithm has run The optimal path is generated by starting of at the
%     %last node(if it is the target node) and then identifying its parent node
%     %until it reaches the start node.This is the optimal path
% 
%     i=size(CLOSED,1);
%     Optimal_path_1=[];
%     xval_1=CLOSED(i,1);
%     yval_1=CLOSED(i,2);
%     i=1;
%     Optimal_path_1(i,1)=xval_1;
%     Optimal_path_1(i,2)=yval_1;
%     i=i+1;
% 
% 
%     if ( (xval_1 == AGV{1,agv}.distination(1,1)) && (yval_1 == AGV{1,agv}.distination(1,2)))
%         inode=0;
%        %Traverse OPEN and determine the parent nodes
%        parent_x=OPEN(node_index(OPEN,xval_1,yval_1),4);%node_index returns the index of the node
%        parent_y=OPEN(node_index(OPEN,xval_1,yval_1),5);
% 
%        while( parent_x ~= AGV{1,agv}.local(1,1) || parent_y ~= AGV{1,agv}.local(1,2))
%                Optimal_path_1(i,1) = parent_x;
%                Optimal_path_1(i,2) = parent_y;
%                %Get the grandparents:-)
%                inode=node_index(OPEN,parent_x,parent_y);
%                parent_x=OPEN(inode,4);%node_index returns the index of the node
%                parent_y=OPEN(inode,5);
%                i=i+1;
%         end;
%         p1 = 1;
%         %ve duong da tim
%         Optimal_path_1(size(Optimal_path_1,1)+1,1)= AGV{1,agv}.local(1,1);
%         Optimal_path_1(size(Optimal_path_1,1),2)= AGV{1,agv}.local(1,2);
%         plot(Optimal_path_1(:,1)+.5,Optimal_path_1(:,2)+.5);
%     else
%      pause(1);
%      h=msgbox('Sorry, No path exists to the Target 1st!','warn');
%      uiwait(h,5);
%     end
%     Optimal_path_1=flipud(Optimal_path_1); %dao nguoc ma tran
%     AGV{1,agv}.path = Optimal_path_1;
%     
%     %gan thoi gian va luu vao ma tran dat cho
%     if size(AGV{1,agv}.path,1) > 0
%         for i = 1:size(AGV{1,agv}.path,1)
%             AGV{1,agv}.path(i,3) = start_time + (i-1)*2/24/3600;
%             POS_MAP{AGV{1,agv}.path(i,2),AGV{1,agv}.path(i,1)}(size(POS_MAP{AGV{1,agv}.path(i,2),AGV{1,agv}.path(i,1)},1)+1,:) = [agv,AGV{1,agv}.path(i,3)];
%         end
%     end
% %     %Luu ket qua da chay kiem tra
% %     kqdt{size(kqdt,1)+1,1} = strcat('Lan',32,num2str(agv));
% %     kqdt{size(kqdt,1),2} = CLOSED;
% %     kqdt{size(kqdt,1),3} = OPEN;
% %     kqdt{size(kqdt,1),4} = POS_MAP;
end%End for tim duong cho n AGV

AGV1{1,1} = AGV;
%% Check Collision
change_path = 0;
detect_and_avoid_collision;
AGV1{1,size(AGV1,2)+1} = AGV;
while change_path ~= 0
    change_path = 0;
    %Lam sao giu lai nhung xe khac khong b? thay doi?
    fprintf('CO CHAY VONG TRONG\n')
    detect_and_avoid_collision;
    AGV1{1,size(AGV1,2)+1} = AGV;
end

for ii = 1:size(AGV1,2)
    for i_t = 1: size(AGV1{1,ii}{1,1}.path,1)
        AGV1{1,ii}{1,1}.path_time{i_t,1} = char(datetime(AGV1{1,ii}{1,1}.path(i_t,3),'ConvertFrom','datenum'));
        AGV1{1,ii}{1,1}.path_time{i_t,2} = AGV1{1,ii}{1,1}.path(i_t,1);
        AGV1{1,ii}{1,1}.path_time{i_t,3} = AGV1{1,ii}{1,1}.path(i_t,2);
    end
    for i_t = 1: size(AGV1{1,ii}{1,2}.path,1)
        AGV1{1,ii}{1,2}.path_time{i_t,1} = char(datetime(AGV1{1,ii}{1,2}.path(i_t,3),'ConvertFrom','datenum'));
        AGV1{1,ii}{1,2}.path_time{i_t,2} = AGV1{1,ii}{1,2}.path(i_t,1);
        AGV1{1,ii}{1,2}.path_time{i_t,3} = AGV1{1,ii}{1,2}.path(i_t,2);
    end
end

%% Phan duong
for k_path1 = 1:AGV_number
    AGV{1,k_path1}.path1 = AGV{1,k_path1}.path;
    path_tam = [];
%     phan_du = 0;
    for k_path2 = 1:(size(AGV{1,k_path1}.path1,1)-1)
        delta = floor((AGV{1,k_path1}.path1(k_path2 + 1,3) - AGV{1,k_path1}.path1(k_path2, 3) + 0.5/24/3600)*24*3600/res);
%         delta = floor((AGV{1,k_path1}.path1(k_path2 + 1,3) - AGV{1,k_path1}.path1(k_path2, 3) + phan_du)*24*3600/res);
%         phan_du = ((AGV{1,k_path1}.path1(k_path2 + 1,3) - AGV{1,k_path1}.path1(k_path2, 3) + phan_du)*24*3600 - res*delta)/24/3600;
        for k_path3 = 1:delta
            path_tam(size(path_tam,1)+1,1) = AGV{1,k_path1}.path1(k_path2, 1);
            path_tam(size(path_tam,1),2) = AGV{1,k_path1}.path1(k_path2, 2);
        end
    end
    AGV{1,k_path1}.path1 = [path_tam; [AGV{1,k_path1}.path(size(AGV{1,k_path1}.path,1),1) AGV{1,k_path1}.path(size(AGV{1,k_path1}.path,1),2)]];
end
        
        
%% Ghi duong lay thoi gian check
for i = 1:AGV_number
    for i_t = 1: size(AGV{1,i}.path,1)
        AGV{1,i}.path_time{i_t,1} = char(datetime(AGV{1,i}.path(i_t,3),'ConvertFrom','datenum'));
        AGV{1,i}.path_time{i_t,2} = AGV{1,i}.path(i_t,1);
        AGV{1,i}.path_time{i_t,3} = AGV{1,i}.path(i_t,2);
    end
end

%% Following path
for i = 1:AGV_number
    size_path(1,i) = size(AGV{1,i}.path1,1);
end
size_path_max = max(size_path);
for i=1:size_path_max
    for j = 1:AGV_number
        if i <= size(AGV{1,j}.path1,1)
            set(draw_agv(1,j),'XData',AGV{1,j}.path1(i,1)+.5,'YData',AGV{1,j}.path1(i,2)+.5);
            set(draw_agv(2,j),'Position',[AGV{1,j}.path1(i,1)+0.25 AGV{1,j}.path1(i,2)+.5]);
        end
    end
    drawnow;
    pause(.5)
end
