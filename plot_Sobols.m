
colorMat=[...
    .850 .325 .098;
    .929 .694 .125;
    .494 .184 .556;
    .466 .674 .188;
    .301 .745 .933;
    .850 .325 .098;
    .929 .694 .125;
    .494 .184 .556;
    .466 .674 .188;
    .301 .745 .933;
    .000 .447 .741;
    .635 .078 .184;
    .1235 .078 .484;
    .8235 .3278 .384;
    .5235 .7278 .184;
    .11 .66 .55;
    .51 .26 .85;
    .51 .96 .05;
    .51 .556 .15;
    .151 .356 .75;
    0 0 0    
    ];


lineStyles={...
    '--^',...
    '--d',...
    '--s',...
    '--o',...
    '--p',...
    ':^',...
    ':d',...
    ':s',...
    ':o',...
    ':p',...
    '-',...
};

lw=4;
lw2=4;
fs=25;
fs2=15;
legendfs=15;
ms=8;


%runName='sobolAnalysis4Dec24ExpandedInputs';
runName='sobolAnalysisExpandedInputs_9Dec24';
outputDir='./finalSobolResults/';

figureDirPNG=strcat(outputDir,runName,'_Figures/PNG/');
figureDirEPS=strcat(outputDir,runName,'_Figures/EPS/');
dotPNG='.png';
dotEPS='.eps';

load(strcat(outputDir,runName,'_Tot_Sob_2022'));
load(strcat(outputDir,runName,'_inputVarNms'));
load(strcat(outputDir,runName,'_outputVarNms'));
%outputVarNms{11}='pctCareNoART';
outputVarNms{5}='pctCareNoART';


inputVarNms=strrep(inputVarNms,'_',' ');
inputVarNms=strrep(inputVarNms,' r ','');
inputVarNms=strrep(inputVarNms,'tt ','');
inputVarNms=strrep(inputVarNms,' 1 ','');
inputVarNms=strrep(inputVarNms,'1 ','');

inputVarNms=strrep(inputVarNms,'dropOutProb ','');

inputVarNms=strrep(inputVarNms,'relRiskPop ','');

inputVarNms_Cat=categorical(inputVarNms);
inputVarNms_Cat=reordercats(inputVarNms_Cat,inputVarNms);



posMat=[-1865,181,1583,687];

%fourVars=[1;2;3;4];


for jj=1:size(outputVarNms,2)
    tp=tiledlayout(1,1,'TileSpacing','compact','Padding','compact');
    
    nexttile
    bar(inputVarNms_Cat,Tot_Sob_2022(:,jj));
    
    ylabel('Total sobol index', 'Interpreter','latex','FontSize',50);
    ylim([0 .5])
    
    title(num2str(outputVarNms{jj}), 'Interpreter','latex','FontSize',50);
    set(gca,'FontSize',fs2);
    ax=gca;
    set(gcf,'Position',posMat);
    
    saveas(gcf,strcat(figureDirEPS,outputVarNms{jj}),'epsc' );
    saveas(gcf,strcat(figureDirPNG,outputVarNms{jj}),'png' );


    close all


end