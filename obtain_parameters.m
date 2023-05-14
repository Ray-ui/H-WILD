function [ap_toward, ap_location, xLabels, yLabels] = obtain_parameters(datset_name)

    if strcmp(datset_name, 'Con')
        ap_toward = {180, 90, 180, 90}; 
        xLabels = -3:0.1:7;
        yLabels = -3:0.1:7;
        ap_location = [-1.70000000000000,3;2,-0.600000000000000;4.60000000000000,3.40000000000000;2,6.60000000000000];

    elseif strcmp(datset_name, 'Office')
        ap_toward = {0, -90, 90, 0};
        xLabels = -3:0.1:7;
        yLabels = -4:0.1:12;
        ap_location = [5.70000000000000,3.40000000000000;1.40000000000000,9.20000000000000;3.20000000000000,-0.300000000000000;-1.50000000000000,4.80000000000000];

    elseif strcmp(datset_name, 'Lounge')
        ap_toward = {0, 180, 90, -90};
        xLabels = -4:0.1:12;
        yLabels = -2:0.1:14;
        ap_location = [-0.800000000000000,5.60000000000000;7.20000000000000,6.40000000000000;4,0;1.60000000000000,9.60000000000000];

    elseif strcmp(datset_name, 'Lab')
        ap_location = [-1.7, 3; 2, -1.1; 6, 3; 2, 6.3];
        xLabels = -2:0.1:10;
        yLabels = -2:0.1:10;
        ap_toward = {180, 90, 180, -90}; % vector [y,x].

    end

end

