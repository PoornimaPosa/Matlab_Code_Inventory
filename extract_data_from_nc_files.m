clc
clear all
close all

%% extract IMD data at all grids in a basin

%% load lat long data of grids in a basin as .mat file, store 1st column as longitude and 2nd column as latitudes
latlon_basin = readmatrix("P:\G\basantpur.csv") % change path in your computer

%% suppose you want to extract for year 2020

% give full patha nd file name
filename = "P:\G\4.2 Datasets\IMD data analysis\imd_rainfall_ncfiles\2020.nc";
% to see the attributes, use ncdisp
ncdisp(filename)
% to read each attributes, say in IMD data, attributes are Latitude,
% Longiude, Time and Rainfall
lon = ncread(filename,'LONGITUDE');
lat = ncread(filename,'LATITUDE');
data=ncread(X,'RAINFALL');

%% To read multiple .nc files in a folder and extract data at grids in a basin
years = [1991,1992, 1993,1994, 1995, 1996, 1997, 1998, 1999, 2000];
for y = 1:length(years)             %% to read each year
    X="P:\G\4.2 Datasets\IMD data analysis\imd_rainfall_ncfiles\"+num2str(years(y))+".nc";
    data=ncread(X,'RAINFALL');      %% read data of each year
    %% read lat long values of basin
    for i = 1:length(lon)           %% for each longitude in nc file
        for j = 1:length(lat)       %% for each latitude in nc file
            for k = 1:length(latlon_basin)  %% for each lat long in basin
                if ((latlon_basin(k,1) == lon(i)) && (latlon_basin(k,2) == lat(j)))  %% if lat and long of a grid in basin == lon and lat o grid in nc file
                    data_basin{y}(k,:) = data(i,j,:);
                end
            end
        end
    end
end