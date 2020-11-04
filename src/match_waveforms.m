function nwaveform=match_waveforms(station,channel,waveforms)
%This fuction matches each template with the appropriate waveform
%Matching in Station and channel
%----------------------------------------------------------------------------------

%Preallocate memory
ind=zeros(length(waveforms),2);

%match station and channel
for i=1:length(waveforms)
ind(i,:)=strcmp({waveforms(i).KSTNM,waveforms(i).KCMPNM}, {station, channel});

end

%Find index for the waveform
index=find(ind(:,1)==1 & ind(:,2)==1);

%If exists return the waveform else return empty structury
%this helps the script not to barf
if ~isempty(index)
nwaveform=waveforms(index);
else
nwaveform=struct([]);    
end


end
