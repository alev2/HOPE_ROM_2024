function [inToOut, outToIn,applyOp_out2In, applyOp_in2out, normalize_Input,normalize_Output,unNormalize_Input,unNormalize_Output] = hopeAutoEncod(hopeIn, hopeOut,apx_RankIn,apx_RankOut)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %low-rank approximation - number of "meta variables" we want to keep
    %apx_RankIn=18;
    %apx_RankOut=13;

    %normalize the model outputs
    rowMeans=mean(hopeIn,2)*ones(1,size(hopeIn,2));
    rm1=mean(hopeIn,2);
    stdMat=diag(std(hopeIn,0,2)+1e-10);
    hopeInNorm=stdMat\(hopeIn-rowMeans);

    
    %normalize the model outputs
    rowMeansOut=mean(hopeOut,2)*ones(1,size(hopeOut,2));
    rm2=mean(hopeOut,2);
    stdMatOut=diag(std(hopeOut,0,2));
    hopeOutNorm=stdMatOut\(hopeOut-rowMeansOut);

    [UFullIn,SFullIn,VFullIn]=svd(hopeInNorm);
    
    %semilogy(diag(SFullIn))
    %hold on

    %low rank approximation
    UApxIn=UFullIn(:,1:apx_RankIn); 
    SApxIn=SFullIn(1:apx_RankIn,1:apx_RankIn);
    VApxIn=VFullIn(:,1:apx_RankIn);

    [UFullOut,SFullOut,VFullOut]=svd(hopeOutNorm);
    %low rank approximation
    %semilogy(diag(SFullOut),'b')
    UApxOut=UFullOut(:,1:apx_RankOut); 
    SApxOut=SFullOut(1:apx_RankOut,1:apx_RankOut);
    VApxOut=VFullOut(:,1:apx_RankOut);
    
    
    outToIn=UApxIn*SApxIn*VApxIn'*(VApxOut*(SApxOut\(UApxOut')));
    inToOut=UApxOut*SApxOut*VApxOut'*(VApxIn*(SApxIn\(UApxIn')));

    normalize_Input=@(x)...
        stdMat\(x-rm1);

    normalize_Output=@(x)...
        stdMatOut\(x-rm2);

    unNormalize_Input=@(x)...
        stdMat*x+rm1;

    unNormalize_Output=@(x)...
        stdMatOut*x+rm2;


    applyOp_out2In=@(x)...
        unNormalize_Input( outToIn*normalize_Output(x) );

    applyOp_in2out=@(x)...
        unNormalize_Output( inToOut*normalize_Input(x) );


end