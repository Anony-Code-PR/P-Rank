function [ ] = PR_IT_Mem(a, cin,cout, r,lambda)  
% % %--------------------------------------------------------------------------------------------
%   PR_IT_Mem£º obtain the total memory of PR_IT algorithm 
%          a:  sparse matrix
%        cin:  in-link damping factor
%       cout:  out-link damping factor
%          r:  # of iterations 
%     lambda:  weighting hyperparameter constant
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
    
    
    % compute similarity matrix s
    idn = speye(n, n);                        % initialize matrix ide as a sparse identity matrix.
    s = idn;                                  % assign ide to s (i.e.initialize matrix s as a sparse identity matrix).
    for i = 1: r
        s =  max((cin *lambda * q * s * q'+ cout * (1-lambda)* p * s * p' ), idn); 
        men = whos;
        max_men = max(max_men, sum([men.bytes]));
    end

    max_men = max_men/(1024^2);                %  obtain the memory usage of PR_IT
    
    fprintf('>>>>>>>>>>Algorithm (PRank_IT_Memory) (baseline)              Memory: %f MB\n ',  max_men); 

end

