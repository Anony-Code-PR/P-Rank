function [ ] = Que_PR_NI(Pre_Time_NI, que, u1,V1, u2, V2 )
% % %--------------------------------------------------------------------------------------------
%        Que_PR_NI: obtain the PR_NI query time and total time
%      Pre_Time_NI: the preprocessing time of PR_NI
%              que:  query nodes
%   u1, u2, V1, V2:  intermediate matriices
%     
% % %--------------------------------------------------------------------------------------------
  
    Que = tic;                                                  % Start the clock
    
    % implement PR_NI multi-source queries
    Co = size(que,2);                                           % the number of columns of array que
    n = size(u1,1 );                                            % the number of rows in the matrix u1
    idn_p = sparse(que, 1:Co, 1, n, Co);                        % according to que, [1:Co] and 1 triple generate a (n x Co) sparse matrix idn_p
    S_PRNI = u1*V1*(u1(que,:))' + u2*V2*(u2(que,:))' + idn_p;   %  compute similarity matrix S_PRNI
   
    quetrTime = toc( Que  );                                    % obtain query time of PR_NI
    fprintf('>>>>>>>>>>Algorithm (Que_PR_NI)                PreTime_NI: %f s;         Que_NI_Time: %f s;        Total_NI_Time: %f s\n',  Pre_Time_NI,  quetrTime,  Pre_Time_NI + quetrTime);  
 
end   