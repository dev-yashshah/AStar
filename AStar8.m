function path = AStar8(v0, vt, map)

INFINITY = 1e5;

% defining the offsets and the distances to the neighbors
neighbors = [   -1,-1,sqrt(2);
                -1,0,1;
                -1,1,sqrt(2);
                0,1,1;
                1,1,sqrt(2);
                1,0,1;
                1,-1,sqrt(2);
                0,-1,1
            ];

n = size(map);

% initializing the matrices keeping the f and g scores
f_score = INFINITY*ones(n(1),n(2));
f_score(v0(1), v0(2)) = h(v0,vt);

g_score = INFINITY*ones(n(1),n(2));
g_score(v0(1), v0(2)) = 0;

% tracking the status of a position whether it is in the open set
inOpenSet = zeros(n(1),n(2));

% tracking the status of a position whether it is in the close set
inCloseSet = zeros(n(1),n(2));

% mappings to recovery the path from the target node
cameFrom_x = zeros(n(1),n(2));
cameFrom_y = zeros(n(1),n(2));

% This is only a simple implementation, you need to use a priority queue
% for the set openSet for better performance.
openSet = [v0];
closeSet = [];

%bTerminate = false;
while true

    if size(openSet, 1) == 0
        disp('No feasible path.');
        path = [];
        return;
    end
    
    % 1. (3 points) finding the node with the lowest f score in the open set
    index=findLowestF(openSet,f_score);
    temp=openSet(index,:);
    current(1)=temp(1);
    current(2)=temp(2);
    
    % 2. (4 points) removing that node from the open set and adding it to the close set
    % you also need to update its status in inOpenSet and inCloseSet 
    closeSet=[closeSet;openSet(index,:)];
    openSet(index,:)=[];
    inCloseSet(current(1),current(2))=1;
    inOpenSet(current(1),current(2))=0;
    plotCircle(current(1), current(2), 'r');

    % if it is the target node
    if isequal(current, vt)
        % 3. (3 points) constructing the path and assign the return value to path 
        disp("reached")
        path=constructShortestPath(current,cameFrom_x,cameFrom_y);
        break;
    end
    
    % checking all of the neighbors, there are totally 8
    for i=1:8

        u = [0,0];
        u(1) = current(1) + neighbors(i,1);
        
        if u(1) < 1 || u(1) > n(1)  % outside the map
            continue;
        end
        
        u(2) = current(2) + neighbors(i,2);
        
        if u(2) < 1 || u(2) > n(2)  % outside the map
            continue;
        end
        
        if map(u(1),u(2)) == 0  % obstacle
            continue;
        end
        
        % if it is already in the close set, then ignore it
        if inCloseSet(u(1),u(2)) == 1
            continue;
        end

        % 4.           checking the g score, if the node is selected, then
        %              plot it to the figure using plotCircle(u(1),u(2),'g'),
        %              and add it to the open set. Notice that you also
        %              need to keep the predecessor in the cameFrom_x and
        %              cameFrom_y matrices.
        tentative_g_score=g_score(current(1),current(2))+neighbors(i,3);
        if tentative_g_score<g_score(u(1),u(2))
            g_score(u(1),u(2))=tentative_g_score;
            plotCircle(u(1),u(2),'g');
            cameFrom_x(u(1),u(2))=current(1);
            cameFrom_y(u(1),u(2))=current(2);
            f_score(u(1),u(2))=tentative_g_score+h([u(1),u(2)],vt);
            if inOpenSet(u(1),u(2))==0
                openSet=[openSet;[u(1),u(2)]];
                inOpenSet(u(1),u(2))=1;
            end
        end
    end
    
    %{
    
    f_score
    g_score
    openSet
    closeSet
    inOpenSet
    inCloseSet
    current
    cameFrom_x
    cameFrom_y
    break 
    %}
    pause(0.1);
end

end