function Cs = sg_centrality(A)
% SG_CENTRALITY(A) computes the subgraph centralities of the network 
% represented by the adjacency matrix A. It returns a vector of subgraph
% centralities for each node of the network (as they are ordered in the
% adjacency matrix.)

%Reference:Estrada, E.; Rodriguez-Velazquez, J.A. (2005). "Subgraph centrality in complex networks". Phys. Rev. E 71 (5): 056103. 

%Dimitriadis Stavros 9/2012

[V,lambda] = eig(A);                   % Compute the eigenvectors and
lambda     = diag(lambda);             % eigenvalues.
V2         = V.^2;                     % Matrix of squares of the eigenvectors elements.
Cs         = real(V2 * exp(lambda));   % Compute eigenvector centrality. Lop off imaginary part remaining due to precision error.