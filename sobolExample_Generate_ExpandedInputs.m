close all
clear

% initialize paramaters that we do not vary for HIV problem, as well as
% the sparse grid library.
sobolExamples_Setup

fprintf('setup done\n');

% Sobol indices computation

N = 29; % number of parameters...
load('paramHypercube_Revised9DecCareful_2.mat');
%domain = paramHypercube';

baseDomain=[zeros(N,1) ones(N,1)];
domain=baseDomain';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% type of knots to be used for the construction of the sparse grid
% (we use for symmetric Leja points for the moment, this should be ok!)
knots_1 = @(n) knots_leja(n,baseDomain(1,1),baseDomain(1,2),'sym_line');
knots_2 = @(n) knots_leja(n,baseDomain(2,1),baseDomain(2,2),'sym_line');
knots_3 = @(n) knots_leja(n,baseDomain(3,1),baseDomain(3,2),'sym_line');
knots_4 = @(n) knots_leja(n,baseDomain(4,1),baseDomain(4,2),'sym_line');
knots_5 = @(n) knots_leja(n,baseDomain(5,1),baseDomain(5,2),'sym_line');
knots_6 = @(n) knots_leja(n,baseDomain(6,1),baseDomain(6,2),'sym_line');
knots_7 = @(n) knots_leja(n,baseDomain(7,1),baseDomain(7,2),'sym_line');
knots_8 = @(n) knots_leja(n,baseDomain(8,1),baseDomain(8,2),'sym_line');
knots_9 = @(n) knots_leja(n,baseDomain(9,1),baseDomain(9,2),'sym_line');
knots_10 = @(n) knots_leja(n,baseDomain(10,1),baseDomain(10,2),'sym_line');
knots_11 = @(n) knots_leja(n,baseDomain(11,1),baseDomain(11,2),'sym_line');
knots_12 = @(n) knots_leja(n,baseDomain(12,1),baseDomain(12,2),'sym_line');
knots_13 = @(n) knots_leja(n,baseDomain(13,1),baseDomain(13,2),'sym_line');
knots_14 = @(n) knots_leja(n,baseDomain(14,1),baseDomain(14,2),'sym_line');
knots_15 = @(n) knots_leja(n,baseDomain(15,1),baseDomain(15,2),'sym_line');
knots_16 = @(n) knots_leja(n,baseDomain(16,1),baseDomain(16,2),'sym_line');
knots_17 = @(n) knots_leja(n,baseDomain(17,1),baseDomain(17,2),'sym_line');
knots_18 = @(n) knots_leja(n,baseDomain(18,1),baseDomain(18,2),'sym_line');
knots_19 = @(n) knots_leja(n,baseDomain(19,1),baseDomain(19,2),'sym_line');
knots_20 = @(n) knots_leja(n,baseDomain(20,1),baseDomain(20,2),'sym_line');
knots_21 = @(n) knots_leja(n,baseDomain(21,1),baseDomain(21,2),'sym_line');
knots_22 = @(n) knots_leja(n,baseDomain(22,1),baseDomain(22,2),'sym_line');
knots_23 = @(n) knots_leja(n,baseDomain(23,1),baseDomain(23,2),'sym_line');
knots_24 = @(n) knots_leja(n,baseDomain(24,1),baseDomain(24,2),'sym_line');
knots_25 = @(n) knots_leja(n,baseDomain(25,1),baseDomain(25,2),'sym_line');
knots_26 = @(n) knots_leja(n,baseDomain(26,1),baseDomain(26,2),'sym_line');
knots_27 = @(n) knots_leja(n,baseDomain(27,1),baseDomain(27,2),'sym_line');
knots_28 = @(n) knots_leja(n,baseDomain(28,1),baseDomain(28,2),'sym_line');
knots_29 = @(n) knots_leja(n,baseDomain(29,1),baseDomain(29,2),'sym_line');



% combine the knots for the three parameters in one - we need this as input to the function that creates the sparse grid
knots = {knots_1,knots_2,knots_3, knots_4, knots_5, knots_6, knots_7, knots_8...
         knots_9 knots_10 knots_11 knots_12 knots_13 knots_14 knots_15 knots_16...
         knots_17 knots_18 knots_19 knots_20 knots_21 knots_22 knots_23 knots_24 ...
         knots_25 knots_26 knots_27 knots_28 knots_29}; 


fprintf('all sparsegrid prelim stuff done\n');

% level-to-knots function chosen in accordance with the type of knots above
lev2knots = @ lev2knots_2step;

% type of underlying polynomial approximation 
rule = @(i) sum(i-1);

% level (basically dictating the accuracy level of the sparse grid approximation)
w = 2; 

% create the sparse grid

fprintf('Creating sparse grid... ');

S = create_sparse_grid(N,w,knots,lev2knots,rule);
fprintf('done.\n');
% visualization: plot the sparse grid
%plot_sparse_grid(S,[1 2]) % first two parameters
%plot_sparse_grid(S,[2 3]) % second and third parameters

% create the reduced sparse grid to get a list of knots with no repetition
fprintf('Reducing sparse grid... ');
Sr = reduce_sparse_grid(S); 
fprintf('done.\n');


fprintf('Extracting points... ');
% extract the list of points 
fprintf('done.\n');
sg_pts = Sr.knots; % this is a matrix of dimension N x nb. of sparse grid points (each column of the matrix is one point) 
nb_pts = size(sg_pts,2); % variable to know how many points we have at hand


% DO SOMETHING HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Create a .xls file for each of this points and collect the results of
% your model run in a table 
% - !! Order is important!! Store the model run according to the ordering of
% the points in sg_pts. 
% - Assuming 3 groups and results for 5 years, the table contains 15 data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputRoot='./sobolCals_ExpandedInputs9Dec24/ModelRun';
%outputRoot='./datasetInput/simulation_';
%outputRoot='./dataset20Years/simulation_';
Alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
fprintf(strcat('Num points: ',num2str(nb_pts),'.\n'));


%outcomePP=HIVEpiModel_Sobol('HOPE Model V10_05_LB20230224_2_20231005_Fresh.xlsm', sg_pts);

load('./initialConds/ExcelValues_AllParametersDec4.mat');
load('./initialConds/ExcelValues_PopulationsDec4.mat')
%Plot_Sobols



for i=304:nb_pts
    tic

    Parameters_Cur=ExcelValues_AllParameters;

    sg_ptsMapped=intervalMap(sg_pts(:,i),paramHypercube);
    

    Parameters_Cur(indsAllParams)=sg_ptsMapped(inds_ModelRHS);

    fprintf('Running HOPE... ');
    [outTest, Params]=HIVEpiModel_Sobol(Parameters_Cur, ExcelValues_Populations);
    fprintf('done.\n ');

    [~]=getOutputs(outTest,strcat(outputRoot,num2str(i),'.xlsx'));


    toc
end


fprintf('done.\n');

