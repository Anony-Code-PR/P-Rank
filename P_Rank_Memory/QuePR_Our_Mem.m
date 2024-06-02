function [ ] = QuePR_Our_Mem(cin,cout,lambda, premax_men, F,N,x, que)
% % %--------------------------------------------------------------------------------------------
%    QuePR_Our_Mem: obtain the PR_our total memory
%              cin:  in-link damping factor
%             cout:  out-link damping factor
%           lambda:  weighting hyperparameter constant
%     Pre_Time_Our: the preprocessing time of PR_our
%       F, N and X:  intermediate matriices
%              que:  query nodes
%          notice:   For multi-source queries, our algorithm can use the column-by-column online query trick to greatly save online query memory
% % %--------------------------------------------------------------------------------------------


    % implement PR_our multi-source queries
    Co = numel(que);                          % the number of columns of array que
    n =size(F,1);                             % the number of rows in the matrix F
    
    % % % Compute similarity s_our 
    max_men = 0;
    for i = 1:Co                              % use the column-by-column online query trick to greatly save online query memory
        Res1 =  F*x*(F(que(i),:))';
        Res2 = N*x*(N(que(i),:))';

        idn_p = sparse(que(i), 1, 1, n, 1);     % The sparse unit vector corresponding to the query node
        s_our =  (cin *lambda * (Res1-sparse(que(i), 1, diag(Res1(que(i),:)), n, 1 ))+ cout * (1-lambda)*(Res2 - sparse(que(i), 1, diag(Res2(que(i),:)), n, 1 ) )) + idn_p;  % The unit vector corresponding to the query node)+ cout * (1-lambda)*(Res2-vec2 ))+ idn_p;
        men = whos;
        max_men = max(max_men, sum([men.bytes]));
        clear Res1 Res2 idn_p s_our
    end
    
    Que_max_men = max_men/(1024^2);

    
    fprintf('>>>>>>>>>>Algorithm (Que_PR_our_Mem)          PreMemory: %f MB;     QueMemory: %f MB;   TotalMemory: %f MB\n ',   premax_men/(1024^2),  Que_max_men,  max(premax_men/(1024^2), Que_max_men) );  
    
    
end



      

