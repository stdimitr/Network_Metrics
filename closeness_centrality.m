function cl_cen=closeness_centrality(CIJ)


%	CLOSENESS_CENTRALITY      Strength measure of centrality
%
%   cl_cen=closeness_centrality(CIJ)
%
%   Closeness and betweenness centrality rely on the concept
%   of shortest paths. On a weighted network, paths can be
%   defined by assuming the length of a link to vary inversely
%   with its weight.
% %
%   Inputs:     CIJ,        binary/weighted undirected adjacency matrix.
%
%   Outputs:    cl_cen      average length of shortest paths that connect
%                           each node with the rest of the network
%
%   Reference:[1] M. E. J. Newman, �Analysis of weighted networks,� Phys. Rev. E 70,
%             056131 (2004).
%             [2]T. Opsahl, F. Agneessens, and J. Skvoretz, �Node centrality in weighted
%             networks: Generalizing degree and shortest paths,� Soc. Networks 32,
%             245�251 (2010).
%
%  Dimitriadis Stavros 8/2012



n=length(CIJ);
cl_cen=zeros(1,n);

%count all the paths

if CIJ(1,2)==1
    p=distance_bin(CIJ);
    
    
    cl_cen=(n-1)./sum(p,2);
else
    [d p]=distance_wei(1./CIJ);
    
    
    cl_cen=(n-1)./sum(p,2);
end



    