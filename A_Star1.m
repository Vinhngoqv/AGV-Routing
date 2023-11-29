clc;
clear all;
%DEFINE THE 2-D MAP ARRAY
MAX_X=36;
MAX_Y=14;
MAX_VAL=10;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y)); %Create matrix 10x10 with the value is 2

% Obtain Obstacle, Target and Robot Position
% Initialize the MAP with input values
% Obstacle=-1,Target = 0,AGV = 1,Space = 2
j=0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1]);
grid on;
grid minor;
hold on;
n=0;%Number of Obstacles

% Create initial racks
for v = 6:34
    if (v~=16 && v~=27)
        for l = 2:12
            if (l ~= 4 && l ~= 7 && l ~= 10)
                MAP(v,l) = -1; %Put on the closed list as well
                plot(v+.5,l+.5,'s','MarkerSize',20,'MarkerFaceColor',[0.5,0.5,0.5]);
            end
        end
    end
end


% BEGIN Interactive Obstacle, Target, Start Location selection

pause(2);
h=msgbox('Select Obstacles (Left Mouse),Select the last obstacle (Right button)');
  xlabel('Select Obstacles (Left Mouse),Select the last obstacle (Right button)','Color','blue');
uiwait(h,10);
if ishandle(h) == 1
    delete(h);
end
but=1;
while (but == 1)
    [xval_1,yval_1,but] = ginput(1);
    xval_1=floor(xval_1);
    yval_1=floor(yval_1);
    MAP(xval_1,yval_1)=-1;%Put on the closed list as well
    plot(xval_1+.5,yval_1+.5,'s','MarkerSize',20,'MarkerFaceColor',[1,1,0]);
end%End of While loop
 
pause(1);
h=msgbox('Select Targets (Left Mouse)');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Select the 1st Target (Left Mouse)','Color','black');
%Get the location of the Targets
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1); %get location of target node
end

%Get the location of the Target_1st
xTarget_1=floor(xval);
yTarget_1=floor(yval);
plot(xTarget_1+.5,yTarget_1+.5,'d','MarkerSize',10,'MarkerFaceColor',[1,0,0]);
text(xTarget_1+1,yTarget_1+.5,'Target_1');
MAP(xTarget_1,yTarget_1)=0;
%Get the location of the Target_2nd
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1); %get location of target node
end
xTarget_2=floor(xval);
yTarget_2=floor(yval);
plot(xTarget_2+.5,yTarget_2+.5,'d','MarkerSize',10,'MarkerFaceColor',[1,0,0]);
text(xTarget_2+1,yTarget_2+.5,'Target_2');
MAP(xTarget_2,yTarget_2)=0;

 
pause(1);
h=msgbox('Select the position of AGVs');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Select the position of AGVs','Color','black');
%Get the starting position of the AGV_1st
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
end
xval_1=floor(xval);
yval_1=floor(yval);
xStart_1=xval_1;
yStart_1=yval_1;
plot(xval_1+.5,yval_1+.5,'rx','MarkerSize',10);
MAP(xval_1,yval_1)=1;
%Get the starting position of the AGV_2nd
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
end
xval_2=floor(xval);
yval_2=floor(yval);
xStart_2=xval_2;
yStart_2=yval_2;
plot(xval_2+.5,yval_2+.5,'bx','MarkerSize',10);
MAP(xval_2,yval_2)=1;


%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
OPEN=[];
%X val | Y val |
% CLOSED=zeros(MAX_VAL,2);
CLOSED=[];

%Put all obstacles on the Closed list
k=1;%Dummy counter
for i=1:MAX_X
    for j=1:MAX_Y
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i; 
            CLOSED(k,2)=j; 
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
%%%%%%%%%%%%%%%%%%%%%set the starting node of the 1st AGV as the first node
xNode=xStart_1;
yNode=yStart_1;
OPEN_COUNT=1;
path_cost=0;
goal_distance=distance(xNode,yNode,xTarget_1,yTarget_1);
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=xNode;
CLOSED(CLOSED_COUNT,2)=yNode;
NoPath=1;

% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget_1 || yNode ~= yTarget_1) && NoPath == 1)
%  plot(xNode+.5,yNode+.5,'go');
 exp_array=expand_array(xNode,yNode,path_cost,xTarget_1,yTarget_1,CLOSED,MAX_X,MAX_Y);
 exp_count=size(exp_array,1);

 for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if OPEN(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);
                OPEN(j,7)=exp_array(i,4);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%End of insert new element into the OPEN list
 end;%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget_1,yTarget_1);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path

i=size(CLOSED,1);
Optimal_path_1=[];
xval_1=CLOSED(i,1);
yval_1=CLOSED(i,2);
i=1;
Optimal_path_1(i,1)=xval_1;
Optimal_path_1(i,2)=yval_1;
i=i+1;


if ( (xval_1 == xTarget_1) && (yval_1 == yTarget_1))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index(OPEN,xval_1,yval_1),4);%node_index returns the index of the node
   parent_y=OPEN(node_index(OPEN,xval_1,yval_1),5);
   
   while( parent_x ~= xStart_1 || parent_y ~= yStart_1)
           Optimal_path_1(i,1) = parent_x;
           Optimal_path_1(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_x,parent_y);
           parent_x=OPEN(inode,4);%node_index returns the index of the node
           parent_y=OPEN(inode,5);
           i=i+1;
    end;
    p1 = 1;
else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target 1st!','warn');
 uiwait(h,5);
end

OPEN=[];
CLOSED=[];
%Put all obstacles on the Closed list again to find the another path
k=1;%Dummy counter
for i=1:MAX_X
    for j=1:MAX_Y
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i; 
            CLOSED(k,2)=j; 
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);

%%%%%%%%%%%%%%%%%%%%%set the starting node of the 2nd AGV as the first node
xNode=xStart_2;
yNode=yStart_2;
OPEN_COUNT=1;
path_cost=0;
goal_distance=distance(xNode,yNode,xTarget_2,yTarget_2);
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=xNode;
CLOSED(CLOSED_COUNT,2)=yNode;
NoPath=1;

% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget_2 || yNode ~= yTarget_2) && NoPath == 1)
%  plot(xNode+.5,yNode+.5,'go');
 exp_array=expand_array(xNode,yNode,path_cost,xTarget_2,yTarget_2,CLOSED,MAX_X,MAX_Y);
 exp_count=size(exp_array,1);

 for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if OPEN(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);
                OPEN(j,7)=exp_array(i,4);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%End of insert new element into the OPEN list
 end;%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget_2,yTarget_2);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path

i=size(CLOSED,1);
Optimal_path_2=[];
xval_2=CLOSED(i,1);
yval_2=CLOSED(i,2);
i=1;
Optimal_path_2(i,1)=xval_2;
Optimal_path_2(i,2)=yval_2;
i=i+1;


if ( (xval_2 == xTarget_2) && (yval_2 == yTarget_2))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index(OPEN,xval_2,yval_2),4);%node_index returns the index of the node
   parent_y=OPEN(node_index(OPEN,xval_2,yval_2),5);
   
   while( parent_x ~= xStart_2 || parent_y ~= yStart_2)
           Optimal_path_2(i,1) = parent_x;
           Optimal_path_2(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_x,parent_y);
           parent_x=OPEN(inode,4);%node_index returns the index of the node
           parent_y=OPEN(inode,5);
           i=i+1;
    end;
    p2 = 1;
else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target 2!','warn');
 uiwait(h,5);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Plot the Optimal Path!
if (p1 == 1 && p2 == 1)
a1=size(Optimal_path_1,1)+1;
Optimal_path_1(a1,1)=xStart_1;
Optimal_path_1(a1,2)=yStart_1;
plot(Optimal_path_1(:,1)+.5,Optimal_path_1(:,2)+.5);
pause(1); %pause before starting run
path_1=plot(Optimal_path_1(a1,1)+.5,Optimal_path_1(a1,2)+.5,'s','MarkerSize',20,'MarkerFaceColor',[0,1,0]);
Optimal_path_1=flipud(Optimal_path_1);

a2=size(Optimal_path_2,1)+1;
Optimal_path_2(a2,1)=xStart_2;
Optimal_path_2(a2,2)=yStart_2;
plot(Optimal_path_2(:,1)+.5,Optimal_path_2(:,2)+.5);
pause(1); %pause before starting run
path_2=plot(Optimal_path_2(a2,1)+.5,Optimal_path_2(a2,2)+.5,'s','MarkerSize',20,'MarkerFaceColor',[0,1,0]);
Optimal_path_2=flipud(Optimal_path_2);

if (a1>a2)
    j = a1;
    for i = 1:a1-a2
        Optimal_path_2(a2+i,1) = xTarget_2;
        Optimal_path_2(a2+i,2) = yTarget_2;
    end;
elseif (a1<a2)
    j = a2;
    for i = 1:a2-a1
        Optimal_path_1(a1+i,1) = xTarget_1;
        Optimal_path_1(a1+i,2) = yTarget_1;
    end;
else 
    j = a2;
end;
for i=1:j
    pause(.5);
    set(path_1,'XData',Optimal_path_1(i,1)+.5,'YData',Optimal_path_1(i,2)+.5);
    set(path_2,'XData',Optimal_path_2(i,1)+.5,'YData',Optimal_path_2(i,2)+.5);
    drawnow;
end;

% for i=j:-1:1
%     pause(.5);
%     set(path_2,'XData',Optimal_path_2(i,1)+.5,'YData',Optimal_path_2(i,2)+.5);
%     drawnow;
% end;
end;





