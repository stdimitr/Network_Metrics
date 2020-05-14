function [le mle]=local_efficiency_wu1(w)


%calculate local efficiency
%INPUT: w =undirected weighted connectivity matrix
%       The estimation of nodal LE based on its functional neighborhood whithout spatial restriction
%OUTPUT:le_node = local efficiency per node
%       mle = mean local efficiency 

%Adopted from Rubinov & Sporns, "Complex network measures of brain connectivity: Uses and interpretations"
%2010 Neuroimage,p.8 Table1A

%Stavros Dimitriadis, 5/2009

tic


    N=length(w);                        %number of nodes
    le=zeros(N,1);                       %local efficiency
    
   ind = w~=0;
   w(ind) = 1./w(ind);
   w1=1./w;
   
    for u=1:N
    
        V=find(w(u,:));                 %neighbors
        degree=length(V);                    %degree
        
        if (degree >= 2)                %degree must be at least 2

            e=(all_shortest_paths(sparse(w(V,V)) .* (w(V,u)*w(u,V)) )).^(1/3) ;
         
            ind = e~=0;
           e(ind)=1./e(ind);
            deg=degree*(degree-1);
            le(u)=sum(e(:))/deg;
        end
    end
    
    mle=sum(le)/N;
    
    toc
    
    
    