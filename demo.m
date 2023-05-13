%%
clear 
clc
close all

%% Part1: How to load a specific data. 
% In this section, we demonstrate how to load data that corresponds 
% to a specific room, a specific access point (AP), and a specific user, 
% while also considering the presence of interference from other individuals.

file_name = 'Lounge'; % Office, Laboratory, Conference.
room_name = 'Lounge'; % Office, Lab, Con.
ap_name = 'sRE5'; % sRE4, sRE6, sRE7, sRE22
user_id = '3'; % 1,2,3,4,5.
wo_interference = 'w';

data_path = ['./',file_name,'/',room_name,'_',ap_name,'_user',user_id,'_',wo_interference,'.mat'];
load(data_path)

%% Part2: Experience the variation of Angle of Arrival (AoA).
figure;
plot(estimations_aoa,'LineWidth', 0.5);hold on;
plot(labels_aoa,'LineWidth', 1.5);hold on;
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');  
set(gcf,'Position',[100 100 700 400])
set(gca, 'LineWidth', 1.5);
legend('2D-FFT','Label');
xlabel('Packet count', 'fontsize', 16);
ylabel('AoA (degree)', 'fontsize', 16);

%% Part3: Experience the variation of the trajectory.

if strcmp(room_name, 'Lounge')
    ap_location = [-0.8,5.6; 7.2,6.4; 4,0; 1.6,9.6];        % Lounge.(sRE4,5,6,7)
elseif strcmp(room_name, 'Lab')
    ap_location = [-1.7, 3; 2, -1.1; 6, 3; 2, 6.3];         % Lab.(sRE22,5,6,7)
elseif strcmp(room_name, 'Con')
    ap_location = [-1.7,3; 2,-0.6; 4.6,3.4; 2,6.6];         % Con.(sRE22,5,6,7)
elseif strcmp(room_name, 'Office')
    ap_location = [5.7,3.4;1.4,9.2; 3.2,-0.3; -1.5,4.8];    % Office.(sRE22,5,6,7)
end

figure;
c = linspace(1, 10, size(uwb_coordinate_x,1));
scatter(uwb_coordinate_x,uwb_coordinate_y,[], c, 'filled');hold on;
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
ylabel('x (m)', 'fontsize', 16);
xlabel('y (m)', 'fontsize', 16);
