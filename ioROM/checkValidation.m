
tempTable=zeros(num_Yrs,num_Outputs);
fprintf('Reading table... ');

%fileToRead='./ValidationSim/test_PC4.xlsx';
fileToRead='../EHEmodelOutputs/targetTest4.xlsx'      
    for jj=1:size(sheetNames,2)        
        tableIn=table2array(readtable(fileToRead,...
            'Sheet',sheetNames{jj},'Range',sheetRanges{jj}));
        tempTable(:,tableSlots(jj,1):tableSlots(jj,2))=tableIn;
    end

validationCalc=tempTable(end,:)';
validationNorm=stdMat\(validationCalc-rowMeans(:,1));