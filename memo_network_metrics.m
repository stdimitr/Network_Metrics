
%Please refer to this mini toolbox as:
%Dimitriadis et al., 2010 Tracking brain dynamics via time-dependent network analysis.)
%wd - > weighted directed graph
%wu -> weighted undirected graph


%create a random w functional connectivity graph (FCG)
no=64;

%directed weighted graph
wd=rand(no,no);

%inverse weighted directed graph
dd=1./wd;
for i=1:no
    dd(i,i)=0;
end


%undirected weighted graph
for i=1:no
    for j=(i+1):no
        wu(i,j)=wd(i,j);
        wu(j,i)=wu(i,j);
    end
end

%inverse weighted undirected graph
du=1./wu;
for i=1:no
    du(i,i)=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% SHORTEST PATH LENGTH & CLUSTERING COEFFICIENT %%%%%%%%%%%%%%%%%%%%%%%
%Compute weighted shortest path length, distance matrix and detect
%significant edges via a new threshold scheme based on DIjkstra's algorithm 
%(see Dimitriadis et al., 2010 Tracking brain dynamics via time-dependent network analysis.)

% clustering coefficient with spatial orientations 
%a) for weighted undirected graphs
[binary distance lnode meanl]=spl_wu(du);

%b) for weighted directed graphs
[binary distance lnodein lnodeout meanlin meanlout]=spl_wd(dd);


% clustering coefficient with spatial orientations 
%%It needs an adjacency matrix where 1s refers to its neighbors
%an exemplar was showed with 64 EEG sensors
%a) for weighted undirected graphs
[clust mclust]=clustering_coefficient_wu(wu,'mask64.mat');

%b) for weighted directed graphs
[clust mclust]=clustering_coefficient_wd(wd,'mask64.mat');


%%%%%%%%%%%%%%%%%%%%%%%% GLOBAL & LOCAL EFFICIENCY %%%%%%%%%%%%%%%%%%
%For global & local efficiency see Latora & Macchiori,"Efficient Behavior
%of Small-World Networks", Physical Review Letters,2001
%compute global and nodal efficiency

%a) for weighted undirected graph
[gl_node gl]=global_efficiency_wu(du);

%b) for weighted directed graph
[gl_node gl]=global_efficiency_wd(dd);

% local efficiency based on weighted undirected/directed graphs
% estimation of local efficiency based on a subgraph that includes all the connections of each node
% with the rest of the network without spatial restrictions
% a)local efficiency based on weighted undirected graphs according to the
% definition in "Complex network measures of brain connectivity: Uses and
% interpretations" Mikail Rubinov Olaf Sporns Neuroimage 2011 see table A1
[le mle]=local_efficiency_wu1(wu);

%b)local efficiency based on weighted directed graphs
[le meanl]=local_efficiency_wd(wd);

%c) estimation of local efficiency based on the subgraph consists of its
%immediate (1st) spatial neighbors according to 10-20 IS
%It needs an adjacency matrix where 1s refers to its neighbors
%an exemplar was showed with 64 EEG sensors

%One can use different mask files that keeps the 1st,2nd,3rd ... neighbors of each node 
%in order to unfold the hierarchical features of a connectivity graph as proposed in
%Costa & Sporns,"Hierarchical features of large-scale cortical connectivity",Eur. Phys. J. B 48, 567–573 (2005)
% here we used stable definitions of the neighborhood ergarding 10-20 IS in
% EEG or similar in MEG sensor level
[le meanl]=local_efficiency_wu(wu,'mask64.mat');

%d) Definition of 1st,2nd,3rd ... neighbors of each node can be defined
%based on Dijkstra's algorithm 
%Nodes that connect with a reference with a path length equals to 1 constituted
% each 1st neighborhood


%e)estimation of local efficiency defined in a similar way with the
%original definition in binary graphs in
%Latora, V., Marchiori, M., 2001. Ef?cient behavior of small-world networks. Phys. Rev.
%Lett. 87, 198701
[le meanl]=local_efficiency_wu2(wu);


%f) estimation of participation coefficient based on weighted graphs
%you need to partition your graph in order to get the groups
partcoef=participation_coef_w(wu,groups);



%the mini-toolbox contains also:
%1)degrees_und, degrees_dir, distance_wei,clust_coef_wu, clust_coef_wd functions from BCT
%2)dijkstra's algorithm implemented in mex-files from BGL toolbox -Stanford
