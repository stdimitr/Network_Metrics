function [binary distance lnode meanl]=spl_wu(w)



%calculate weighted shortest path length
%INPUT: w =inverse WEIGHTED MATRIX
%OUTPUT:binary = adjacency matrix which keeps the significant paths (edges)
%      distance = output of the dijkstra algorithm
%       lnode = mean shortest path length per node
%       meanl =  shortest path length of the network

%Stavros Dimitriadis, 5/2009


[a b]=size(w);


distance(1:a,1:a)=0;
binary(1:a,1:a)=0;

l=0;
for i=1:a
    for j=(i+1):a
        [r_path, r_cost] = dijkstra(sparse(w),i,j);
        distance(i,j)=r_cost;
        distance(j,i)=r_cost;
        
        for k=1:length(r_path)-1
            binary(r_path(k),r_path(k+1))=1;
            binary(r_path(k+1),r_path(k))=binary(r_path(k),r_path(k+1));
        end
    end
end


for i=1:a
    ans=find(isfinite(distance(i,:))==1);
    ans(find(ans==i))=[];
    sum1=sum(distance(i,ans));
    lnode(i)=sum1/length(ans);
end

meanl=mean(lnode);
