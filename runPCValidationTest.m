


load('./initialConds/ExcelValues_AllParameters.mat');
load('./initialConds/ExcelValues_Populations.mat');

Parameters_Cur=ExcelValues_AllParameters;

load('./ioROM/newInVals.mat');
sg_pts=newInVals;
%prepMult_Black_SimVal=sg_pts(1,i);
%prepMult_Hisp_SimVal=sg_pts(2,i);
i=1;
Parameters_Cur(inds2to3)=[sg_pts(1:3,i);sg_pts(1:3,i);sg_pts(1:3,i)];
Parameters_Cur(inds2to3_RR)=[sg_pts(4:5,i);sg_pts(4:5,i);sg_pts(4:5,i)];
Parameters_Cur(inds3to2)=[sg_pts(6:8,i);sg_pts(6:8,i);sg_pts(6:8,i)];
Parameters_Cur(inds4to3)=[sg_pts(9:11,i);sg_pts(9:11,i);sg_pts(9:11,i)];
Parameters_Cur(inds5to4)=[sg_pts(12:14,i);sg_pts(12:14,i);sg_pts(12:14,i)];
Parameters_Cur(inds5to4_RR)=[sg_pts(15:16,i);sg_pts(15:16,i);sg_pts(15:16,i)];
Parameters_Cur(inds3to4)=[sg_pts(17:19,i);sg_pts(17:19,i);sg_pts(17:19,i)];
Parameters_Cur(inds4to5)=[sg_pts(20:22,i);sg_pts(20:22,i);sg_pts(20:22,i)];
Parameters_Cur(inds4to5_RR)=[sg_pts(23:24,i);sg_pts(23:24,i);sg_pts(23:24,i)];

[outTest, Params]=HIVEpiModel_Sobol(Parameters_Cur, ExcelValues_Populations);

[~]=getOutputs(outTest,strcat('./ioROM/ValidationSim/test_PC4.xlsx'));

