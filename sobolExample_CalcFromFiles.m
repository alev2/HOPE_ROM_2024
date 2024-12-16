close all
clear

% initialize paramaters that we do not vary for HIV problem, as well as
% the sparse grid library.
sobolExamples_Setup

runName='sobolAnalysis3Dec24ReducedInputs';
outputDir='./finalSobolResults/';


inputRoot='./sobolCalcs/ModelRun';
fprintf('setup done\n');

%num_Outputs=25;
num_Outputs=8;

[yearInds,~]=find(yearRange>=2017 & yearRange<=2022 );
yearInds=yearInds+1;
num_Yrs=length(yearInds);
    
sheetNames={...
  'IncAndDiag',...
  ...'TotalPWH',...
  'continuumPct',...
  'TotalDeaths',...
  ...'DeathsPer100k'
};

startYr=num2str(yearInds(1)); endYr=num2str(yearInds(end));

sheetRanges={...
    strcat('B',startYr,':C',endYr),... %2
    ...strcat('B',startYr,':G',endYr),... %6
    strcat('B',startYr,':F',endYr),... %5
    strcat('G',startYr,':G',endYr),... %1
    ...strcat('B',startYr,':G',endYr)... %6
%    'B2:C20',... %2
%    'B2:G20',... %6
%    'B2:F20',... %5
%    'B2:G20',... %6
%    'B2:G20'...  %6
};

tableSlots=[...
  1 2;
  3 7;
  8 8;
  ...14 19;
  ...20 25
];


% sheetRanges={...
%     strcat('B',startYr,':C',endYr),... %2
%     strcat('B',startYr,':G',endYr),... %6
%     strcat('B',startYr,':F',endYr),... %5
%     strcat('B',startYr,':G',endYr),... %6
%     strcat('B',startYr,':G',endYr)... %6
% %    'B2:C20',... %2
% %    'B2:G20',... %6
% %    'B2:F20',... %5
% %    'B2:G20',... %6
% %    'B2:G20'...  %6
% };
% 
% tableSlots=[...
%   1 2;
%   3 8;
%   9 13;
%   14 19;
%   20 25
% ];


% Sobol indices computation
N = 24; % number of parameters...
load('./paramHypercube.mat');



domain = paramHypercube';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% type of knots to be used for the construction of the sparse grid
% (we use for symmetric Leja points for the moment, this should be ok!)
knots_1 = @(n) knots_leja(n,paramHypercube(1,1),paramHypercube(1,2),'sym_line');
knots_2 = @(n) knots_leja(n,paramHypercube(2,1),paramHypercube(2,2),'sym_line');
knots_3 = @(n) knots_leja(n,paramHypercube(3,1),paramHypercube(3,2),'sym_line');
knots_4 = @(n) knots_leja(n,paramHypercube(4,1),paramHypercube(4,2),'sym_line');
knots_5 = @(n) knots_leja(n,paramHypercube(5,1),paramHypercube(5,2),'sym_line');
knots_6 = @(n) knots_leja(n,paramHypercube(6,1),paramHypercube(6,2),'sym_line');
knots_7 = @(n) knots_leja(n,paramHypercube(7,1),paramHypercube(7,2),'sym_line');
knots_8 = @(n) knots_leja(n,paramHypercube(8,1),paramHypercube(8,2),'sym_line');
knots_9 = @(n) knots_leja(n,paramHypercube(9,1),paramHypercube(9,2),'sym_line');
knots_10 = @(n) knots_leja(n,paramHypercube(10,1),paramHypercube(10,2),'sym_line');
knots_11 = @(n) knots_leja(n,paramHypercube(11,1),paramHypercube(11,2),'sym_line');
knots_12 = @(n) knots_leja(n,paramHypercube(12,1),paramHypercube(12,2),'sym_line');
knots_13 = @(n) knots_leja(n,paramHypercube(13,1),paramHypercube(13,2),'sym_line');
knots_14 = @(n) knots_leja(n,paramHypercube(14,1),paramHypercube(14,2),'sym_line');
knots_15 = @(n) knots_leja(n,paramHypercube(15,1),paramHypercube(15,2),'sym_line');
knots_16 = @(n) knots_leja(n,paramHypercube(16,1),paramHypercube(16,2),'sym_line');
knots_17 = @(n) knots_leja(n,paramHypercube(17,1),paramHypercube(17,2),'sym_line');
knots_18 = @(n) knots_leja(n,paramHypercube(18,1),paramHypercube(18,2),'sym_line');
knots_19 = @(n) knots_leja(n,paramHypercube(19,1),paramHypercube(19,2),'sym_line');
knots_20 = @(n) knots_leja(n,paramHypercube(20,1),paramHypercube(20,2),'sym_line');
knots_21 = @(n) knots_leja(n,paramHypercube(21,1),paramHypercube(21,2),'sym_line');
knots_22 = @(n) knots_leja(n,paramHypercube(22,1),paramHypercube(22,2),'sym_line');
knots_23 = @(n) knots_leja(n,paramHypercube(23,1),paramHypercube(23,2),'sym_line');
knots_24 = @(n) knots_leja(n,paramHypercube(24,1),paramHypercube(24,2),'sym_line');



% combine the knots for the three parameters in one - we need this as input to the function that creates the sparse grid
knots = {knots_1,knots_2,knots_3, knots_4, knots_5, knots_6, knots_7, knots_8...
         knots_9 knots_10 knots_11 knots_12 knots_13 knots_14 knots_15 knots_16...
         knots_17 knots_18 knots_19 knots_20 knots_21 knots_22 knots_23 knots_24}; 


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

%outputRoot='./datasetInput/simulation_';
%outputRoot='./dataset20Years/simulation_';
Alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
fprintf(strcat('Num points: ',num2str(nb_pts),'.\n'));

%outcomePP=HIVEpiModel_Sobol('HOPE Model V10_05_LB20230224_2_20231005_Fresh.xlsm', sg_pts);

%load('ExcelValues_AllParameters.mat');
%load('ExcelValues_Populations.mat')


% % CHANGE HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % CHANGE HERE! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%num_Yrs = 5; 
% read from your files and arrange the results in a convenient way
% we store the results for each group in one table 

values_=0*ones(num_Yrs,nb_pts,num_Outputs);

%values_g1 = 0*ones(num_Yrs,nb_pts); % incidence black
%values_g2 = 0*ones(num_Yrs,nb_pts); % incidence hisp
%values_g3 = 0*ones(num_Yrs,nb_pts); % irr black
%values_g4 = 0*ones(num_Yrs,nb_pts); % irr hisp
%values_g5 = 0*ones(num_Yrs,nb_pts); % spending
%values_g6 = 0*ones(num_Yrs,nb_pts); % spending
%values_g7 = 0*ones(num_Yrs,nb_pts); % spending


% read from file and copy the results in the tables
fprintf('Reading table... ');
%for k=1:nb_pts
tempTable=zeros(num_Yrs,num_Outputs);

for k=1:nb_pts
    
%    values_g1(:,k) = xlsread('xxx.xls', ...); % if you give another input to xlsread you can select columns in the file 
%    values_g2(:,k) = xlsread('xxx.xls', ...);
%    values_g3(:,k) = xlsread('xxx.xls', ...);
%    tableIn=table2array(readtable(strcat(outputRoot,num2str(k),'.xls')),...
%        'Range',strcat(Alphabet(1),num2str(1),':',Alphabet(1),num2str(size(incidenceOut,1)+1)));

    
    for jj=1:size(sheetNames,2)        
        tableIn=table2array(readtable(strcat(inputRoot,num2str(k),'.xlsx'),...
            'Sheet',sheetNames{jj},'Range',sheetRanges{jj}));
%        values_(:,tableSlots(jj,1):tableSlots(jj,2),k)=tableIn;
        tempTable(:,tableSlots(jj,1):tableSlots(jj,2))=tableIn;
    end

    values_(:,k,:)=tempTable;

    %values_g1(:,k) = tableIn(:,1); % if you give another input to xlsread you can select columns in the file 
    %values_g2(:,k) = tableIn(:,2);
    %values_g3(:,k) = tableIn(:,3);
    %values_g4(:,k) = tableIn(:,4);
    %values_g5(:,k) = tableIn(:,5)/1e9;    
    %values_g6(:,k) = tableIn(:,6);    
    %values_g7(:,k) = tableIn(:,7);    

end
fprintf('done.\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % compute Sobol indices at each year for each group

Sob_All=zeros(N,num_Yrs,num_Outputs);
Tot_Sob_All=zeros(N,num_Yrs,num_Outputs);
m_All=zeros(1,num_Yrs,num_Outputs);
v_All=zeros(1,num_Yrs,num_Outputs);

% Sob_g1_All=[];
% Sob_g2_All=[];
% Sob_g3_All=[];
% Sob_g4_All=[];
% Sob_g5_All=[];
% Sob_g6_All=[];
% Sob_g7_All=[];
% 
% Tot_Sob_g1_All=[];
% Tot_Sob_g2_All=[];
% Tot_Sob_g3_All=[];
% Tot_Sob_g4_All=[];
% Tot_Sob_g5_All=[];
% Tot_Sob_g6_All=[];
% Tot_Sob_g7_All=[];

%m1_All=[];
%m2_All=[];
%m3_All=[];
%m4_All=[];
%m5_All=[];
%m6_All=[];
%m7_All=[];

%v1_All=[];
%v2_All=[];
%v3_All=[];
%v4_All=[];
%v5_All=[];
%v6_All=[];
%v7_All=[];

%v1_new=[];
%v2_new=[];
%v3_new=[];
%v4_new=[];
%v5_new=[];
%v6_new=[];
%v7_new=[];

%VTi1_All=[];
%VTi2_All=[];
%VTi3_All=[];
%VTi4_All=[];
%VTi5_All=[];
%VTi6_All=[];
%VTi7_All=[];

%Vi1_All=[];
%Vi2_All=[];
%Vi3_All=[];
%Vi4_All=[];
%Vi5_All=[];
%Vi6_All=[];
%Vi7_All=[];

%vti1=[];
%vti2=[];
%vti3=[];
%vti4=[];
%vti5=[];
%vti6=[];
%vti7=[];

%vi1=[];vi2=[];vi3=[];vi4=[];vi5=[];vi6=[];vi7=[];

fprintf('Computing variance decomposition... ');
for j = 1:num_Yrs


  %quasi static
%   [Sob_g1,Tot_Sob_g1,m1,v1] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g1(j,:),domain,'legendre'); 
%   [Sob_g2,Tot_Sob_g2,m2,v2] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g2(j,:),domain,'legendre'); 
%   [Sob_g3,Tot_Sob_g3,m3,v3] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g3(j,:),domain,'legendre'); 
%   [Sob_g4,Tot_Sob_g4,m4,v4] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g4(j,:),domain,'legendre'); 
%   [Sob_g5,Tot_Sob_g5,m5,v5] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g5(j,:),domain,'legendre'); 
%   [Sob_g6,Tot_Sob_g6,m6,v6] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g6(j,:),domain,'legendre'); 
%   [Sob_g7,Tot_Sob_g7,m7,v7] = compute_sobol_indices_from_sparse_grid(S,Sr,values_g7(j,:),domain,'legendre'); 


  for kk=1:num_Outputs
      [Sob_,Tot_Sob_,m,v] = compute_sobol_indices_from_sparse_grid(S,Sr,values_(j,:,kk),domain,'legendre');             
      Sob_All(:,j,kk)=Sob_;
      Tot_Sob_All(:,j,kk)=Tot_Sob_;
      m_All(:,j,kk)=m;
      v_All(:,j,kk)=v;
  end


%    [Sob_g1,Tot_Sob_g1,m1,v1,vi1,vti1] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi1_All, VTi1_All, v1_new, values_g1(j,:),domain,'legendre'); 
%    [Sob_g2,Tot_Sob_g2,m2,v2,vi2,vti2] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi2_All, VTi2_All, v2_new, values_g2(j,:),domain,'legendre'); 
%    [Sob_g3,Tot_Sob_g3,m3,v3,vi3,vti3] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi3_All, VTi3_All, v3_new, values_g3(j,:),domain,'legendre'); 
%    [Sob_g4,Tot_Sob_g4,m4,v4,vi4,vti4] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi4_All, VTi4_All, v4_new, values_g4(j,:),domain,'legendre'); 
%    [Sob_g5,Tot_Sob_g5,m5,v5,vi5,vti5] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi5_All, VTi5_All, v5_new, values_g5(j,:),domain,'legendre'); 
%    [Sob_g6,Tot_Sob_g6,m6,v6,vi6,vti6] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi6_All, VTi6_All, v6_new, values_g6(j,:),domain,'legendre'); 
%    [Sob_g7,Tot_Sob_g7,m7,v7,vi7,vti7] = compute_sobol_indices_from_sparse_grid_with_history(S,Sr, Vi7_All, VTi7_All, v7_new, values_g7(j,:),domain,'legendre'); 

%    [Sob_g1,Tot_Sob_g1,m1,v1] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g1(j,:),domain,'legendre'); 
%    [Sob_g2,Tot_Sob_g2,m2,v2] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g2(j,:),domain,'legendre'); 
%    [Sob_g3,Tot_Sob_g3,m3,v3] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g3(j,:),domain,'legendre'); 
%    [Sob_g4,Tot_Sob_g4,m4,v4] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g4(j,:),domain,'legendre'); 
%    [Sob_g5,Tot_Sob_g5,m5,v5] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g5(j,:),domain,'legendre'); 
%    [Sob_g6,Tot_Sob_g6,m6,v6] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g6(j,:),domain,'legendre'); 
%    [Sob_g7,Tot_Sob_g7,m7,v7] = compute_variance_decomposition_from_sparse_grid(S,Sr,values_g7(j,:),domain,'legendre'); 


%     Sob_g1_All=[Sob_g1_All Sob_g1];
%     Sob_g2_All=[Sob_g2_All Sob_g2];
%     Sob_g3_All=[Sob_g3_All Sob_g3];
%     Sob_g4_All=[Sob_g4_All Sob_g4];
%     Sob_g5_All=[Sob_g5_All Sob_g5];
%     Sob_g6_All=[Sob_g6_All Sob_g6];
%     Sob_g7_All=[Sob_g7_All Sob_g7];    
%         
%     Tot_Sob_g1_All=[Tot_Sob_g1_All Tot_Sob_g1];
%     Tot_Sob_g2_All=[Tot_Sob_g2_All Tot_Sob_g2];
%     Tot_Sob_g3_All=[Tot_Sob_g3_All Tot_Sob_g3];
%     Tot_Sob_g4_All=[Tot_Sob_g4_All Tot_Sob_g4];    
%     Tot_Sob_g5_All=[Tot_Sob_g5_All Tot_Sob_g5];   
%     Tot_Sob_g6_All=[Tot_Sob_g6_All Tot_Sob_g6];   
%     Tot_Sob_g7_All=[Tot_Sob_g7_All Tot_Sob_g7];   
% 
%     m1_All=[m1_All m1];
%     m2_All=[m2_All m2];
%     m3_All=[m3_All m3];
%     m4_All=[m4_All m4];
%     m5_All=[m5_All m5];
%     m6_All=[m6_All m6];
%     m7_All=[m7_All m7];
%     
%     v1_new=v1;
%     v2_new=v2;
%     v3_new=v3;
%     v4_new=v4;
%     v5_new=v5;
%     v6_new=v6;
%     v7_new=v7;
%   
%     v1_All=[v1_All v1];
%     v2_All=[v2_All v2];
%     v3_All=[v3_All v3];
%     v4_All=[v4_All v4];
%     v5_All=[v5_All v5];
%     v6_All=[v6_All v6];
%     v7_All=[v7_All v7];
%     
%     VTi1_All=vti1;%[VTi1_All vti1];
%     VTi2_All=vti2;%[VTi2_All vti2];
%     VTi3_All=vti3;%[VTi3_All vti3];
%     VTi4_All=vti4;%[VTi3_All vti3];
%     VTi5_All=vti5;%[VTi3_All vti3];
%     VTi6_All=vti6;%[VTi3_All vti3];
%     VTi7_All=vti7;%[VTi3_All vti3];
% 
%     Vi1_All=vi1;
%     Vi2_All=vi2;%[Vi2_All vi2];
%     Vi3_All=vi3;%[Vi3_All vi3];
%     Vi4_All=vi4;%[Vi3_All vi3];
%     Vi5_All=vi5;%[Vi3_All vi3];
%     Vi6_All=vi6;%[Vi3_All vi3];
%     Vi7_All=vi7;%[Vi3_All vi3];
    
    
end

% save('Sob_g1_All','Sob_g1_All')
% save('Sob_g2_All','Sob_g2_All')
% save('Sob_g3_All','Sob_g3_All')
% save('Sob_g4_All','Sob_g4_All')
% save('Sob_g5_All','Sob_g5_All')
% save('Sob_g6_All','Sob_g6_All')
% save('Sob_g7_All','Sob_g7_All')
% 
% save('Tot_Sob_g1_All','Tot_Sob_g1_All')
% save('Tot_Sob_g2_All','Tot_Sob_g2_All')
% save('Tot_Sob_g3_All','Tot_Sob_g3_All')
% save('Tot_Sob_g4_All','Tot_Sob_g4_All')
% save('Tot_Sob_g5_All','Tot_Sob_g5_All')
% save('Tot_Sob_g6_All','Tot_Sob_g6_All')
% save('Tot_Sob_g7_All','Tot_Sob_g7_All')

Sob_2022=reshape(Sob_All(:,end,:),[N num_Outputs]);
Tot_Sob_2022=reshape(Tot_Sob_All(:,end,:),[N num_Outputs]);

save(strcat(outputDir,runName,'_Sob_All'),'Sob_All');
save(strcat(outputDir,runName,'_Tot_Sob_All'),'Tot_Sob_All');
save(strcat(outputDir,runName,'_Sob_2022'),'Sob_2022');
save(strcat(outputDir,runName,'_Tot_Sob_2022'),'Tot_Sob_2022');


fprintf('done.\n');
