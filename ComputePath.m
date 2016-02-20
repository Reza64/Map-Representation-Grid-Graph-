function [path,dist]=ComputePath(G,n1,n2)
if (size(n1,2) ~= size(n2,2))
    disp('The size of the input vectors are mismatch!');
    return
end
for i=1:size(n1,2)
    [path(i).dist,path(i).points,pred] = graphshortestpath(G.g,n1(i),n2(i));
     if(isinf(path(i).dist))
        path(i).points=0;
        path(i).dist=-1;
       fprintf('point(%d,%d) is invalid on the map!\n',n1(i),n2(i));
     end
end


