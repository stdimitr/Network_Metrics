function [clust mclust]=clustering_coefficient_wd(w,mask)



%INPUT: w = weighted undirected matrix -graph
%    mask = define neighborhood of each node
%OUTPUT:clust = a vector 1 x n which denotes clustering coefficient for each node
%       mclust = mean clustering coefficient of the graph
%DIMITRIADIS STAVROS 9/2009

[a b]=size(w);

clust(1:a)=0;
mclust=0;
meanl=0;
mask1(1:a,1:a)=0;

mask1=load(mask);
no=0;


for i=1:a
    k=sum(mask1.mask(i,:));
    subgraph(1:k,1:k)=0;
  
    
    [r c]=find(mask1.mask(i,:));
    
   for m=1:k
       for n=(m+1):k
           subgraph(m,n)=w(c(m),c(n));
           subgraph(n,m)=w(c(n),c(m));
       end
   end

   
   [C]=clustering_coef_wd(subgraph);
   clust(i)=mean(C);
    
end

mclust=mean(clust);
