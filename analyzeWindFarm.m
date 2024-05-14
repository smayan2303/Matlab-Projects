

function [ c1, c2, c3, c4, c5 ] = analyzeWindFarm( filenameWind, ...
    filenameWave, filenameBuoy, windSpeedMin, windSpeedMax, ...
    waveHeightMax, waveHeightRisk, deckHeight )
% Function to complete Task 1. Evaluates the 5 constraints on the location of a
% wind farm.
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
%         waveHeightMax: for constraints 2 & 3 -- maximum wave height (m)
%        waveHeightRisk: for constraint 3 -- maximum wave height risk (%)
%            deckHeight: for constraint 4 -- height of the deck that supports 
%                        the turbine base (m)
%
%   return values:
%                    c1: boolean values corresponding to whether the wind 
%                        farm location passes constraint #1
%                    c2: boolean values corresponding to whether the wind 
%                        farm location passes constraint #2
%                    c3: boolean values corresponding to whether the wind 
%                        farm location passes constraint #3
%                    c4: boolean values corresponding to whether the wind 
%                        farm location passes constraint #4
%                    c5: boolean values corresponding to whether the wind 
%                        farm location passes constraint #5

%CONSTRAINT 1
%read in data
windSpeed = csvread(filenameWind);
Bouyindex = csvread(filenameBuoy,1,1,[1 1 1 2]);
%set x and y equal to the x and y coordinates of the Bouy
x = Bouyindex(1,1);
y = Bouyindex(1,2);
%Use booleans to see of contraint 1 is met or not
if windSpeed(x,y) > windSpeedMin && windSpeed(x,y) < windSpeedMax 
    c1 = true;
else 
    c1 = false;
end 

%CONSTRAINT 2
%read in data
waveHeight = csvread(filenameWave);
%Use booleans to see of contraint 2 is met or not
if waveHeight(x,y) < waveHeightMax
    c2 = true;
else
    c2 = false;
end

%CONSTRAINT 3
%read in data from Buoy test case file
BuoyWaves = csvread(filenameBuoy,5,1,[5 1 342 1]);
%get the total number of waves
TotalWaves = numel(BuoyWaves);
%make a variable for the waves that have a height less than the parameter
waveHeightsLessThanParameter = numel(BuoyWaves((BuoyWaves) < waveHeightMax));
%Use booleans to see of contraint 3 is met or not
if (waveHeightsLessThanParameter / TotalWaves) * 100 > waveHeightRisk
    c3 = true;
else
    c3 = false;
end


%make a variable for twice the height of Buoy Waves
RogueHeights = BuoyWaves .* 2;
%make a variable for the number of Buoy waves that are more than twice the
%deck height
RogueTester = sum(RogueHeights > deckHeight);
%Use booleans to see of contraint 4 is met or not
if RogueTester == 0
    c4 = true;
else
    c4 = false;
end

%make a variable for the standard deviation of BuoyWaves
STDbuoy = std(BuoyWaves);
%Use booleans to see of contraint 5 is met or not
if STDbuoy < 0.05 * waveHeight(x,y)
    c5 = true;
else 
    c5 = false;
   
end

