function [le meanl]=local_efficiency_wu(w,mask)


%INPUT: w = weighted matrix -graph
%    mask = define neighborhood of each node
%OUTPUT:le = a vector 1 x n which denotes local efficiency for each node
%       meanl = mean local efficiency of the graph

n=length(w);
le=zeros(n,1); 

meanl=0;

for no=1:n
  
    
    neighbors=find(mask(no,:));
    k=length(neighbors);
    subgraph=zeros(k,k);
    distance=zeros(k,k);
    
 
subgraph=w(neighbors,neighbors);

   %inverse subgraph
  
   for m=1:k
       for n=(m+1):k
           if(subgraph(m,n)~=0)
                subgraph(m,n)=1./subgraph(m,n);
                subgraph(n,m)=subgraph(m,n);
           end
       end
   end 
  
  [d] = all_shortest_paths(sparse(subgraph)); 
  
  %inverse distance
  for m=1:k
       for n=(m+1):k
           if(d(m,n)~=0)
                distance(m,n)=1./d(m,n);
                distance(n,m)=distance(m,n);
           end
       end
  end 
  
 
   pairs=(k*(k-1))/2;
   le(no)=(sum(sum(triu(distance))))/pairs;
  
    
end


meanl=mean(le);


