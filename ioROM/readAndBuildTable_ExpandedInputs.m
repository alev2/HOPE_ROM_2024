close all

addpath('../');

sobolExamples_Setup


%runName='sobolAnalysis3Dec24';
%runName='sobolAnalysis3Dec24ReducedInputs';
%runName='sobolAnalysis4Dec24ExpandedInputs';
runName='sobolAnalysisExpandedInputs_9Dec24';


outputDir='../finalSobolResults/';

load(strcat(outputDir,runName,'_inputVarNms'));
load(strcat(outputDir,runName,'_outputVarNms'));

inputRoot='../sobolCals_ExpandedInputs9Dec24/ModelRun';
fprintf('setup done\n');

%num_Outputs=25;
num_Outputs=8;

[yearInds,~]=find(yearRange>=2017 & yearRange<=2022 );
yearInds=yearInds+1;
num_Yrs=length(yearInds);
    
% % sheetNames={...
% %   'IncAndDiag',...
% %   'TotalPWH',...
% %   'continuumPct',...
% %   'TotalDeaths',...
% %   'DeathsPer100k'
% % };
% % 
% % startYr=num2str(yearInds(1)); endYr=num2str(yearInds(end));
% % 
% % sheetRanges={...
% %     strcat('B',startYr,':C',endYr),... %2
% %     strcat('B',startYr,':G',endYr),... %6
% %     strcat('B',startYr,':F',endYr),... %5
% %     strcat('B',startYr,':G',endYr),... %6
% %     strcat('B',startYr,':G',endYr)... %6
% % };
% % 
% % tableSlots=[...
% %   1 2;
% %   3 8;
% %   9 13;
% %   14 19;
% %   20 25
% % ];




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



inputVarNms=strrep(inputVarNms,'_',' ');
inputVarNms=strrep(inputVarNms,' r ','');
inputVarNms=strrep(inputVarNms,'tt ','');
inputVarNms=strrep(inputVarNms,' 1 ','');
inputVarNms=strrep(inputVarNms,'1 ','');
inputVarNms=strrep(inputVarNms,'dropOutProb ','');
inputVarNms=strrep(inputVarNms,'relRiskPop ','');
inputVarNms_Cat=categorical(inputVarNms);
inputVarNms_Cat=reordercats(inputVarNms_Cat,inputVarNms);


outputVarNms{5}='pctCareNoART';
outputVarNms_Cat=categorical(outputVarNms);
outputVarNms_Cat=reordercats(outputVarNms_Cat,outputVarNms);


% Sobol indices computation
N = 29; % number of parameters...
%load('../paramHypercube.mat');

paramHypercube=[zeros(N,1) ones(N,1)];
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
knots_25 = @(n) knots_leja(n,paramHypercube(25,1),paramHypercube(25,2),'sym_line');
knots_26 = @(n) knots_leja(n,paramHypercube(26,1),paramHypercube(26,2),'sym_line');
knots_27 = @(n) knots_leja(n,paramHypercube(27,1),paramHypercube(27,2),'sym_line');
knots_28 = @(n) knots_leja(n,paramHypercube(28,1),paramHypercube(28,2),'sym_line');
knots_29 = @(n) knots_leja(n,paramHypercube(29,1),paramHypercube(29,2),'sym_line');



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

% create the reduced sparse grid to get a list of knots with no repetition
fprintf('Reducing sparse grid... ');
Sr = reduce_sparse_grid(S); 
fprintf('done.\n');


fprintf('Extracting points... ');
% extract the list of points 
fprintf('done.\n');
sg_pts = Sr.knots; % this is a matrix of dimension N x nb. of sparse grid points (each column of the matrix is one point) 
nb_pts = size(sg_pts,2); % variable to know how many points we have at hand

values_=0*ones(num_Yrs,nb_pts,num_Outputs);

tempTable=zeros(num_Yrs,num_Outputs);
fprintf('Reading table... ');

for k=1:nb_pts
        
    for jj=1:size(sheetNames,2)        
        tableIn=table2array(readtable(strcat(inputRoot,num2str(k),'.xlsx'),...
            'Sheet',sheetNames{jj},'Range',sheetRanges{jj},'ReadVariableNames',0));
        tempTable(:,tableSlots(jj,1):tableSlots(jj,2))=tableIn;
    end

    values_(:,k,:)=tempTable;

end

modelOutputs=zeros(num_Outputs,nb_pts);

for kk=1:num_Outputs
    
    modelOutputs(kk,:)=values_(end,:,kk);

end

modelOutputs_Range=[ mean(modelOutputs,2) min(modelOutputs,[],2) max(modelOutputs,[],2) std(modelOutputs,[],2)];
