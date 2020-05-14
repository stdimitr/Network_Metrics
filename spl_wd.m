function [binary distance lnodein lnodeout meanlin meanlout]=spl_wd(w)



%calculate weighted shortest path length
%INPUT: w =inverse WEIGHTED MATRIX
%OUTPUT:binary = adjacency matrix which keeps the significant paths (edges)
%      distance = output of the dijkstra algorithm
%       lnodein = mean input shortest path length per node
%       lnodeout = mean output shortest path length per node
%       lnodein = mean input shortest path length per node
%       lnodeout = mean output shortest path length per node
%       meanlin = mean input shortest path length across nodes
%       meanlout = mean output shortest path length across nodes

%Stavros Dimitriadis, 5/2009


[a b]=size(w);


distance=zeros(a,a);
binary=zeros(a,a);
lnodein=zeros(1,a);
meanlin=zeros(1,a);
lnodeout=zeros(1,a);
meanlout=zeros(1,a);

l=0;
for i=1:a
    for j=(i+1):a
        [r_path, r_cost] = dijkstra(sparse(w),i,j);
        distance(i,j)=r_cost;
        
        
        for k=1:length(r_path)-1
            binary(r_path(k),r_path(k+1))=1;
        end
    end
end




l=0;
for i=1:a
    for j=(i+1):a
        [r_path, r_cost] = dijkstra(sparse(w),j,i);
        distance(j,i)=r_cost;
        
        
        for k=1:length(r_path)-1
            binary(r_path(k),r_path(k+1))=1;
        end
    end
end




for i=1:a
    ans=find(isfinite(distance(i,:))==1);
    ans(find(ans==i))=[];
    sum1=sum(distance(i,ans));
    lnodein(i)=sum1/length(ans);
end

meanlin=mean(lnodein);

for i=1:a
    ans=find(isfinite(distance(:,i))==1);
    ans(find(ans==i))=[];
    sum1=sum(distance(ans,i));
    lnodeout(i)=sum1/length(ans);
end

meanlout=mean(lnodeout);
