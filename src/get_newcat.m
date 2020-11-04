function [ndetections,newcat]=get_newcat(detections,cat,waveforms)
%Function for keeping only the new detections
%Return a structure that can be a catalog 

%Set threshold around detections
thres=0.5./(365*24*60*60);

%Convert catalog to decimal years
catdec=decyear(cat(:,1:6));
cat=[cat catdec];


%Get date and time from the waveform
year=waveforms(1).NZYEAR;
day=waveforms(1).NZJDAY;
%convert julianday to month day
date=datevec(datenum(year,0, day));
%Get time vector for each detection
timestring=sprintf('%s-%s-%s %s ',num2str(date(3)),num2str(date(2)),num2str(date(1)),waveforms(1).KZTIME);
%Convert to time
time=datetime(timestring,'Format','dd-MM-yyyy HH:mm:ss.SSS'); %header time
time_vec=datevec(time+seconds(detections(:,3).*waveforms(1).DELTA)); %time in decimal years for each detection
det_time=decyear(time_vec);

% Now compare detections and catalog origin times
% allow +-~0.5 seconds around each detection
ind=cell(length(det_time),1);
for i=1:length(det_time)
ind{i,1}=find(cat(:,12)>=det_time(i)-thres & cat(:,12)<=det_time(i)+thres);  
end

%here we keep the empty cells which correspond to non-cataloged events
%i.e new detections (yay!)
index=find(cellfun('isempty',ind));
%Grab some info from the original catalog
%Preallocate
latitude=ones(length(index),1);longitude=ones(length(index),1);
depth=ones(length(index),1);mag=ones(length(index),1);
template_id=cell(length(index),1);
%start
for ii=1:length(index)
latitude(ii,1)=cat(cat(:,11)==detections(index(ii),1),7);
longitude(ii,1)=cat(cat(:,11)==detections(index(ii),1),8);
depth(ii,1)=cat(cat(:,11)==detections(index(ii),1),9);
mag(ii,1)=cat(cat(:,11)==detections(index(ii),1),10);
template_id{ii,1}=sprintf('%4d%02d%02d%06d',time_vec(ii,1:3),ii);
end
%get newcat as structure
%              Format   
%year month day hour min sec.msec lat lon depth templateMag OLD ID NEW_ID CC
newcat.YEAR=time_vec(index,1);             newcat.MONTH=time_vec(index,2);
newcat.DAY=time_vec(index,3);              newcat.HOUR=time_vec(index,4);
newcat.MIN=time_vec(index,5);              newcat.SEC=time_vec(index,6);
newcat.LATITUDE=latitude;                  newcat.LONGITUDE=longitude;
newcat.DEPTH=depth;                        newcat.TEMPLATE_MAG=mag;
newcat.NEWMAG=NaN*zeros(length(index),1);  newcat.TEMPLATE_ID=detections(index,1);
newcat.NEW_ID=template_id;                 newcat.CC=detections(index,2);

%Return unique detections
ndetections=detections(index,:);
end