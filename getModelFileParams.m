function [ExcelValues_AllParameters, ExcelValues_Populations] = getModelFileParams(filePath,fileName)

%% 3. Import data from Excel to Matlab

    % Define path to Excel file
    %[folder, name, ext] = fileparts(which(mfilename));
    pathName = strcat(filePath,'\',fileName,'.xlsm'); %[folder  '\'  ExcelFileName];

    %Import the parameters
    ExcelValues_AllParameters = xlsread(pathName, 'ParameterList','matlab_ParameterList');
    ExcelValues_Populations = xlsread(pathName, 'Import_Populations','matlab_InitAndNewPops');
%     ExcelValues_AllParameters = xlsread(pathName, 'ParameterList','L388:L1787');
%     ExcelValues_Populations = xlsread(pathName, 'Import_Populations','C48:C6872');
%     ExcelValues_AllParametersStruct = load('ExcelValues_AllParameters.mat');
%     ExcelValues_PopulationsStruct = load('ExcelValues_Populations.mat');
%     ExcelValues_AllParameters = ExcelValues_AllParametersStruct.ExcelValues_AllParameters;
%     ExcelValues_Populations = ExcelValues_PopulationsStruct.ExcelValues_Populations;

end

