function main(v0, vt, img, rows, cols)
% implementation: main([5 35],[25 5],"map3.bmp",40,40)
tic
%{
% the valid range for the coordinate in the map is from (1,1) to (m,n)
map = ones(mapsize(1), mapsize(2));

% defining obstacles
n = size(obstacles,1);
for i=1:n
    map(obstacles(i,1),obstacles(i,2)) = 0;
end

plotMap(map);
%}

map=buildMap(img,rows,cols);
plotMap(map);

% plotting the start position
plotCircle(v0(1), v0(2), 'b');

% plotting the target position
plotCircle(vt(1), vt(2), 'c');

% moving in 8 directions
path = AStar8(v0, vt, map); 

% moving in 4 directions
%path = AStar4(v0, vt, map);

if size(path,1) > 0
    plot(path(:,1),path(:,2),'c','LineWidth',3);
    hold on;
end
toc
end