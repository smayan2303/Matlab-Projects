
%% Driver program for smartwatch display

% TODO your code here
clear;
clc;
close all;
img = imread('dome_area.jpg');

%% Get GPS data from user
% Note: For testing, use the following values
%   - row 622
%   - colum 942 
%   - time 935
% After you verify that you can create the sample images from the 
% project specs, then use the values returned by the GPS_data() function.

%call the GPS data function to get the data and scan_radiation to get a
%radiation image
[r,c,t] = GPS_data();
rad = scan_radiation(t);
%remove noise from the radiation image
rad = removeNoise(rad, 15);


%% Get display settings
% Note: For testing, use a zoom offset value of 173
% After you verify that you can create the sample images from the 
% project specs, then use the values returned by the displaySettings() function.

% TODO your code here
%use displays settings to get a zoom offset value
zoomOffset = display_settings();

%% Create the heatmap_local.png and zones_local.png images
% See the project spec for details.

% TODO your code here

%generate a heatmap using img and rad
heatmapimg = heatmap(img,rad);
%generate a radiation threat zone image
zonesimg = zones(img,rad);
%crop the heatmap and zones images using the offset value
img_heatmap = heatmapimg(r-zoomOffset:r+zoomOffset,c-zoomOffset:c+zoomOffset,:);
img_zones = zonesimg(r-zoomOffset:r+zoomOffset,c-zoomOffset:c+zoomOffset,:);
%save the images locally
imwrite(img_heatmap,'heatmap_local.png');
imwrite(img_zones,'zones_local.png');
%show the images on different figures
figure(1);
imshow('heatmap_local.png');
figure(2);
imshow('zones_local.png');
