function [] = appendSpendingFile(outputStruct,filePath)
%APPENDSPENDINGFILE Summary of this function goes here
%   Detailed explanation goes here

    baseSheetRange='E3:R39';

    baseSheetName='SpendingOutcomes';

    M=SpendingOutcomesInM(outputStruct);

    xlswrite(filePath,M,baseSheetName,baseSheetRange);

    

end

