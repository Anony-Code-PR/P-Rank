function [ ] = QuePR_NI_Acc( que,u1,V1, u2, V2, S_it )
% % %--------------------------------------------------------------------------------------------
%     QuePR_NI_Acc: compute multi-source queries matrix of PR_NI and evaluate how the accuracy of PR_NI is affected by low rank r using AvgDiff     
%              que:  query nodes
%   u1, u2, V1, V2:  intermediate matriices
%             S_it:  excat P-Rank similarity matrix
%     
% % %--------------------------------------------------------------------------------------------
  
 
    % implement PR_NI multi-source queries
    Co = size(que,2);                                                     % the number of columns of array que
    n = size(u1,1 );                                                      % the number of rows in the matrix u1
    idn_p = sparse(que, 1:Co, 1, n, Co);                                  % according to que, [1:Co] and 1 triple generate a (n x Co) sparse matrix idn_p
    S_PRNI = (1-cin*lambda-(1-lambda)*cout)*(u1*V1*(u1(que,:))' + u2*V2*(u2(que,:))' + idn_p);             %  compute similarity matrix S_PRNI
    AvgDiff = sum(sum(abs( S_PRNI - S_it(:,que) )))/(n * size(que,2));    % compute AvgDiff
    fprintf('>>(PR_NI_AvgDiff):                  AvgDiff = : %3.7f\n',    AvgDiff ); 




end   