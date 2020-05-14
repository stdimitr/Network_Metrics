function a_cen=alpha_centrality(A)
% 
% P. Bonacich and P. Lloyd. Eigenvector-like measures of centrality for asymmetric relations. Social Networks, 23(3):191-201, 2001.
% P. Bonacich. Power and Centrality, a family of measures. 1987
% S. Borgatti. Centrality and network flow. Social Networks, 27(1):55{71, January 2005.
% R. Ghosh and K. Lerman. Parameterized centrality metric for network analysis. Physical Review E, 83(6):066118, 2011.

N=size(A,1);	
t=ones(N,1);

a=0.1; % damping factor has to be smaller than 1/lambda0, where lambda0 is largest eigenvalue of A	
s=A*t;	
a_cen=s;	

for i=1:20	
    a_cen=s+a*A*a_cen;	
end	
a_cen