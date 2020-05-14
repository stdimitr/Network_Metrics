function L = laplacian(A)
% LAPLACIAN : Laplacian matrix of a graph.
%
% L = laplacian(A)  returns a matrix whose nonzero structure is that of A+A'
%             (including any explicit zeros in A) with all values -1,
%             plus a diagonal to make all row sums zero.
%             This is the Laplacian matrix of the graph, which is positive
%             semidefinite, with an eigenvalue 0 of multiplicity equal to
%             the number of connected components.
%

%
% DIMITRIADIS STAVROS MAY 2008

[n,m] = size(A);
if n ~= m, error ('Matrix must be square.'), end
L = - spones(A|A');
L = L - diag(sum(L));
if ~issparse(A)
    L = full(L);
end;
