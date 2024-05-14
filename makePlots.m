

function [  ] = makePlots( filenameWind, filenameWave, filenameBuoy, ...
    windSpeedMin, windSpeedMax, waveHeightMax )

%   Function to complete Task 2. Creates a figure with multiple plots that 
%   summarizes the environmental conditions for a wind farm.  Saves figure as 
%   a .png file.
%
%   parameters: 
%          filenameWind: a string that names the file containing the 
%                        global-model-based average wind speed 
%                        (i.e. 'windSpeedTestCase.csv')
%          filenameWave: a string that names the file containing the 
%                        global-model-based average global wave heights 
%                        (i.e. 'waveHeightTestCase.csv')
%          filenameBuoy: a string that names the file containing the time 
%                        series of wave heights measured by the buoy          
%                        (i.e. 'buoyTestCase.csv')
%          windSpeedMin: for constraint 1 -- minimum wind speed (m/s)
%          windSpeedMax: for constraint 1 -- maximum wind speed (m/s)
%         waveHeightMax: for constraint 2 -- maximum wave height (m)
%
%   return values: none
%
%   notes:
%       Feel free to use different variable names than these if it makes 
%       your code more readable to you.  These are internal to your 
%       function, so it doesn't matter what you call them.


% Get lat/lon data
lat = csvread('lat.csv');
lon = csvread('lon.csv');

% Read in the rest of the data you need...
Bouyindex = csvread(filenameBuoy,1,1,[1 1 1 2]);
x = Bouyindex(1,1);
y = Bouyindex(1,2);


%% Make Plots
%FIRST GRAPH
%make a meshgrid of latitude and longitude
[A,B] = meshgrid(lon, lat);
%read in the data
C = csvread(filenameWind);
%make a subplot and a colormap
subplot(3,2,1);
colormap;
%make the contour plot and put a colorbar
contourf(A,B,C,'lineStyle', 'none');
colorbar;
%add titles and labels
title("Average Wind Speed (m/s) Across Planet");
xlabel("longitude (deg)");
ylabel("latitude (deg)");
set(gca,'ytick', -80:20:80);

%SECOND GRAPH
%read in the file for waves
D = csvread(filenameWave);
%state the area of the figure its gonna be in
subplot(3,2,2);
colormap;
%make the contour plot and put a colorbar
contourf(A,B,D,'lineStyle', 'none');
colorbar;
%add titles and labels
title("Average Wave Height (m) Across Planet");
xlabel("longitude (deg)");
ylabel("latitude (deg)");
set(gca,'ytick', -80:20:80);    

%THIRD GRAPH
%make a matrix for where all the contraints are met
E = (C < windSpeedMax & C > windSpeedMin & D < waveHeightMax);
%set the subplot and make the contour map
ax1 = subplot(3,2,3);
contourf(A,B,E,'lineStyle', 'none');
%make it gray inverse
colormap(ax1, flipud(gray));
%on the same map use scatter to plot the location of the buoy
hold on;
scatter(A(x,y),B(x,y),200,'square','LineWidth',3, 'MarkerEdgeColor', [1 0 0]);
hold off;
%add titles and labels
title("Potential Wind Farm Locations");
xlabel("longitude (deg)");
ylabel("latitude (deg)");


%FOURTH GRAPH
%read in the buoy waves file for wave height
BuoyWaves = csvread(filenameBuoy,5,1,[5 1 342 1]);
%make the subplot and plot the histogram
subplot(3,2,4);
histogram(BuoyWaves);
%add titles and labels and turn the grid on
title("Wave Heights at Buoy Location");
xlabel("wave height (m)");
set(gca,'xtick',2:2:8);
ylabel("number of occurrences");
grid on;


%FIFTH GRAPH
%read in the time column of the buoy test case
Time = csvread(filenameBuoy,5,0,[5 0 342 0]);
%get the location of the buoy
Bouyindex = csvread(filenameBuoy,1,1,[1 1 1 2]);
x = Bouyindex(1,1);
y = Bouyindex(1,2);
%get the average and set the subplot
average = Time .* 0 + D(x,y);
subplot(3,2,[5 6]);
plot(Time,BuoyWaves,Time,average);
%add title and labels and grid
grid on;
title("Wave Height Comparison: Global to Local");
xlabel("time (hours)");
ylabel("wave height (m)");
legend('Buoy-measured','Global average');


print('environmentalSummary.png','-dpng');
% Make the plots...


end

