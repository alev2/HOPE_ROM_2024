%build the table
%readAndBuildTable

fs=14;
fs2=14;
posMat=[-1845,251,1628,441];
posMat2=[-1651,167,1044,619];

orangeColor=[.85 .325 .098];

%low-rank approximation - number of "meta variables" we want to keep
apx_Rank=4;
tileLayout=[2 4];
%normalize the model outputs
rowMeans=mean(modelOutputs,2)*ones(1,size(modelOutputs,2));
stdMat=diag(std(modelOutputs,0,2));
modelOutputsNorm=stdMat\(modelOutputs-rowMeans);

%perform SVD on model outputs to get the principal components
[UFull,SFull,VFull]=svd(modelOutputsNorm);

%low rank approximation
UApx=UFull(:,1:apx_Rank); 
SApx=SFull(1:apx_Rank,1:apx_Rank);
VApx=VFull(:,1:apx_Rank);

modelOutputsNorm_Apx=UApx*SApx*VApx';
modelOutputs_Apx=stdMat*modelOutputsNorm_Apx + rowMeans;

%
reduced_Outputs=(UApx')*modelOutputsNorm_Apx;

Sob_r=zeros(N, apx_Rank);
Tot_Sob_r=zeros(N,apx_Rank);
m_r=zeros(1,apx_Rank);
v_r=zeros(1,apx_Rank);


for kk=1:apx_Rank

    [Sob_tmp,Tot_Sob_tmp,mtmp,vtmp] = compute_sobol_indices_from_sparse_grid(S,Sr,reduced_Outputs(kk,:),domain,'legendre');     
    Sob_r(:,kk)=Sob_tmp;
    Tot_Sob_r(:,kk)=Tot_Sob_tmp;
    m_r(:,kk)=mtmp;
    v_r(:,kk)=vtmp;
    
end


colorMat=[...
    .000 .447 .741;
    .850 .325 .098;
    .929 .694 .125;
    .494 .184 .556;
    .466 .674 .188;
    .301 .745 .933;
    .635 .078 .184;
    ];




%tp=tiledlayout(1,3,'TileSpacing','compact','Padding','compact');
tp=tiledlayout(tileLayout(1),tileLayout(2),'TileSpacing','compact','Padding','compact');

ylims=[-40 40;...
       -40 40;...
       -40 40;...
       -10 10;...
       -20 20;...
       -20 20;...
       -15 15;...
       -15 15;...
       -10 10;...
       ];

for pp=1:apx_Rank
    nexttile
    bar(outputVarNms_Cat,UApx(:,pp)*SApx(pp,pp));
    ylabel('PCA Loading', 'Interpreter','latex','FontSize',50);
    ylim(ylims(pp,:));
    %xticklabels(interventionNames);
    title(strcat('$U_',num2str(1),'\cdot S_{',num2str(pp),',',num2str(pp),'}$'), 'Interpreter','latex','FontSize',70);
    set(gca,'FontSize',fs);
    ax=gca;
end




set(gcf,'Position',posMat2);
figure




%tp=tiledlayout(1,3,'TileSpacing','compact','Padding','compact');
tp=tiledlayout(tileLayout(1),tileLayout(2),'TileSpacing','compact','Padding','compact');

for jj=1:apx_Rank

    nexttile

    bar(inputVarNms_Cat, Tot_Sob_r(:,jj));
    hold on
    %bh=bar([3 5 6], Tot_Sob_r1([3 5 6]),'FaceColor',orangeColor)
    %bh=bar([13 15], Tot_Sob_r1([13 15]),'FaceColor',colorMat(2,:))
    
    ylabel('Total sobol index', 'Interpreter','latex','FontSize',50);
    ylim([0 .5])
    %xticklabels(interventionNames);
    title(strcat('PC',num2str(jj)), 'Interpreter','latex','FontSize',50);
    set(gca,'FontSize',fs2);
    ax=gca;

end


set(gcf,'Position',posMat);




