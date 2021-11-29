%         Package to detect earthquakes using templates                   %
%                                                                         %
% ---------------       M.Mesimeri 05-06/2020                -------------%
%               University of Utah seismograph Stations                   %
%               ----------------------------------------                  %
%                           Update:  11-12/2021 ++                        %
%                Swiss Seismological Service @ ETH Zurich                 %
%                        maria.mesimeri@sed.ethz.ch                       %
%--------------------------------------------------------------------------

%% 00. Setup
clear;clc;close all; tic %start timer
parameters %load parameter file
pdir=sprintf('%s/src/',pwd);  % get working directory path
addpath(genpath(pdir)); %add all *.m scripts to path
parpool('local',workers); %Start parallel pool
cat=load(catalog); % load cataloged events
%% 01. Work with templates
disp('Prepare templates..')
[templates,ids]=get_templates(templates_dir,type,co,P_Bpick_win,P_Apick_win,S_Bpick_win,S_Apick_win);

%% 02. Work with daily waveforms
[N,directories]=list_waveforms_dir(raw_dir); % list directories and work on each day

for i=1:N   
waveforms=get_waveforms(raw_dir,directories(i).name,type,co,wlen);
disp(directories(i).name)

%% 03. Matched filtering
disp('Matched Filtering..')
[pks,locs,npairs]=get_new_qks(waveforms,templates,ids,thres,mindis,wlen);

if sum(cellfun('length',pks))>0
%% 04. Finalize detections
disp('Detections...')
[detections,newcat]=get_detections(waveforms,pks,locs,npairs,cat,time_thres);

%% 05. Magnitudes
disp('Magnitudes...')
[mags,newcat]=get_magnitudes(waveforms,templates,newcat,detections);

%% 06. Output for the day
disp('Output...')
my_output(newcat,templates,directories(i).name,waveforms);
else
    fprintf('No earthquakes today %s! \n',directories(i).name)
end

%save output for the day - just in case
filename=sprintf('%s.mat',directories(i).name);
save(filename)


end

%% 06. Shutdown parallel pool
delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer
