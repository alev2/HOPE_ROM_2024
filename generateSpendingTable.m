function [spendingTable] = generateRASpendingAndIncidenceTable(outcome,filePrefix,saveFile)

%   This outputs a spending table.
%   If saveFile is set to 1, then it will write a file with the name:
%   filePrefix_begin(BeginYr)_XXPct(1stGoalYr)_XXPct(2ndGoalYr).xlsx;
%   So if prefix is "./OutputFiles/EHE10Jun24" and we begin intervention in
%   2025, and we want a 
%   want a 75% incidence reduction in 2030, and 90% 2040 
%   then it will save a file called:
%   

%   EHE10Jun24_begin2025_75Pct2030_90Pct2040.xlsx 
%   to the directory "OutputFiles".


    yearArray=(outcome.set_FirstOutcomeYr:1:outcome.set_ModelEndYear); 

%    interventionStartYr=outcome.set_PeriodThreeStartYear;
    interventionStartYr=outcome.set_PeriodFiveStartYear;

    interventionFirstGoalYr=(interventionStartYr-1)+outcome.set_minCost_Tgt1NumYears;
    interventionSecondGoalYr=(interventionStartYr-1)+outcome.set_minCost_Tgt2NumYears;

    interventionFirstGoal=outcome.set_minCost_Tgt1PctReduce;
    interventionSecondGoal=outcome.set_minCost_Tgt2PctReduce;


%    outputString=
%     %strcat(...
%         filePrefix,...
%         'begin',...
%         num2str(interventionStartYr),...
%         '_',...
%         num2str(100*interventionFirstGoal),...
%         'Pct',...
%         num2str(interventionFirstGoalYr),...
%         '_',...
%         num2str(100*interventionSecondGoal),...
%         'Pct',...
%         num2str(interventionSecondGoalYr),...
%         '.xlsx'...
%         );
    
    outputString=strcat(filePrefix,'.xlsx');

    varNms=fieldnames(outcome);
    allocStrings=varNms(find(strcmp(extractBetween(varNms,1,6),'alloc_')==1));
    allocMat=[];
    
    for kk=1:size(allocStrings,1)
        allocMat=[allocMat;outcome.(allocStrings{kk})];
    end

    allocMat

    interventionNames={...
        'Year',...
        'TestLoHet',...
        'TestHiHet',...
        'TestLoMSM',...
        'TestHiMSM',...
        'TestPWID',...
        'LTCatDiag',...
        'LTCafterDiag',...
        'beginART',...
        'ARTadhRemainVLS',...
        'ARTadhBecomeVLS',...
        'SSP',...
        'PrEPtoHet',...
        'PrEPtoMSM',...
        'PrEPtoPWID',...    
        'HIVincidence'...
        }';

    HIVincidence=sum(outcome.ann_TotalNewInfections,2);
    %spendingOutput=JCspendingfunction(outcome)/1e6;
    spendingOutput=SpendingOutcomesInM(outcome);
    allocOut=[nan;allocMat(:,1);nan];
    

    spendingOutput=[yearArray;spendingOutput;HIVincidence'];

    size(spendingOutput)
    size(allocOut)

    spendingOutput=[ allocOut spendingOutput];
    spendingTable=array2table(spendingOutput);%,'RowNames',interventionNames);
    
    spendingTable.Properties.VariableNames{1}='InterventionAlloction';
    
    for kk=1:length(yearArray)
        spendingTable.Properties.VariableNames{kk+1}=strcat('Spending',num2str(yearArray(kk)));
    end

 
    if(saveFile==1)
        writetable(spendingTable,outputString,'WriteRowNames',1);
    end        


end

