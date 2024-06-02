function [ ] = QuePR_Our(cin,cout,lambda, Pre_Time_Our, F,N,X, que)
% % %--------------------------------------------------------------------------------------------
%        QuePR_Our: obtain the PR_our query time and total time
%              cin:  in-link damping factor
%             cout:  out-link damping factor
%           lambda:  weighting hyperparameter constant
%     Pre_Time_Our: the preprocessing time of PR_our
%       F, N and X:  intermediate matriices
%              que:  query nodes
%     
% % %--------------------------------------------------------------------------------------------
  
    Que = tic;                                % Start the clock
    
    % implement PR_our multi-source queries
    Co = numel(que);                          % the number of columns of array que
    n =size(F,1);                             % the number of rows in the matrix F
    
    % Compute similarity s_our
    idn_p = sparse(que, 1:Co, 1, n, Co);      % The sparse unit vector corresponding to the query node
    Res1 =  F*X*(F(que,:))';
    Res2 = N*X*(N(que,:))';
    vec1 = sparse(que, 1:Co, diag(Res1(que,:)), n, Co );
    vec2 = sparse(que, 1:Co, diag(Res2(que,:)), n, Co );
    s_our =  (cin *lambda * (Res1-vec1)+ cout * (1-lambda)*(Res2-vec2 )) + idn_p;   % compute similarity matrix s_our
    quetrTime = toc( Que  );                   % obtain query time of PR_our
    fprintf('>>>>>>>>>>Algorithm (QuePR_our)                PreTime_Our: %f s;        QueTime_Our: %f s;        TotalTime_Our: %f s\n',  Pre_Time_Our, quetrTime, Pre_Time_Our + quetrTime);  

end



      

