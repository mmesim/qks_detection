function []=get_phases(newcat,templates,id,dir,waveforms)
filename=sprintf('%s.hypoDD.pha',dir);
fout=fopen(filename,'w');

ids=newcat.TEMPLATE_ID;

for i=1:length(ids) % For each event
%print header
%(# YEAR MONTH DAY HOUR MIN SEC LAT LON DEPTH MAG ERH ERZ RMS ID)
fprintf(fout,'# %04d %2d %2d %2d %2d %5.2f %9.4f %9.4f %6.2f  %4.1f  0.00 0.00  0.00 %d  \n',...
    [newcat.YEAR(i) newcat.MONTH(i) newcat.DAY(i) newcat.HOUR(i) newcat.MIN(i) newcat.SEC(i),...
    newcat.LATITUDE(i),newcat.LONGITUDE(i),newcat.DEPTH(i),round(newcat.NEWMAG(i),1), id(i) ]');
%Get templates with the same ID     
templates_ID=match_templates(templates,ids(i)); 
   
for ii=1:length(templates_ID) %For each template for the event
    %do a match for waveform to avoid writing phases
    %for station that were off at that time

nwaveform=match_waveforms(templates_ID(ii).KSTNM,templates_ID(ii).KCMPNM,waveforms);
    if ~isempty(nwaveform)

 if templates_ID(ii).KCMPNM(3)=='Z'
     station=templates_ID(ii).KSTNM;
     travel_time=templates_ID(ii).TRAVEL_TIME;
     weight=1.0;
     phase='P';
 elseif templates_ID(ii).KCMPNM(3)=='E' || templates_ID(ii).KCMPNM(3)=='N'
     station=templates_ID(ii).KSTNM;
     travel_time=templates_ID(ii).TRAVEL_TIME;
     weight=0.5;
     phase='S';
 end %end of if for compnent
 fprintf(fout,'%-4s %10.3f  %6.3f   %s \n', station,travel_time,weight,phase);
    end %end if for waveform
 end % end for template loop


end %end for event loop

fclose(fout);
end %end of function