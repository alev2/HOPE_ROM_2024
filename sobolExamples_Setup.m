%this defines some variables so we can do the sobol analysis quickly,
%avoiding r

% initialize paramaters that we do not vary for HIV problem, as well as
% the sparse grid library.
%basePath='C:\Users\xjm9\OneDrive - CDC\MATLAB\V10.05_HopeAndSobol\Detailed_Sobol_Example';
%modelName='HOPE Model V10_05_LB20230224_2_20231005_Fresh.xlsm';
%modelName='HOPE Model V10_04_BaseCase.xlsm';
%hopePath=strcat('.\',modelName);

%sheetName='TTProgression';


yearRange=(2017:1:2035)';

[yearInds,~]=find(yearRange>=2017);

offset=776;
numPeriods=3;

mm=(1:1:27)';
mmP=ones(10,1);

club27=mm*mmP';


indsTesting=[...
  899-offset;
  904-offset;
  905-offset;
  901-offset;
  902-offset;
  918-offset;
  923-offset;
  924-offset;
  920-offset;
  921-offset;
  937-offset;
  943-offset;
  944-offset;
  940-offset;
  941-offset;
];
attivInd=1;
lTest=(1:1:length(indsTesting)/numPeriods)';
lLast=lTest(end);
inds_ModelRHS=[lTest;lTest;lTest];
club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;


attivInd=attivInd+1;
inds2to3=((999-offset):1:(1007-offset))';

lTest=lLast+(1:1:length(inds2to3)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;


inds2to3_RR=[...
    1013-offset;
    1014-offset;
    1017-offset;
    1018-offset;
    1021-offset;
    1022-offset;
];


lTest=lLast+(1:1:length(inds2to3_RR)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;


inds3to2=((1023-offset):1:(1031-offset))';

lTest=lLast+(1:1:length(inds3to2)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

inds4to3=((1041-offset):1:(1049-offset))';
lTest=lLast+(1:1:length(inds4to3)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

inds5to4=((1078-offset):1:(1086-offset))';
lTest=lLast+(1:1:length(inds5to4)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

inds5to4_RR=[...
  1091-offset;
  1092-offset;
  1094-offset;
  1095-offset;
  1097-offset;
  1098-offset;
];
lTest=lLast+(1:1:length(inds5to4_RR)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

inds3to4=((1193-offset):1:(1201-offset))';
lTest=lLast+(1:1:length(inds3to4)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

inds4to5=((1211-offset):1:(1219-offset))';
lTest=lLast+(1:1:length(inds4to5)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

club27(lTest,(attivInd+1):end)=0;
club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

inds4to5_RR=[...
    1224-offset;
    1225-offset;
    1227-offset;
    1228-offset;
    1230-offset;
    1231-offset;
];
lTest=lLast+(1:1:length(inds4to5_RR)/numPeriods)';
lLast=(lTest(end));
inds_ModelRHS=[inds_ModelRHS;lTest;lTest;lTest];

%club27(lTest,(attivInd+1):end)=0;
%club27((lLast+1):end,attivInd)=0;
attivInd=attivInd+1;

indsAllParams=[indsTesting;inds2to3;inds2to3_RR;inds3to2;inds4to3;inds5to4;inds5to4_RR;inds3to4;inds4to5;inds4to5_RR];
%indsMap=[length(indsTesting)/n]
