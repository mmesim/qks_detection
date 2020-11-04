function [ndetections,newcat]=get_detections(waveforms,pks,locs,npairs,cat,time_thres)
% Function to finalize detections for the day
% returns: (i) a catalog with new detected qks [newcat]
%-----------------------------------------------------------------------------------


%01. Keep unique detections 
detections=associate_detections(pks,locs,npairs,time_thres./waveforms(1).DELTA);

%02. Remove self detections and cataloged events
[ndetections,newcat]=get_newcat(detections,cat,waveforms);

end