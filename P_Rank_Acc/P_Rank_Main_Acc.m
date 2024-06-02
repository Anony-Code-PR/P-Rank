clear all
clc

% % % % Load dataset 
   fpath =  'D:\dataset\';            % Absolute path to the dataset
     ds = 'ego-Facebook';             % FB           % edges: 88,234             nodes: 4,039,                  
%     ds = 'p2p-Gnutella25';          % P2P          % edges: 54,705             nodes: 22,687, 
% % %=======================================================================================================
 fname = [fpath, ds, '.mat'];
 load(fname);
 a = Problem.A;       % the matrix a is sparse storage.;
 whos a               % Use "whos" command to check whether matrix a is in sparse storage format 

    
 % % % Initialize constant 
 cin = 0.3;           % in-link damping factor
 cout = 0.7;          % out-link damping factor
 lambda = 0.8;        % weighting hyperparameter constant
 K = 10;              % # of subspace iterations by default
 
% %========================================================================================================
% % % run function R_MainAccur and study the impact of changing r_set on accuracy
 r_set = [100 200  300 400];                                             % r_set: # of iterations(PR_IT) and target low-rank(PR_NI,PR_Our)   
 QC = size(a,1);                                                          % QC: multi-source query size 
 fprintf('>>>>>>>\n    The name of Dataset:         %s\n',ds);      % Print out the data set name
 R_MainAccur(a, cin,cout, r_set, lambda, K, QC);              % % Fixed QC studies the impact of different r_set on accuracy of two algorithms(PR_NI,PR_our)
% %============================================================================================================================== 



  
    
    
    