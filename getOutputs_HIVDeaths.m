function [contOfCare,deathsCOC,pctCOC,deathsPer100K  ] = getOutputs(outputStruct,fileOutPath)

% Useful function in our process of calibration and recalibration

    %continuum var names of interest
    varNms_CoC={...
      'Unaware',...
      'diagNoCare',...
      'careNoART',...
      'ARTnoVLS',...
      'VLS',...
      'Total'...
    };
    
    %death related var names
    varNms_Deaths={...
      'deathsUnaware',...
      'deathsDiagNoCare',...
      'deathsCareNoART',...
      'deathsARTnoVLS',...
      'deathsVLS',...
      'deathsAll'...
    };

    %aids death related var names
    varNms_AIDSDeaths={...
      'aidsDeathsUnaware',...
      'aidsDeathsDiagNoCare',...
      'aidsDeathsCareNoART',...
      'aidsDeathsARTnoVLS',...
      'aidsDeathsVLS'...
    };

     varNms_PrEP={...
      'numOnPrEP',...
      'numEligForPrEP',...
      'prepCvg'
    };

    %death rate related var names
    varNms_DeathRate={...
      'deathRateUnaware',...
      'deathRateDiagNoCare',...
      'deathRateCareNoART',...
      'deathRateARTnoVLS',...
      'deathRateVLS',...
      'deathRateAll'...
    };
    
    %percentage outcomes
    varNms_Pcts={...
      'pctUnaware',...
      'pctDiagNoCare',...
      'pctCareNoVLS',...
      'pctCareARTNoVLS',...
      'pctVLS',...
      'pctAll'...
    };

    %inc and diag outcomes
    varNms_IncDiag={...
      'annualIncidence',...
      'annualNewDiagnoses',...
    };
    
    %relevant years in question
    yrs=(outputStruct.set_FirstOutcomeYr:1:outputStruct.set_LastOutcomeYr)';

    
    %get base numerical outcomes of interest
    pwhAll=sum(outputStruct.ann_HIVPrevalence,2);
    pwhAwr=sum(outputStruct.ann_NumberAware,2);
    pwhUnawr=pwhAll-pwhAwr;
    pwhInCare=sum(outputStruct.ann_NumberInCare,2);
    pwhNotInCare=pwhAwr-pwhInCare;    
    pwhART=sum(outputStruct.ann_NumberOnART,2);    
    pwhVLS=sum(outputStruct.ann_NumberVLS,2);    

    pwhInCareNotART=pwhInCare-pwhART;
    pwhARTnotVLS=pwhART-pwhVLS;


    numOnPrEP=round(sum(outputStruct.ann_NumberOnPrEP,2));
    numEligForPrEP=round(sum(outputStruct.ann_NumberEligForPrEP,2));
    pctCvgPrEP=numOnPrEP./numEligForPrEP;
    

    %continuum outputs
    contOfCare=...
        round([
            pwhUnawr';
            pwhNotInCare';
            pwhInCareNotART';
            pwhARTnotVLS';
            pwhVLS';
        ]);

    prepTab=...
        [numOnPrEP';
         numEligForPrEP';
         pctCvgPrEP'];
    
    prepTab=prepTab';

    %death related outputs
    deathsUnawr=sum(outputStruct.ann_numDeathsHIVPosUndiag,2);
    deathsAwr=sum(outputStruct.ann_numDeathsPLWHAware,2);
    deathsNotInCare=sum(outputStruct.ann_numDeathsCCStage2,2);
    deathsARTnotVLS=sum(outputStruct.ann_numDeathsCCStage4,2);
    deathsVLS=sum(outputStruct.ann_numDeathsVLS,2);

    deathsInCare=deathsAwr-deathsNotInCare;
    deathsInCareNotART=deathsInCare-(deathsARTnotVLS+deathsVLS);
    
    %deathsInCareNotVLS=deathsInCare-deathsVLS;


    annInc=sum(outputStruct.ann_TotalNewInfections,2);
    annDiag=sum(outputStruct.ann_TotalNewDiagnoses,2);

    incAndDiag=round([annInc annDiag]);

    %deaths organized by continuum stage
    deathsCOC=round([...
       deathsUnawr';
       deathsNotInCare';
       deathsInCareNotART';...
       deathsARTnotVLS';
       deathsVLS';
    ]);


    aidsDeathsUnawr=sum(outputStruct.ann_numAIDSDeathsHIVPosUndiag,2);
    aidsDeathsAwrNotInCare=sum(outputStruct.ann_numAIDSDeathsCCStage2,2);
    aidsDeathsInCareNotART=sum(outputStruct.ann_numAIDSDeathsCCStage3,2);
    aidsDeathsARTnotVLS=sum(outputStruct.ann_numAIDSDeathsCCStage4,2);
    aidsDeathsVLS=sum(outputStruct.ann_numAIDSDeathsVLS,2);
    aidsDeathsCOC=round([ ...
        aidsDeathsUnawr';
        aidsDeathsAwrNotInCare';
        aidsDeathsInCareNotART';
        aidsDeathsARTnotVLS';
        aidsDeathsVLS';
        ]);
    aidsDeathsCOC=aidsDeathsCOC';
    
    %get continuum %s
    contOfCare=contOfCare';
    contOfCare=[contOfCare sum(contOfCare,2)];
    pctCOC=diag(round(pwhAll))\contOfCare;

    %get mortality rates per 100k by continuum stage
    deathsCOC=deathsCOC';
    deathsCOC=[deathsCOC sum(deathsCOC,2)];
    deathsPer100K=round(100000*(deathsCOC./contOfCare));    

    %numerical continuum table
    contOfCare=array2table(contOfCare,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_CoC);

    %pctage continuum table
    pctCOC=array2table(pctCOC,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_Pcts);

    %death continuum table
    deathsCOC=array2table(deathsCOC,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_Deaths);


    %death rate continuum table
    deathsPer100K=array2table(deathsPer100K,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_DeathRate);

    %death rate continuum table
    incAndDiag=array2table(incAndDiag,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_IncDiag);

    prepTab=array2table(prepTab,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_PrEP);

    %death continuum table
    aidsDeathsCOC=array2table(aidsDeathsCOC,...
        'RowNames',string(yrs),...
        'VariableNames',varNms_AIDSDeaths);
    
    %write excel out
    writetable(incAndDiag,fileOutPath,'Sheet','IncAndDiag','WriteVariableNames',true,'WriteRowNames',true);
    writetable(contOfCare,fileOutPath,'Sheet','TotalPWH','WriteVariableNames',true,'WriteRowNames',true);
    writetable(pctCOC,fileOutPath,'Sheet','continuumPct','WriteVariableNames',true,'WriteRowNames',true);
    writetable(prepTab,fileOutPath,'Sheet','PrEP','WriteVariableNames',true,'WriteRowNames',true);
    writetable(deathsCOC,fileOutPath,'Sheet','TotalDeaths','WriteVariableNames',true,'WriteRowNames',true);
    writetable(deathsPer100K,fileOutPath,'Sheet','DeathsPer100K','WriteVariableNames',true,'WriteRowNames',true);
    writetable(aidsDeathsCOC,fileOutPath,'Sheet','AIDSdeaths','WriteVariableNames',true,'WriteRowNames',true);


end

