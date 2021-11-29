%            Parameter file for qk detection                              %
%                                                                         % 
% ------------------      M.Mesimeri 05/2020  ----------------------------%
%               University of Utah seismograph Stations                   %
%               ----------------------------------------                  %
%                       Update:  11-12/2021 ++                            %
%                Swiss Seismological Service @ ETH Zurich                 %
%                        maria.mesimeri@sed.ethz.ch                       %
%-------------------------------------------------------------------------%                                                %

%path to templates and raw waveforms
templates_dir='./templates';
raw_dir='./raw';
%--------------------------------------------------------------------------
% Parallel settings
workers=4;                 %Set number of cores to work on a local machine
%-------------- Filtering parameters --------------------------------------
type='bandpass';           %'low', 'high', 'bandpass'
%co=1;                     %low or high corner frequency (high or low pass)
co=[1.5;15];               %low-high corner frequency for bandpass
%---------------- Template Parameters -------------------------------------
P_Bpick_win=0.1;           %Window before P arrival [in sec] 
S_Bpick_win=0.1;           %Window before S arrival [in sec]  
P_Apick_win=0.9;           %Window after P arrival [in sec]
S_Apick_win=1.9;           %Window after S arrival [in sec] 
%---------------------------------------------------------------------------
catalog='./event.dat';       %load cataloged events 
                             % Format: 
                             %Year Month Day Hr Min Sec Lat Lon Depth Mag ID
%--------------------------------------------------------------------------
%------------ Detection parameters-----------------------------------------
thres=9;                     %thres will be used as :(thres*MAD(x))
                             %where x the is the summed CC for the template
mindis=4;                    %Minimum distance between outstanding peaks [sec]
time_thres=4;                %Minimum distance between detections [sec]
%--------------------------------------------------------------------------
wlen=86400;                 %Length of waveforms (e.g. 1day=86400 seconds)           