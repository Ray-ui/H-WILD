%% Part0: Clear.
clear 
clc
close all

%% Part1: How to load a specific data. 
% In this section, we demonstrate how to load data that corresponds 
% to a specific room, a specific access point (AP), and a specific user, 
% while also considering the presence of interference from other individuals.
room_name = 'Lounge'; % Lounge,Office, Lab, Con.
ap_name = 'sRE5'; % sRE4, sRE6, sRE7, sRE22
user_id = '3'; % 1-5/1-7.
wo_interference = 'w';

if strcmp(room_name, 'Lounge')
    file_name = 'Lounge';
elseif strcmp(room_name, 'Office')
    file_name = 'Office';
elseif strcmp(room_name, 'Lab')
    file_name = 'Laboratory';
elseif strcmp(room_name, 'Con')
    file_name = 'Conference';
end
data_path = ['./',file_name,'/',room_name,'_',ap_name,'_user',user_id,'_',wo_interference,'.mat'];
load(data_path)

%% Part2: Experience the variation of Angle of Arrival (AoA).
figure;
plot(estimations_aoa,'LineWidth', 1);hold on;
plot(labels_aoa,'LineWidth', 1.5);hold on;
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');  
set(gcf,'Position',[100 100 700 400])
set(gca, 'LineWidth', 1.5);
legend('2D-FFT','Label');
xlabel('Packet count', 'fontsize', 16);
ylabel('AoA (degree)', 'fontsize', 16);

%% Part3: Experience the variation of the trajectory.
[ap_toward, ap_location, xLabels, yLabels] = obtain_parameters(room_name);
figure;
c = linspace(1, 10, size(uwb_coordinate_x,1));
scatter(uwb_coordinate_x, uwb_coordinate_y, [], c, 'filled');hold on;
set(gca, 'defaultAxesFontName', 'Times New Roman', 'defaultAxesFontSize', 14);
plot(ap_location(1,1), ap_location(1,2), 'o', 'MarkerFaceColor', 'red', 'MarkerSize', 10);hold on;
text(ap_location(1,1)+0.1, ap_location(1,2)+0.1,'AP1', 'FontSize', 14);hold on;
plot(ap_location(2,1), ap_location(2,2), 'o', 'MarkerFaceColor', 'blue', 'MarkerSize', 10);hold on;
text(ap_location(2,1)+0.1, ap_location(2,2)+0.1,'AP2', 'FontSize', 14);hold on;
plot(ap_location(3,1), ap_location(3,2), 'o', 'MarkerFaceColor', 'yellow', 'MarkerSize', 10);hold on;
text(ap_location(3,1)+0.1, ap_location(3,2)+0.1,'AP3', 'FontSize', 14);hold on;
plot(ap_location(4,1), ap_location(4,2), 'o', 'MarkerFaceColor', 'black', 'MarkerSize', 10);hold on;
text(ap_location(4,1)+0.1, ap_location(4,2)+0.1,'AP4', 'FontSize', 14);hold on;
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');  
set(gcf,'Position',[100 100 700 400])
set(gca, 'LineWidth', 1.5);
ylabel('y (m)', 'fontsize', 16);
xlabel('x (m)', 'fontsize', 16);
xlim([xLabels(1) xLabels(end)]);
ylim([yLabels(1) yLabels(end)]);

%% Part4: How to locate the target using one packet?
% Firstly, please select one of the packages.
packet_num = 5:5; 
% Then, we will load all the data packets from all APs at this moment(packet).
if strcmp(room_name, 'Lounge')
    ap_names = {'sRE4','sRE5','sRE6','sRE7'};
else
    ap_names = {'sRE22','sRE5','sRE6','sRE7'};
end
ap_nums = size(ap_names, 2);
estimation_ap = zeros(ap_nums,size(packet_num,2));
label_ap = zeros(ap_nums,size(packet_num,2));
for ap_i = 1:ap_nums
    data_path = ['./',file_name,'/',room_name,'_',ap_names{ap_i},'_user',user_id,'_',wo_interference,'.mat'];
    load(data_path)
    estimation_ap(ap_i,:) = estimations_aoa(packet_num);
end

locationGridPts = [size(xLabels,2),size(yLabels,2)];
GridStart = [min(xLabels),min(yLabels)]; 
GridStop = [max(xLabels),max(yLabels)];
GridSpacing = (GridStop - GridStart)./max(1, locationGridPts - ones(size(locationGridPts)));
numGridPoints = prod(locationGridPts);
[x_indices,y_indices] = ind2sub(locationGridPts,1:numGridPoints);
xGridValue = GridStart(1) + (x_indices-1)*GridSpacing(1);
yGridValue = GridStart(2) + (y_indices-1)*GridSpacing(2);

% Then we perform traditional triangulation for localization.
for pacekt_i = 1:size(packet_num, 2)
    [x_idx, y_idx, locationGridValue] = triangulation_min(ap_nums,xGridValue,yGridValue,ap_location,ap_toward,estimation_ap(:,pacekt_i),locationGridPts);
    x_fft = xLabels(x_idx);y_fft = yLabels(y_idx);
end

figure;
set(gca, 'defaultAxesFontName', 'Times New Roman', 'defaultAxesFontSize', 14);
subplot(1,2,1);
mesh(xLabels,yLabels,reshape(locationGridValue,locationGridPts)');
ylabel('y (m)', 'fontsize', 16);
xlabel('x (m)', 'fontsize', 16);
set(gca, 'XGrid','on');
set(gca, 'YGrid','on'); 
set(gca, 'LineWidth', 1.5);
xlim([xLabels(1) xLabels(end)]);
ylim([yLabels(1) yLabels(end)]);
title('Triangulation Heatmap')

subplot(1,2,2);
scatter(x_fft,y_fft);hold on;
set(gca, 'defaultAxesFontName', 'Times New Roman', 'defaultAxesFontSize', 14);
c = linspace(1, 10, size(packet_num,2));
scatter(uwb_coordinate_x(packet_num),uwb_coordinate_y(packet_num),[], c, 'filled');hold on;
plot(ap_location(1,1), ap_location(1,2), 'o', 'MarkerFaceColor', 'red', 'MarkerSize', 10);hold on;
text(ap_location(1,1)+0.1, ap_location(1,2)+0.1,'AP1', 'FontSize', 14);hold on;
plot(ap_location(2,1), ap_location(2,2), 'o', 'MarkerFaceColor', 'blue', 'MarkerSize', 10);hold on;
text(ap_location(2,1)+0.1, ap_location(2,2)+0.1,'AP2', 'FontSize', 14);hold on;
plot(ap_location(3,1), ap_location(3,2), 'o', 'MarkerFaceColor', 'yellow', 'MarkerSize', 10);hold on;
text(ap_location(3,1)+0.1, ap_location(3,2)+0.1,'AP3', 'FontSize', 14);hold on;
plot(ap_location(4,1), ap_location(4,2), 'o', 'MarkerFaceColor', 'black', 'MarkerSize', 10);hold on;
text(ap_location(4,1)+0.1, ap_location(4,2)+0.1,'AP4', 'FontSize', 14);hold on;
legend('Estimated Location','Label Location')
ylabel('y (m)', 'fontsize', 16);
xlabel('x (m)', 'fontsize', 16);
set(gca, 'XGrid','on');
set(gca, 'YGrid','on'); 
set(gca, 'LineWidth', 1.5);
title('Triangulation Result')
xlim([xLabels(1) xLabels(end)]);
ylim([yLabels(1) yLabels(end)]);
set(gcf,'Position',[500 500 1000 400])

%% Part5: How to get the Channel State Information?
specific_csi = squeeze(features_csi(packet_num,:));
figure;
plot(abs(reshape(specific_csi,30,3)));
ylabel('Amplitude', 'fontsize', 16);
xlabel('Subcarrier index', 'fontsize', 16);
legend('ant1','ant2','ant3');
set(gca, 'XGrid','on');
set(gca, 'YGrid','on'); 
set(gca, 'LineWidth', 1.5);