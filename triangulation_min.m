function [x_idx, y_idx, locationGridValue] = triangulation_min(ap_nums,xGridValue,yGridValue,ap_location,ap_toward,label_aoa,locationGridPts)

    for ap_num = 1:ap_nums
        ap_loc = ap_location(ap_num,:);
        y_yp = yGridValue - ap_loc(2);
        x_xp = xGridValue - ap_loc(1);
        thetaGridValue(ap_num,:) = abs(orientation_xy(x_xp,y_yp,ap_toward{ap_num})-label_aoa(ap_num));
    end
    
    locationGridValue = sum(thetaGridValue,1);
    [~,minloopvar] = min(locationGridValue);
    [x_idx, y_idx] = ind2sub(locationGridPts,minloopvar);     
    
end