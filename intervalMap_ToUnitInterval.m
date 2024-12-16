function [normalizedPoint] = intervalMap_ToUnitInterval(origPoint,paramHypercube)
%INTERVALINVERSEMAP Summary of this function goes here
%   Detailed explanation goes here
    
    u0=paramHypercube(:,1);
    u1=paramHypercube(:,2)-paramHypercube(:,1);
    


    normalizedPoint= (origPoint-u0)./u1;

end

