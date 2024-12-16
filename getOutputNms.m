

inputFil='./sobolCals_ExpandedInputs5Dec24/ModelRun12.xlsx';

runName='sobolAnalysisExpandedInputs_5Dec24';
outputDir='./finalSobolResults/';
startYr=num2str((1)); endYr=num2str(1);


% sheetNames={...
%   'IncAndDiag',...
%   'TotalPWH',...
%   'continuumPct',...
%   'TotalDeaths',...
%   'DeathsPer100k'
% };


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


sheetNames={...
  'IncAndDiag',...
  ...'TotalPWH',...
  'continuumPct',...
  'TotalDeaths',...
  ...'DeathsPer100k'
};

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

outputVarNms={};

for jj=1:size(sheetNames,2)        
    tableIn=(readtable(inputFil,...
        'Sheet',sheetNames{jj},'Range',sheetRanges{jj} ,'ReadVariableNames',1));
%        values_(:,tableSlots(jj,1):tableSlots(jj,2),k)=tableIn;
    outputVarNms=[outputVarNms tableIn.Properties.VariableNames];
end


save(strcat(outputDir,runName,'_outputVarNms'),'outputVarNms');


inputTab=readtable(strcat(outputDir,runName,'_inputNames.xlsx'),'ReadRowNames',1);
inputVarNms=inputTab.Properties.RowNames;

save(strcat(outputDir,runName,'_inputVarNms'),'inputVarNms');


