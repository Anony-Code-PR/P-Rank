function  [] = R_MainAccur(a, cin,cout, r_set,lambda, K,QC)
% % %--------------------------------------------------------------------------------------------
%     R_MainAccur:  Fixed QC and studied the effect of r_set on time for various algorithms          
%         r_set:   # of iterations(CSR_IT,CSR_RLS) and target low-rank(CSR_NI,CSR_Our) 
%             a:   sparse matrix
%      cin,cout:   damping factor constant
%        lambda:   weighting factor constant
%            K :  # of subspace iterations by default
%            QC:   multi-source query size 
% % %--------------------------------------------------------------------------------------------

% Randomly generate QC query nodes
% que = randperm(size(a,1), QC);    % % % % % The generated query node set (QC < n)
que = 1:1:size(a,1);                % % % % % Compute all pairs of queries (QC =n)


% % % Algorithm: PRank-IT
       [S_it] = PR_IT_Acc(a, cin,cout,lambda);     % baseline

% % % % % Analysis the impact of r on time for four algorithms 
r = r_set;              %  assign r_set to r
for i =1:numel(r)       % numel(r): the size/length of the array r
       
     fprintf('>>>>>>>>>\n   r = %d,  SamNumb = %d\n',r(i), QC); 

        % % % Algorithm:  PRank-our_NonLinear 
       [ F, N, X] = PrePR_our_Acc( a, cin,cout,lambda, r(i), K ); 
       QuePR_our_Acc(cin,cout,lambda, F, N, X, que, S_it); 
       clear F N x ;

        % % % Algorithm: PRank-NI
        [ V1,V2,u1,u2 ]= PrePR_NI_Acc(a, cin,cout,lambda, r(i));
        QuePR_NI_Acc(que,u1,V1, u2, V2, S_it);
        clear u1 V1  u2  V2;
     

        
end

end


