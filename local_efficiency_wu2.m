function [le meanle]=local_efficiency_wu2(w)



%INPUT: w = weighted matrix -graph
%OUTPUT:le = a vector 1 x n which denotes local efficiency for each node
%       meanl = mean local efficiency of the graph

%% eliminate the connections of each node in order to 
%quantify the importance of each node in the connection of each
%neighborhood

n=length(w);
le=zeros(n,1); 

meanl=0;
mask1(1:n,1:n)=0;

%mask1=load(mask);
no=0;

deg=degrees_und(w);


for i=1:n

    k=deg(i);
    subgraph=zeros(k,k);
    distance=zeros(k,k);
    
    neighbors=find(w(i,:));

    neighbors(neighbors==i)=[];
    if k >= 2
        subgraph=w(neighbors,neighbors);

   %inverse subgraph
  
   for m=1:length(neighbors)
       for n=(m+1):length(neighbors)
           if(subgraph(m,n)~=0)
                subgraph(m,n)=1./subgraph(m,n);
                subgraph(n,m)=subgraph(m,n);
           end
       end
   end 
  
  [d] = all_shortest_paths(sparse(subgraph)); 
  
  %inverse distance
  for m=1:length(neighbors)
       for n=(m+1):length(neighbors)
           if(d(m,n)~=0)
                distance(m,n)=1./d(m,n);
                distance(n,m)=distance(m,n);
           end
       end
   end 
  
   no=(k*(k-1))/2;
   le(i)=(sum(sum(triu(distance))))/no;
   
    end
    
end

meanle=0;
meanle=mean(le);


