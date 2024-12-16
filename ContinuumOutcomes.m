function ContinuumOutputs = ContinuumOutcomes(outcome)

ContinuumOutputs(1:22,1:14) = 0; % number of rows is for number of years

ContinuumOutputs (:,1) = sum(outcome.tr_LRHAllEligTestProb_AllYrs ,2);
ContinuumOutputs (:,2) = sum(outcome.tr_HRHAllEligTestProb_AllYrs ,2);
ContinuumOutputs (:,3) = sum(outcome.tr_LRMSMAllEligTestProb_AllYrs ,2);
ContinuumOutputs (:,4) = sum(outcome.tr_HRMSMAllEligTestProb_AllYrs ,2);
ContinuumOutputs (:,5) = sum(outcome.tr_IDUAllEligTestProb_AllYrs ,2);
ContinuumOutputs (:,6) = sum(outcome.ann_PctLinkToCareFirst ,2);
ContinuumOutputs (:,7) = sum(outcome.ann_LinkageAfterProb ,2);
ContinuumOutputs (:,8) = sum(outcome.ann_ARTPrescrProb ,2);
ContinuumOutputs (:,9) = sum(outcome.ann_VLSToANVProb ,2);
ContinuumOutputs (:,10) = sum(outcome.ann_ANVToVLSProb ,2);
ContinuumOutputs (:,11) = sum(outcome.ann_PctUninfPWIDServedbySEP ,2);
ContinuumOutputs (:,12) = sum(outcome.ann_PctEligOnPrEP_HRHET ,2);
ContinuumOutputs (:,13) = sum(outcome.ann_PctEligOnPrEP_HRMSM ,2);
ContinuumOutputs (:,14) = sum(outcome.ann_PctEligOnPrEP_PWID ,2);

end