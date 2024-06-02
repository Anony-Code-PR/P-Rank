function  [] = Q_MainFunPR_Mem(a, cin,cout, r_set, QC,K, lambda) 

% % %--------------------------------------------------------------------------------------------
% Q_MainFunPR_Mem: Fixed r_set and studied the effect of QC on memory for various algorithms          
%               a:  sparse matrix
%             cin:  in-link damping factor
%            cout:  out-link damping factor
%           r_set:  # of iterations(PR_IT) and target low-rank(PR_NI,PR_Our) 
%              QC:  multi-source query size 
%         epsilon:  desired accuracy
%              K :  # of subspace iterations by default
% %
% %-----------------------------------------------------------------------------------------------


Co = numel(QC);                  % the size(or length) of the array QC  
r = r_set;                       % assign r_set to r

% preprocessing stage of algorithm PR_NI and PR_our
[premax_men_NI, u1,u2,V1,V2 ]= PrePR_NI_Mem(a, cin,cout,lambda, r) ;            % the preprocessing phase of PR_NI
[premax_men_our, F,N,x  ] = PrePR_our_Mem( a, cin,cout,lambda, r, K );    % the preprocessing phase of PR_our



for i = 1:Co
    
     % randomly generate query node set que
     que = randperm(size(a,1), QC(i));                                      
     fprintf('>>>>>>>\n   r = %d,  SamNumb = %d\n',r, QC(i)); 


     % query stage of algorithm PR_NI and PR_our
     % % % Algorithm:  PR_NI  
      QuePR_NI_Mem( premax_men_NI, u1,u2,V1,V2,que);                     % query stage of  PR_NI 
     
     
     % % % Algorithm:  PR_our
     QuePR_Our_Mem(cin,cout,lambda, premax_men_our, F,N,x, que);         % query stage of PR_our
end

end