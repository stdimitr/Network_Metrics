function part=hub_score_shortest_path(w)

%The input matrix must be a mapping from weight to distance (eg. higher
%correlations may be interpreted as short distances - hence an inverse
%mapping is appropriate in that case).

%%%%%%%%% enumerate the number of shortest paths passing through
%each node and then  divide by the total number of paths


%DIMITRIADIS STAVROS 6/2010
%http://users.auth.gr/stdimitr/

n=length(w);


%count all the paths
count=0;

part=zeros(1,n);

hist1=zeros(1,6);

for i=1:n

     
    [d pred] = dijkstra_sp(sparse(w),i);
    
    
    for j=(i+1):n
        count=count+1;
        [path P] = path_from_pred(pred,j);
        
        len=length(path);
        
        hist1(len-1)=hist1(len-1) + 1;
        
        if len > 2
            for i=2:len-1
                part(path(i))=part(path(i))+1;
            end
        end
        
        
    end
    
end

part=part/count;
