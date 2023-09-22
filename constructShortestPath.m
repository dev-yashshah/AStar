function path = constructShortestPath(node, cameFrom_x, cameFrom_y)

path = [node];

x = node(1);
y = node(2);

while true
    if x == 0 || y == 0
        break;
    end
    
    previous_x = cameFrom_x(x, y);
    previous_y = cameFrom_y(x, y);
    
    path = [x,y; path];
    
    x = previous_x;
    y = previous_y;
end