function npairs=do_pairing(waveforms,templates,ids)

%Preallocate memory
ind=zeros(length(waveforms),2);


j=1;
for i=1:length(ids)
station=templates(i).KSTNM;
channel=templates(i).KCMPNM;
    for ii=1:length(waveforms)
    ind(ii,:)=strcmp({waveforms(ii).KSTNM,waveforms(ii).KCMPNM}, {station, channel}); 
    end
   
%Find index for the waveform
index=find(ind(:,1)==1 & ind(:,2)==1);

if ~isempty(index)
%index for templates and waveforms
pairs(j,:)=[i index ids(i)];
j=j+1;
end
end

%-------------------------------------------------------
[~,ia]=unique(pairs(:,3),'rows');
ia(end+1)=length(pairs(:,1))+1;

npairs=cell(length(ia)-1,1);

for k=1:length(ia)-1
npairs{k,1}=pairs(ia(k):ia(k+1)-1,:);    
end






end