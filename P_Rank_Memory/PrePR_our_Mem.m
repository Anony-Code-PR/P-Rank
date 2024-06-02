function  [max_men, F,N,X  ] = PrePR_our_Mem( a, cin,cout,lambda, r, K )
% % %--------------------------------------------------------------------------------------------
% PrePR_our_Mem: obtain the preprocessing memory of PR_our algorithm 
%             a:  sparse matrix
%           cin:  in-link damping factor
%          cout:  out-link damping factor
%        lambda:  weighting hyperparameter constant
%             r:  # of iterations 
%            K :  # of subspace iterations by default
% % %--------------------------------------------------------------------------------------------

    
  
    % Initialise q as the row normalization of the transpose of the adjacency matrix a;
    % Initialise p as the row normalization of the adjacency matrix a;
    n = size(a,1);                            % the size of the matrix a
    d_in = sum(a,1)';                         % d_in: in-degree vector 
    inv_din = spfun(@(x) 1./x, d_in);         % take the reciprocal of the elements in a vector d_in
    q = (a * spdiags(inv_din, 0, n, n))';     % q : RowNorm(a')
     
    d_out = sum(a,2);                         % d_out: out-degree vector   
    inv_dout = spfun(@(x) 1./x, d_out);       % take the reciprocal of the elements in a vector d_out 
    p = spdiags(inv_dout,0,n,n) * a;          % p: normalization of the rows of the matrix a  (that is p =:RowNorm(a))
    max_men = 0;
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear d_in inv_din d_out  inv_dout  a;
   

    [u, si, v] = svds(q, r);          % svd-decomposition of sparse matrix q  
    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear q;
    
    % compute intermediate matrices F, N, H and M
    F = u * si;  
    N = p*v;
    H = v'* F;
    M = v' * N;

    men = whos;
    max_men = max(max_men, sum([men.bytes]));
    clear u si;
    
    % compute intermediate matrix X
    X = speye(r,r);  
    idr = X;                                                           % initialize the sparse identity matrix 
    DiagD1 = zeros(n,1);
    DiagD2 = DiagD1;                                                   % initialize the n-dimensional zeros vectors DiagD1 and DiagD2                                  
    for i = 1: K
        G1 = X * F';
        G2 = X * N';
        for j = 1:n
           DiagD1(j) = F(j,:) * G1(:,j);
           DiagD2(j) = N(j,:) * G2(:,j);          
        end
        men = whos;
        max_men = max(max_men, sum([men.bytes]));
        clear G1 G2;
        dd = cin * lambda * DiagD1 + cout * (1-lambda) * DiagD2;        % dd : n-dimensional column vector
        X =  cin * lambda * H*X*H'+ cout * (1-lambda) * M * X * M'- v'*(v.*(dd* ones(1,r)) ) + idr;   
        men = whos;
        max_men = max(max_men, sum([men.bytes]));
       clear dd ;    
    end
    
 

end