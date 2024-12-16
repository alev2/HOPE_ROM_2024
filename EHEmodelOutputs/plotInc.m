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
fs=16;
ms=10;
legendfs=14;

%posMat=[-1865,283,1137,585];
%posMat=[-1865,222,1302,646];
posMat=[0,222,1302,646];
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
'Baseline_wEHE_3pds.xlsx',...
'Baseline_wNoEHE_3pds.xlsx',...
};


eheInt=2024.125;

fileLeg=strrep(fileNames,'.xlsx','');
fileLeg=strrep(fileLeg,'2024_11_08_','');
fileLeg=strrep(fileLeg,'Try','');
fileLeg=strrep(fileLeg,'_w','');
fileLeg=strrep(fileLeg,'Baseline','');
fileLeg=strrep(fileLeg,'_AB','');
fileLeg=strrep(fileLeg,'_Pinv14','');
fileLeg=strrep(fileLeg,'_3pds','');
fileLeg=[fileLeg 'EHE funding stop']

tp=tiledlayout(2,2,'TileSpacing','compact','Padding','compact');
nexttile
for ii=1:size(fileNames,2)

    yrInc=readtable(fileNames{ii},'Sheet','IncAndDiag');
    yrInc.Year=str2num(cell2mat(yrInc.Row));
    plot(yrInc.Year,yrInc.annualIncidence,'--','LineWidth',lw,'Color',colorMat(ii,:),'MarkerSize',ms);
    
    if mod(ii-1,4)==0
        hold on
    end
    
    ylabel('Annual incidence','FontSize',fs,'Interpreter','latex');
    xlabel('Year','FontSize',fs,'Interpreter','latex');
    ylim([27000 40000])
    xlim([2022 2030])

    set(gca,'FontSize',fs);
    ax=gca;
    ax.YAxis.Exponent=0;

    %if mod(ii,4)==0
    %legend
    %nexttile
    %end
end

plot([eheInt eheInt],[0 100000],'-.k','LineWidth',lw);

legend(fileLeg,'NumColumns',1,'FontSize',legendfs,'Interpreter','latex');

nexttile
for ii=1:size(fileNames,2)

    yrInc=readtable(fileNames{ii},'Sheet','continuumPct');
    yrInc.Year=str2num(cell2mat(yrInc.Row));
    plot(yrInc.Year,100*(1-yrInc.pctUnaware),'--','LineWidth',lw,'Color',colorMat(ii,:),'MarkerSize',ms);
    
    if mod(ii-1,4)==0
        hold on
    end
    
    ylabel('\%PWH aware of status','FontSize',fs,'Interpreter','latex');
    xlabel('Year','FontSize',fs,'Interpreter','latex');
    ylim([85 100])
    xlim([2022 2030])

    set(gca,'FontSize',fs);
    ax=gca;
    ax.YAxis.Exponent=0;

    %if mod(ii,4)==0
    %legend
    %nexttile
    %end
end

plot([eheInt eheInt],[0 100],'-.k','LineWidth',lw);


legend(fileLeg,'NumColumns',1,'FontSize',legendfs,'Interpreter','latex');
set(gcf,'Position',posMat);



nexttile
for ii=1:size(fileNames,2)

    yrInc=readtable(fileNames{ii},'Sheet','continuumPct');
    yrInc.Year=str2num(cell2mat(yrInc.Row));
    plot(yrInc.Year,100*(yrInc.pctVLS./(1-yrInc.pctUnaware)),'--','LineWidth',lw,'Color',colorMat(ii,:),'MarkerSize',ms);
    
    if mod(ii-1,4)==0
        hold on
    end
    
    ylabel('\%PWDH with VLS','FontSize',fs,'Interpreter','latex');
    xlabel('Year','FontSize',fs,'Interpreter','latex');
    ylim([50 80])
    xlim([2022 2030])

    set(gca,'FontSize',fs);
    ax=gca;
    ax.YAxis.Exponent=0;

    %if mod(ii,4)==0
    %legend
    %nexttile
    %end
end

plot([eheInt eheInt],[0 100],'-.k','LineWidth',lw);


legend(fileLeg,'NumColumns',1,'FontSize',legendfs,'Interpreter','latex');


nexttile
for ii=1:size(fileNames,2)

    yrInc=readtable(fileNames{ii},'Sheet','TotalDeaths');
    yrInc.Year=str2num(cell2mat(yrInc.Row));
    plot(yrInc.Year,yrInc.deathsAll-yrInc.deathsUnaware,'--','LineWidth',lw,'Color',colorMat(ii,:),'MarkerSize',ms);    
    if mod(ii-1,4)==0
        hold on
    end
    
    ylabel('Annual deaths, PWDH','FontSize',fs,'Interpreter','latex');
    xlabel('Year','FontSize',fs,'Interpreter','latex');
    ylim([17500 30000])
    xlim([2022 2030])

    set(gca,'FontSize',fs);
    ax=gca;
    ax.YAxis.Exponent=0;

    %if mod(ii,4)==0
    %legend
    %nexttile
    %end
end

plot([eheInt eheInt],[0 50000],'-.k','LineWidth',lw);


legend(fileLeg,'NumColumns',1,'FontSize',legendfs,'Interpreter','latex');

set(gcf,'Position',posMat);
