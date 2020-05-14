function Lc = lev_centrality(CIJ)


%Lc = lev_centrality(CIJ)

%Leverage centrality is a measure of the relationship between the degree of
%a given node (ki) and the degree of each of its neighbors (kj), averaged over all neighbors (Ni), 
    
%Reference:Joyce KE, Laurienti PJ, Burdette JH, Hayasaka S (2010) A New
%Measure of Centrality for Brain Networks. PLoS ONE 5(8): e12200. doi:10.1371/journal.pone.0012200

%DIMITRIADIS STAVROS 9/2012

N=length(CIJ);                        %number of nodes
Lc=zeros(N,1);                       %leverage centrality
degree=sum(CIJ,2);                   %degree of each node

for u=1:N
    V=find(CIJ(u,:));                 %neighbors
     k=length(V);                   %degree of the current node
     
        for neigh=1:k                        %degree must be at least two
            Lc(u)=Lc(u) +(k - degree(V(neigh)))/(k + degree(V(neigh)));    
        end
        Lc(u)=Lc(u)/k;
end
 
