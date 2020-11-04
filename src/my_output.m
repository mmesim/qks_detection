function my_output(newcat,templates,dir,waveforms)
%Function to create two things
%(1) catalog (.txt)
%(2) phase file similar to ph2dt input


if ~isempty(newcat)

%01. Catalog
%Convert new IDS from string to number 
id=zeros(length(newcat.YEAR),1);
for i=1:length(newcat.YEAR)
id(i,1)=str2double(newcat.NEW_ID{i,1});
end
%print the catalog
filename=sprintf('%s.detections.txt',dir);
fout=fopen(filename,'w');
fprintf(fout,'%s \n','YEAR MONTH DAY HOUR MIN SEC LAT LON DEPTH TEMPLATE_MAG NEWMAG TEMPLATE_ID NEW_ID CC' );

fprintf(fout,'%04d %02d %02d %02d %02d %05.2f %9.4f %9.4f %6.2f %4.1f %4.1f %d %d %5.3f \n',...
    [newcat.YEAR newcat.MONTH newcat.DAY,newcat.HOUR newcat.MIN newcat.SEC,...
    newcat.LATITUDE,newcat.LONGITUDE,newcat.DEPTH,newcat.TEMPLATE_MAG,...
    round(newcat.NEWMAG,1), newcat.TEMPLATE_ID, id, newcat.CC]');
  
fclose(fout);
    
%02. Phase file
get_phases(newcat,templates,id,dir,waveforms);

%The end!!!! - yay!
end %end of if for empty catalog



end  %end of function