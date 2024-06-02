function  [] = Q_MainFunPRank(a, cin,cout, r_set, QC,K,lambda ) 
% % %--------------------------------------------------------------------------------------------
%  Q_MainFunPRank: Fixed r_set and studied the effect of QC on time for various algorithms          
%               a:  sparse matrix
%             cin:  in-link damping factor
%            cout:  out-link damping factor
%           r_set:  # of iterations(PR_IT) and target low-rank(PR_NI,PR_Our) 
%              QC:  multi-source query size 
%               K:  # of subspace iterations 
%          lambda:  weighting hyperparameter constant
% %
% %-----------------------------------------------------------------------------------------------

Co = numel(QC);                  % the size(or length) of the array QC  
r = r_set;                       % assign r_set to r

% preprocessing stage of algorithm PR_NI and PR_our
[ Pre_Time_NI, V1,V2,u1,u2 ]= PrePR_NI(a, cin,cout,lambda, r);              % the preprocessing phase of PR_NI
[Temp_Iter_Non, F1,N1,x1  ] = PrePR_our( a, cin,cout,lambda, r, K );  % the preprocessing phase of PR_our


for i = 1:Co
     % randomly generate query node set que
     que = randperm(size(a,1), QC(i));                                      
     fprintf('>>>>>>>\n   r = %d,  SamNumb = %d\n',r, QC(i)); 
     
     % query stage of algorithm PR_NI and PR_our
     % % % Algorithm:  PR_NI
     Que_PR_NI(Pre_Time_NI, que,u1,V1, u2, V2 );             % query stage of  PR_NI 
     
     
     % % % Algorithm:  PR_our
     QuePR_Our(cin,cout,lambda, Temp_Iter_Non, F1,N1,x1, que);    % query stage of PR_our
  
end

end