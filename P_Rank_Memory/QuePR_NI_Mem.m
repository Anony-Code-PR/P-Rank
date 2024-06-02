function [ ] = QuePR_NI_Mem( premax_men_NI, u1,u2,V1,V2, que)
% % %--------------------------------------------------------------------------------------------
%     QuePR_NI_Mem: obtain the PR_NI total memory
%    premax_men_NI: the preprocessing memory of PR_NI
%   u1, u2, V1, V2:  intermediate matriices
%              que:  query nodes
%     
% % %--------------------------------------------------------------------------------------------   

    % implement PR_NI multi-source queries
    max_men = 0;
    Co = size(que,2);                                           % the number of columns of array que
    n = size(u1,1);                                             % the number of rows in the matrix u1
    idn_p = sparse(que, 1:Co, 1, n, Co);                        % according to que, [1:Co] and 1 triple generate a (n x Co) sparse matrix idn_p
    S_PRNI = u1*V1*(u1(que,:))' + u2*V2*(u2(que,:))' + idn_p;   %  compute similarity matrix S_PRNI
    men = whos;
    max_men = max(max_men, sum([men.bytes]));   
    Quemax_men = max_men/(1024^2);
    
    fprintf('>>>>>>>>>>Algorithm (QuePR_NI_Mem)             PreMemory: %f MB;   QueMemory: %f MB;   TotalMemory: %f MB\n ',   premax_men_NI/(1024^2),  Quemax_men,  max(premax_men_NI/(1024^2),  Quemax_men ));  

     
end