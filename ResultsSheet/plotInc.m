colorMat=[...
    .000 .447 .741;
    .850 .325 .098;
    .929 .694 .125;
    .494 .184 .556;
    .466 .674 .188;
    .301 .745 .933;
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

lw=3;
lw2=2;
fs=18;
ms=10;
legendfs=18;

%posMat=[-1865,283,1137,585];
posMat=[-1865,522,739,346];
fileName='AV_2024_11_08_10.xlsx';

%cellRng='A1:B20';
% fileNames={...
% ...'AV_2024_11_08_10.xlsx',...
% ...'AV_2024_11_08_16.xlsx',...
% 'AV_2024_11_08_17.xlsx',...
% ...'AV_2024_11_08_19.xlsx',...
% 'EJ_2024_11_08_10.xlsx',...
% ...'EJ_2024_11_08_11.xlsx',...
% ...'EJ_2024_11_08_14.xlsx',...
% ...'EJ_2024_11_08_16.xlsx',...
% 'EJ_2024_11_08_19.xlsx',...
% 'EJ_2024_11_08_20.xlsx'
% };

fileNames={...
'AV_pinvRTI13.xlsx',...
'AV_pinvRTI14.xlsx',...
...'AV_2024_11_08_17.xlsx',...
...'AV_2024_11_08_19.xlsx',...
...'AV_2024_11_08_20.xlsx',...
...'EJ_2024_11_08_10.xlsx',...
...'EJ_2024_11_08_11.xlsx',...
...'EJ_2024_11_08_14.xlsx',...
...'EJ_2024_11_08_16.xlsx',...
...'EJ_2024_11_08_19.xlsx',...
...'EJ_2024_11_08_20.xlsx',...
...'EJ_2024_11_08_22.xlsx',...
...'EJ_2024_11_08_24.xlsx',...
...'AV_pinvTry10.xlsx',...
...'AV_pinvTry11.xlsx',...
...'AV_pinvTry15.xlsx'
};



fileLeg=strrep(fileNames,'.xlsx','');
fileLeg=strrep(fileLeg,'2024_11_08_','');
fileLeg=strrep(fileLeg,'Try','');
fileLeg=strrep(fileLeg,'_','');

tp=tiledlayout(1,1,'TileSpacing','compact','Padding','compact');
nexttile
for ii=1:size(fileNames,2)

    yrInc=readtable(fileNames{ii},'Sheet','IncAndDiag');
    yrInc.Year=str2num(cell2mat(yrInc.Row));
    plot(yrInc.Year,yrInc.annualIncidence,'--o','LineWidth',lw,'Color',colorMat(ii,:),'MarkerSize',ms);
    
    if mod(ii-1,4)==0
        hold on
    end
    
    ylabel('Annual incidence','FontSize',fs,'Interpreter','latex');
    xlabel('Year','FontSize',fs,'Interpreter','latex');
    ylim([27000 35000])
    xlim([2022 2035])

    set(gca,'FontSize',fs);
    ax=gca;
    ax.YAxis.Exponent=0;

    %if mod(ii,4)==0
    %legend
    %nexttile
    %end
end

legend(fileLeg,'NumColumns',2);
set(gcf,'Position',posMat);
