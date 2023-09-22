function index = findLowestF(set, f_score)

n = size(set, 1);

min = f_score(set(1,1), set(1,2));
index = 1;

for i=2:n
    if min > f_score(set(i,1), set(i,2))
        min = f_score(set(i,1), set(i,2));
        index = i;
    end
end

end