function [ ] = QuePR_our_Acc(cin,cout,lambda, F,N, X, que, S_it)
% % %--------------------------------------------------------------------------------------------
%    QuePR_our_Acc: compute multi-source queries matrix of PR_our and evaluate how the accuracy of PR_our is affected by low rank r using AvgDiff
%              cin:  in-link damping factor
%             cout:  out-link damping factor
%           lambda:  weighting hyperparameter constant
%     Pre_Time_Our: the preprocessing time of PR_our
%       F, N and X:  intermediate matriices
%              que:  query nodes
%     
% % %--------------------------------------------------------------------------------------------

    % implement PR_our multi-source queries
    Co = numel(que);                          % the number of columns of array que
    n = size(F,1);                             % the number of rows in the matrix F
    
    % Compute similarity s_our
    idn_p = sparse(que, 1:Co, 1, n, Co);      % The sparse unit vector corresponding to the query node
    Res1 =  F*X*(F(que,:))';
    Res2 = N*X*(N(que,:))';
    vec1 = sparse(que, 1:Co, diag(Res1(que,:)), n, Co );
    vec2 = sparse(que, 1:Co, diag(Res2(que,:)), n, Co );
    s_our =  (cin *lambda * (Res1-vec1)+ cout * (1-lambda)*(Res2-vec2 )) + idn_p;   % compute similarity matrix s_our
    
    AvgDiff = sum(sum(abs( s_our - S_it(:,que) )))/(n * size(que,2));  %  compute AvgDiff
    
    fprintf('>>(PR_Our_AvgDiff):                 AvgDiff = : %3.7f\n',    AvgDiff ); 
end



      

