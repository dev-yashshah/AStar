function est = h(v, vt)

% using Euclidean distance for the heuristic function
%est = norm(vt - v);

% using Manhattan distance
est = abs(v(1) - vt(1)) + abs(v(2) - vt(2));

end