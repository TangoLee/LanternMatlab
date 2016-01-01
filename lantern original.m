init = [10];
tree = [5 6 7 9 10 16 18];
temple = [1 13 20];
stove = [4];
pier = [2 6 7 9 10 12 15];
water = [1 2 10 11 12 13 14 15 17 20];
rock = [4 10 11 14 17];
shrine = [1 3 5 8 10 13 16 18 19 20];  % the last switch

whole = 1 : 20;

tree = setdiff(tree, init);
temple = setdiff(temple, init);
stove = setdiff(stove, init);
pier = setdiff(pier, init);
water = setdiff(water, init);
rock = setdiff(rock, init);
shrine = setdiff(shrine, init);
rest = setdiff(whole, shrine);
rest = setdiff(rest, init);

switches = {tree, temple, stove, pier, water, rock};

dd = zeros(1,6);

for i = 1 : 6
    dd(i) = all(ismember(switches{i},rest));
end

ind = 1 : 6;
ind(find(dd == 0)) = [];
% dd = dd.*ind;
sw = {'tree', 'temple', 'stove', 'pier', 'water', 'rock'};
% a(find(a==0))=[];  % bad

switches(find(dd == 0)) = [];

m = size(switches,2);


index = zeros(m,m);

for i = 1 : m
    for j = 1 : m
        index(i,j) = ~isempty(intersect(switches{i},switches{j}));
    end
end

swc = [];
rest_cur = rest;

for i = 1 : m
    rest_cur = setdiff(rest_cur, switches{i});
    swc = [swc i];
    if isempty(rest_cur)
        disp(sw(ind(swc)));
        break;
    end
    cur_s = i;
    while ~isempty(rest_cur)
        % cur_s = min(find(index(cur_s,cur_s:m) == 1))+(cur_s-1);
        for j = (cur_s+1) : m
            if sum(index(swc,j)) == 0
                flag = 1;
                cur_s = j;
                break;
            else
                flag = 0;
            end
        end
        if flag == 0
            break;
        end
        
        swc = [swc cur_s];
        rest_cur = setdiff(rest_cur, switches{cur_s});
    end
    if isempty(rest_cur)
        disp(sw(ind(swc)));
        break;
    else
        swc = [];
        rest_cur = rest;
    end
end