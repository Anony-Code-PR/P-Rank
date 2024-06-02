function  [] = R_MainFunPRank(a, cin,cout, r_set,lambda, K,QC)
% % %--------------------------------------------------------------------------------------------
%  R_MainFunPRank: Fixed QC and studied the effect of r_set on time for various algorithms          
%               a:  sparse matrix
%             cin:  in-link damping factor
%            cout:  out-link damping factor
%           r_set:  # of iterations(PR_IT) and target low-rank(PR_NI,PR_Our) 
%          lambda:  weighting hyperparameter constant
%               K:  # of subspace iterations 
%              QC:  multi-source query size 
% % %--------------------------------------------------------------------------------------------

% Randomly generate QC query nodes
que = randperm(size(a,1), QC);    % que: The generated query node set 

% Analysis the impact of r on time for three algorithms   
r = r_set;                        %  assign r_set to r
for i =1:numel(r)                 % numel(r): the size/length of the array r
       
     fprintf('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n   r = %d,  SamNumb = %d\n',r(i), QC); 

         % % % Algorithm: PR_IT
         PR_IT(a, cin,cout,r(i),lambda);          % Iterative algorithm
        
         
         % % % Algorithm: PR-NI
         [Pre_Time_NI, V1,V2,u1,u2 ]= PrePR_NI(a, cin,cout,lambda, r(i));
         Que_PR_NI(Pre_Time_NI, que,u1,V1, u2, V2 );
         clear u1 V1  u2  V2;     
 

         % % % Algorithm:  PR_our  
         [Temp_Iter_Non, F,N, x] = PrePR_our( a, cin,cout,lambda, r(i), K ); 
         QuePR_Our(cin,cout,lambda, Temp_Iter_Non, F,N,x, que); 
         clear F N x ;

      
end

end


