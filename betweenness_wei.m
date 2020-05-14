function [bc nbc]=betweenness_wei(graph)

%BETWEENNESS_WEI    Node betweenness centrality
%
%   BC = betweenness_wei(graph);
%
%   Node betweenness centrality is the fraction of all shortest paths in 
%   the network that contain a given node. Nodes with high values of 
%   betweenness centrality participate in a large number of shortest paths.
%
%   Input:      L,      Directed/undirected connection-length matrix.
%
%   Output:     BC,     node betweenness centrality vector.
%              NBC,     normalized node betweenness centrality vector.
%   Notes:
%       The input matrix must be a connection-length matrix, typically
%   obtained via a mapping from weight to length. For instance, in a
%   weighted correlation network higher correlations are more naturally
%   interpreted as shorter distances and the input matrix should
%   consequently be some inverse of the connectivity matrix. 
%   Betweenness centrality may be normalised to the range [0,1] as
%   BC/[(N-1)(N-2)]/2, where N is the number of nodes in the network.

%Stavros Dimitriadis, 5/2009


[N N]=size(graph);


nbc=zeros(1,N);

[d p] = all_shortest_paths(sparse(graph));



for k=1:N
 
        spl=graphpred2path(p,k);
      for g=1:N  
        path=spl{g};
        
        if length(path) > 2 
            for k=2:length(path)-1
                nbc(path(k))=nbc(path(k)) + 1;
            end
        end
    end
end
  
%nosp=((N-1)*(N-2))/2;
bc=bc/mean(nbc);

    
    