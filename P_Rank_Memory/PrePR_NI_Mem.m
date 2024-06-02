function [max_men, u1,u2,V1,V2  ]= PrePR_NI_Mem(a, cin,cout,lambda, r)
% % %--------------------------------------------------------------------------------------------
%  PrePR_NI_Mem: obtain the preprocessing memory of PR_NI 
%             a:  sparse matrix
%           cin:  in-link damping factor
%          cout:  out-link damping factor
%        lambda:  weighting hyperparameter constant
%             r:  # of iterations  
% % %--------------------------------------------------------------------------------------------
  

%     time_PRank_DE = tic;
    % Initialise q as the column normalised adjacency matrix a; 
    n = size(a,1); 
    d_in = sum(a,1)';                         % d_in: in-degree vector 
    inv_din = spfun(@(x) 1./x, d_in);         % take the reciprocal of the elements in a vector d
    q = (a * spdiags(inv_din, 0, n, n))';     % The columns of matrix a are normalized and then transposed
    
    d_out = sum(a,2);
    inv_dout = spfun(@(x) 1./x, d_out);       % d_out: out-degree vector 
    p = spdiags(inv_dout,0,n,n) * a;          % normalization of the rows of the matrix a  
    max_men = 0;
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear d_in inv_din d_out  inv_dout  a;

    % svd-decomposition
    [u1, si1, v1] = svds(q, r);    
    [u2, si2, v2] = svds(p, r);  
    
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear q p;
    
    % compute the auxiliary matrices:
    theta_qq = v1'*u1;
    theta_pp = v2'*u2;
    theta_pq = v2'*u1;
    theta_qp = v1'*u2;

    % compute the inverse of the diagonal matrix.   
    v_si1 = diag(si1);
    v_si2 = diag(si2);
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear  si1 si2;
    v_si1(v_si1<0.00001)=0 ;                   % find the index of a non-zero element
    v_si2(v_si2<0.00001)=0 ; 
    inv_si1 = spfun(@(y) 1./y, v_si1);         % take the reciprocal of the elements in a vector v_si1
    inv_si2 = spfun(@(y) 1./y, v_si2);
    theta_q = diag(inv_si1);                   % theta_q: the inverse of matrix si1 
    theta_p = diag(inv_si2);                   % theta_p: the inverse of matrix si2     
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear v_si1 v_si2 inv_si1 inv_si2;
     
    % compute the matrix Sigma_11,Sigma_12, Sigma_22 and Sigma_21:
    Sigma_11 = (1/(lambda*cin))* kron(theta_q,theta_q) - kron(theta_qq,theta_qq);
    Sigma_12 = kron(-theta_qp,theta_qp);
    Sigma_22 = (1/(cout*(1-lambda))) * kron(theta_p,theta_p) - kron(theta_pp,theta_pp);
    Sigma_21 =  kron(-theta_pq,theta_pq);     
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear theta_q  theta_p theta_qq theta_pp theta_pq theta_qp;
    
    % compute the Lambda
    Lambda = inv([Sigma_11,Sigma_12;Sigma_21,Sigma_22]);
    Vec1 = v1'*v1;
    Vec2 = v2'*v2;
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear v1  v2 theta_q theta_p Sigma_11 Sigma_12 Sigma_21 Sigma_22;
   
    % compute intermediate matrices V1 and V2    
    Mat_v = Lambda * [Vec1(:);Vec2(:)];
    Mat_v1 = Mat_v(1:r^2,:);
    Mat_v2 = Mat_v(r^2+1:end,:);
    V1 = reshape(Mat_v1,r,r);
    V2 = reshape(Mat_v2,r,r);
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear Lambda Vec1 Vec2  Mat_v Mat_v1 Mat_v2 
    

end