clear all;
clc

% % % % Load dataset 
   fpath =  'E:\MATLAB\dataset\';   % Absolute path to the dataset
    ds = 'ca-GrQc';                 % CA           % edges: 28,980             nodes: 5,242                  
% %    ds = 'p2p-Gnutella25';          % P2P          % edges: 54,705             nodes: 22,687 
% %    ds = 'email-EuAll';             % EA           % edges: 420,045            nodes: 265,214                    
% %    ds = 'com-Youtube';             % YT           % edges: 5,975,248          nodes: 1,134,890
% %     ds = 'arabic-2005';            % AB           % edges: 639,999,458        nodes: 22,744,080                                        
% %     ds = 'twitter7';               % TW           % edges: 1,468,365,182      nodes: 41,652,230                                   
% %     ds = 'webbase-2001';           % WB           % edges: 1,019,903,190      nodes:118,142,155
% % % %=======================================================================================================
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
% % % run function R_MainFunPRank and study the impact of changing r_set on time 
%  r_set = [100 150  200 250 300];                                 % r_set: # of iterations(PR_IT) and target low-rank(PR_NI,PR_Our)      
%  QC = 100;                                                       % QC: multi-source query size 
%  fprintf('>>>>>>>\n    The name of Dataset:         %s\n',ds);   % Print out the data set name
%  R_MainFunPRank(a, cin,cout, r_set, lambda, K, QC);        % Fixed QC studies the impact of different r_set on time of three algorithms(PR_IT,PR_NI,PR_Our)
% %============================================================================================================================== 


% %========================================================================================================
% % % % run function Q_MainFunPRank and study the effect of changing QC on time
 r_set = 100 ;   
 QC = [50 100 150 200 250];     
 fprintf('>>>>>>>\n    The name of Dataset:         %s\n',ds); 
 Q_MainFunPRank(a, cin,cout, r_set, QC,K,lambda) ;       % Fixed r_set studies the effect of different QC on time of various algorithms


  
    
    
    