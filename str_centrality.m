function str=str_centrality(CIJ)


%	STRENGTH_CENTRALITY      Strength measure of centrality
%
%   v = eigenvector_centrality_und(CIJ)
%
%   Strength/Degree centrality for weighted/binary networks correspondingly
%   is a centrality measure that quantify the importance of each node
%   according to the number of connections (degree) or the average strength
%   of its connection (weights).
%
%   Inputs:     CIJ,        binary/weighted undirected adjacency matrix.
%
%   Outputs:      str       average strength connection of each node with
%                           the rest of the network
%
%   Reference: A. Barrat, M. Barthe´lemy, R. Pastor-Satorras, and A. Vespignani, “The
%               architecture of complex weighted networks,” Proc. Natl. Acad. Sci. U.S.A.
%                101, 3747–3752 (2004).
%
%  Dimitriadis Stavros 8/2012


str=sum(CIJ,2)/(length(CIJ)-1);

