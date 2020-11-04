function detections=associate_detections(pks,locs,npairs,time_thres)
%Function to associate detections for multiple templates
%Returns unique detections for the day
%Including self-detections and already cataloged events
%These will be removed later
%--------------------------------------------------------------------------

%Create a vector with IDS
N=cellfun('length',pks);temp=cell(1,length(N));
npairs=cell2mat(npairs); ids=unique(npairs(:,3));
for i=1:length(N)
temp{1,i}=ids(i)*ones(N(i),1);
end
%One array
all=[cell2mat(pks)' cell2mat(locs)' cell2mat(temp')];
%sort according to origin time
[~,ind]=sort(all(:,2));all=all(ind,:);

%At least two detections
if length(all(:,1))>2
%interevet time
interevent=[diff(all(:,2)); all(end,2)-all(end-1,2)];

index=find(interevent(:,1)>time_thres);

%If there are more than one events
if ~isempty(index)

%loop through each family of detections
%find the best template (highest CC)
%and get mean origin time
j=0;detections=zeros(length(index),3);

for ii=1:length(index)
group=all(j+1:index(ii),:);
[~,max_ind]=max(group(:,1));
detections(ii,:)=[group(max_ind,3) group(max_ind,1) group(max_ind,2)];
j=index(ii);
    
end

%last detection
group_last=all(index(end)+1:length(all),:);

%Group the last detection
if ~isempty(group_last)

[~,max_ind]=max(group_last(:,1));
detections=[detections; group_last(max_ind,3) group_last(max_ind,1) mean(group_last(:,2))  ];

end %last detection

else %if there is one event just keep the best template
[~,max_ind]=max(all(:,1));
detections=[all(max_ind,3) all(max_ind,1) all(max_ind,2)];
    
end

else %if there is one detection then return detections array
    detections=[all(:,3) all(:,1) all(:,2)];
end % end if

end
