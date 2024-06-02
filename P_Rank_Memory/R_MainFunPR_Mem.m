function  [  ] = R_MainFunPR_Mem(a, cin,cout, r_set,lambda, K,QC)
% % %--------------------------------------------------------------------------------------------
%   R_MainFunPR_Mem:  Fixed QC and studied the effect of r_set on memory for various algorithms          
%                 a:  sparse matrix
%               cin:  in-link damping factor
%              cout:  out-link damping factor
%             r_set:  # of iterations(PR_IT) and target low-rank(PR_NI,PR_Our) 
%            lambda:  weighting hyperparameter constant
%           epsilon:  desired accuracy
%                QC:  multi-source query size 
% % %--------------------------------------------------------------------------------------------

% Randomly generate QC query nodes
que = randperm(size(a,1), QC);    % que: The generated query node set 

% Analysis the impact of r on time for three algorithms   
r = r_set;                        %  assign r_set to r

for i =1:numel(r)                 % numel(r): the size/length of the array r
       
     fprintf('>>>>\n   r = %d,  SamNumb = %d\n',r(i), QC); 

       % % % Algorithm: PR_IT
        PR_IT_Mem(a, cin,cout,r(i),lambda)               % Iterative algorithm
       
       % % % Algorithm: PR_NI  
       [premax_men_NI, u1,u2,V1,V2 ]= PrePR_NI_Mem(a, cin,cout,lambda, r(i)) ; 
       QuePR_NI_Mem( premax_men_NI, u1,u2,V1,V2,que); 
        
      
       % % % Algorithm: PR_Our 
      [premax_men_our, F,N,x  ] = PrePR_our_Mem( a, cin,cout,lambda, r(i), K );
      QuePR_Our_Mem(cin,cout,lambda, premax_men_our, F,N,x, que)
      fprintf('\n');
        
end

end


