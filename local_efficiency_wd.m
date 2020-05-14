function [le mle]=local_efficiency_wd(w)

%calculate global efficiency
%INPUT: w =directed weighted connectivity matrix
%OUTPUT:le_node = local efficiency per node
%       mle = mean local efficiency of the network

%Adopted from Rubinov & Sporns, "Complex network measures of brain connectivity: Uses and interpretations"
%2010 Neuroimage,p.8 Table1A

%Stavros Dimitriadis, 5/2009

tic


    N=length(w);                        %number of nodes
    le=zeros(N,1);                       %local efficiency
    A=threshold_abs(w,0);               %adjacency matrix
    
     w1=1./w;                         
   
       for k=1:N
        for l=1:N
            if(w(k,l)==0)
                w1(k,l)=0;
            end
        end
    end       
    
    for u=1:N
        Vout=find(w(u,:));                 %find outcoming connections
        Vin=find(w(:,u));                %find incoming connections
        
        [id od deg]=degrees_dir(w);        %take the degrees 
        
        V=[Vout Vin'];                       %concatenate incoming and outcoming connections
        %e=distance_wei(w1(V,V));
        [e,P] = all_shortest_paths(sparse(w1(V,V)));
            e=1./e;
        
        if (id(u) + od(u)) >= 2                %indegree plus outdegree must be at least 2
            
           
            %concatenate Vout and Vin and find unique elements
            conc=[Vout , Vin'];
            conc=unique(conc);
            
            sum1=0;
            for k=1:length(conc)
                sum1=sum1 + A(u,conc(k))*A(conc(k),u);
            end
            
            sum1=((od(u)+id(u))*(od(u)+id(u)-1)-2*sum1);
            
            
            
            % for outcoming connections
            for k=1:length(conc)-1
                le(u)=le(u) + ((A(u,conc(k)) + A(u,conc(k)))*(A(u,conc(k+1)) + A(u,conc(k+1)))*(e(k,k+1) + e(k+1,k)));
            end
              le(u)=le(u)/sum1;
        end % end of if
        
      
        
    end% end of for
    
    mle=0;
    
    mle=sum(le)/(2*N);
    
    toc
            