function SpendingInM = SpendingOutcomesInM(Outcome)

SpendingInM(1:37,1:14) = 0;
M = 1000000;

SpendingInM (1,:) = sum(Outcome.ann_TransCost_CostTestAndNotify_LowRiskHETs_Undisc,2)'/M;
SpendingInM (2,:) = sum(Outcome.ann_TransCost_CostTestAndNotify_HighRiskHETs_Undisc,2)'/M;
SpendingInM (3,:) = sum(Outcome.ann_TransCost_CostTestAndNotify_LowRiskMSM_Undisc,2)'/M;
SpendingInM (4,:) = sum(Outcome.ann_TransCost_CostTestAndNotify_HighRiskMSM_Undisc,2)'/M;
SpendingInM (5,:) = sum(Outcome.ann_TransCost_CostTestAndNotify_PWID_Undisc,2)'/M;
SpendingInM (6,:) = sum(Outcome.ann_TransCost_LTCFirst_Undisc,2)'/M;
SpendingInM (7,:) = sum(Outcome.ann_TransCost_LTCAfter_Undisc,2)'/M;
SpendingInM (8,:) = sum(Outcome.ann_TransCost_ARTInitiation_Undisc,2)'/M;
SpendingInM (9,:) = sum(Outcome.ann_TransCost_RemainVLS_Undisc,2)'/M;
SpendingInM (10,:) = sum(Outcome.ann_TransCost_BecomeVLSfromANV_Undisc,2)'/M;
SpendingInM (11,:) = sum(Outcome.ann_SEPCost_B_Undisc,2)'/M;
SpendingInM (12,:) = sum(Outcome.ann_SEPCost_H_Undisc,2)'/M;
SpendingInM (13,:) = sum(Outcome.ann_SEPCost_O_Undisc,2)'/M;
%SpendingInM (14,:) = sum(Outcome.ann_healthStateCost_PrEP_Undisc_HighRiskHETs,2)'/M;
%SpendingInM (15,:) = sum(Outcome.ann_healthStateCost_PrEP_Undisc_HighRiskMSM,2)'/M;
%SpendingInM (16,:) = sum(Outcome.ann_healthStateCost_PrEP_Undisc_HighRiskIDUs,2)'/M;
SpendingInM (14,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskHETM_B,2)'/M;
SpendingInM (15,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskHETM_H,2)'/M;
SpendingInM (16,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskHETM_O,2)'/M;
SpendingInM (17,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskHETF_B,2)'/M;
SpendingInM (18,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskHETF_H,2)'/M;
SpendingInM (19,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskHETF_O,2)'/M;
SpendingInM (20,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskMSM_B,2)'/M;
SpendingInM (21,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskMSM_H,2)'/M;
SpendingInM (22,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_HighRiskMSM_O,2)'/M;
SpendingInM (23,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_IDU_B,2)'/M;
SpendingInM (24,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_IDU_H,2)'/M;
SpendingInM (25,:) = sum(Outcome.ann_healthStateCost_PrEP_Oral_Undisc_IDU_O,2)'/M;
SpendingInM (26,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskHETM_B,2)'/M;
SpendingInM (27,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskHETM_H,2)'/M;
SpendingInM (28,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskHETM_O,2)'/M;
SpendingInM (29,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskHETF_B,2)'/M;
SpendingInM (30,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskHETF_H,2)'/M;
SpendingInM (31,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskHETF_O,2)'/M;
SpendingInM (32,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskMSM_B,2)'/M;
SpendingInM (33,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskMSM_H,2)'/M;
SpendingInM (34,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_HighRiskMSM_O,2)'/M;
SpendingInM (35,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_IDU_B,2)'/M;
SpendingInM (36,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_IDU_H,2)'/M;
SpendingInM (37,:) = sum(Outcome.ann_healthStateCost_PrEP_Inject_Undisc_IDU_O,2)'/M;

end