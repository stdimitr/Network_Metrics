function partcoef=participation_coef_w(w,groups)
%P=participation_coef(A,Ci); computes nodal "participation coefficient".
%
%Input: weighted matrix A, community structure vector Ci.
%Output: participation coef P.
%Output for weighted graphs: weighted participation coef.
%
%Reference: Guimera R, Amaral L. Nature (2005) 433:895-900.
%

%DIMITRIADIS STAVROS 3/2012
%http://users.auth.gr/stdimitr/



n=length(w);                        %number of vertices

maxcl=max(groups);                  % total number of clusters


partcoef=zeros(1,n);

%create a cell in order to keep the maxcl clustering memberships
c=cell(1,maxcl);

for i=1:maxcl
    
    r=find(groups==i);
    
    
    c{i}=r;
    
end
    






for k=1:n % run separately for each node
    
    r=groups(k);      %find the cluster where each node belongs to
    
    
    
  totalstr=sum(w(k,:)); %total strength of the current node
    
  sum1=0;
    for i=1:maxcl % run separately for each  cluster
        
        neighbors=[k c{i}];
        
        noneigh=length(neighbors);
        
        subgraph=zeros(noneigh,noneigh);
        
        subgraph=w(neighbors, neighbors);
        
        
        substr=0;   %  strength of the current node within each module
        substr=sum(subgraph(1,:));
          
       
    %estimate participation coefficient
    sum1 = sum1 + (substr/totalstr)^2;
    
    end
      
      partcoef(k)=1 - sum1;
     
  
    
end % end of first for



           
         
        
    

end
