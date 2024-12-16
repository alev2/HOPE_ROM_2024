function [sg_ptsMapped] = intervalMap(sg_pts,paramHypercube)
%INTERVALMAP Summary of this function goes here
%   Detailed explanation goes here
    
    u0=paramHypercube(:,1);
    u1=paramHypercube(:,2)-paramHypercube(:,1);
    


    sg_ptsMapped= u0 + u1.*sg_pts;
    
   
end

