function [spendingTable] = generateSpendingTableBudgetCut(outcome,filePrefix,saveFile)

%   This outputs a spending table.
%   If saveFile is set to 1, then it will write a file with the name:
%   'filePrefix.xlsx'
%
%   So the path is included in the name obviously

    yearArray=(outcome.set_FirstOutcomeYr:1:outcome.set_ModelEndYear); 

    interventionStartYr=outcome.set_PeriodThreeStartYear;

    interventionFirstGoalYr=(interventionStartYr-1)+outcome.set_minCost_Tgt1NumYears;
    interventionSecondGoalYr=(interventionStartYr-1)+outcome.set_minCost_Tgt2NumYears;

    interventionFirstGoal=outcome.set_minCost_Tgt1PctReduce;
    interventionSecondGoal=outcome.set_minCost_Tgt2PctReduce;


    outputString=strcat(...
        filePrefix,...
        '.xlsx'...
        );


    varNms=fieldnames(outcome);
    allocStrings=varNms(find(strcmp(extractBetween(varNms,1,6),'alloc_')==1));
    allocMat=[];
    for kk=1:size(allocStrings,1)
        allocMat=[allocMat;outcome.(allocStrings{kk})];
    end


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
        'TotalTreatment',...
        'HIVincidence'...
        }';

    HIVincidence=sum(outcome.ann_TotalNewInfections,2);
    spendingOutput=JCspendingfunctionBC(outcome)/1e6;
    
    allocOut=[nan;allocMat(:,1);nan;nan];
    spendingOutput=[yearArray;spendingOutput;HIVincidence'];
    spendingOutput=[ allocOut spendingOutput];
    spendingTable=array2table(spendingOutput,'RowNames',interventionNames);
    
    spendingTable.Properties.VariableNames{1}='InterventionAlloction';
    
    for kk=1:length(yearArray)
        spendingTable.Properties.VariableNames{kk+1}=strcat('Spending',num2str(yearArray(kk)));
    end

 
    if(saveFile==1)
        writetable(spendingTable,outputString,'WriteRowNames',1);
    end        


end

