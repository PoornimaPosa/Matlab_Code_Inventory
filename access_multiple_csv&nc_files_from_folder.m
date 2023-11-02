clc
clear all
close all

%% read multiple .csv files from folder
files = dir('P:\G\1.1 research\analysis\NSGEV\*.csv'); %% path to folder
fullpaths = fullfile({files.folder}, {files.name});
%% read data
for ii = 1:length(fullpaths)
    data{ii}=readtable(fullpaths{ii});
end

%% read multiple NETCDF files from folder
for y = 1:n  %% n is number of nc files you wish to read at once
    X="P:\G\Datasets\"+num2str(years(y))+".nc"; %% path to folder
    %% use ncdisp(path) to see .nc file and replace the name of attribute in nc file here
    data{y}=ncread(X,'attribute you want'); 
end