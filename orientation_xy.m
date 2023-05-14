function [labels_angle] = orientation_xy(x_xp,y_yp,ap_aoa)
  
    if ap_aoa == 0
        temp = abs(atan(y_yp./x_xp).*180/pi);
        temp_symbol = y_yp; % y 
        symbol = zeros(size(temp_symbol));
        symbol(temp_symbol >= 0) = -1;
        symbol(temp_symbol < 0) = 1;
        labels_angle = symbol.*temp;
        
    elseif ap_aoa == 90
        temp = abs(atan(x_xp./y_yp).*180/pi);
        temp_symbol = x_xp; % x 
        symbol = zeros(size(temp_symbol));
        symbol(temp_symbol < 0) = -1;
        symbol(temp_symbol >= 0) = 1;
        labels_angle = symbol.*temp;
        
    elseif ap_aoa == -90
        temp = abs(atan(x_xp./y_yp).*180/pi);
        temp_symbol = x_xp; % x 
        symbol = zeros(size(temp_symbol));
        symbol(temp_symbol < 0) = 1;
        symbol(temp_symbol >= 0) = -1;
        labels_angle = symbol.*temp;
        
    elseif ap_aoa == 180
        temp = abs(atan(y_yp./x_xp).*180/pi);
        temp_symbol = y_yp; % y 
        symbol = zeros(size(temp_symbol));
        symbol(temp_symbol < 0) = -1;
        symbol(temp_symbol >= 0) = 1;
        labels_angle = symbol.*temp;
    end

end

