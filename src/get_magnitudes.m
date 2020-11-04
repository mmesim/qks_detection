function [mags,newcat]=get_magnitudes(waveforms,templates,newcat,detections)

    
ids=newcat.TEMPLATE_ID;
mag=newcat.TEMPLATE_MAG;
mags=NaN*zeros(length(ids),1);


for i=1:length(ids) % For each event

%Get templates with the same ID     
templates_ID=match_templates(templates,ids(i)); 

j=1;    
for ii=1:length(templates_ID) %For each template for the event
    
nwaveform=match_waveforms(templates_ID(ii).KSTNM,templates_ID(ii).KCMPNM,waveforms);

if ~isempty(nwaveform)
%cut raw waveforms around pick time
start=round(detections(i,3)+(templates_ID(ii).TRAVEL_TIME./templates_ID(ii).DELTA));
stop=start+length(templates_ID(ii).WAVEFORM)-1;
wav_cut=nwaveform.WAVEFORM(start:stop);
%get maximum amplitude for waveform
wav_amp(j,1)=max(abs(wav_cut));
%get maximum amplitude for template
templ_amp(j,1)=max(abs(templates_ID(ii).WAVEFORM));    

j=j+1;
end % end if for empty waveform    
end %end looping through templates
%Here output magnitude for each event
ratio=wav_amp./templ_amp;
mags(i,1)=mag(i,1)+log10(median(ratio));

end %end looping through events
newcat.NEWMAG=mags; %replace new magnitudes in structure



end %end of function