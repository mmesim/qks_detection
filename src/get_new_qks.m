function [pks,locs,npairs]=get_new_qks(waveforms,templates,ids,thres,mindis,wlen)

npairs=do_pairing(waveforms,templates,ids);

%Preallocate 
pks=cell(1,length(npairs));
locs=cell(1,length(npairs));
N=length(npairs);
delta=waveforms(1).DELTA;


parfor i=1:N % For each event
    
temp=npairs{i,1};
%fprintf('Event %d - %d out of %d \n',temp(1,3),i, N)

CC_shifted=zeros(1,round(wlen/delta));

M=length(temp(:,1));

for ii=1:M %For each template for the event
    
y=templates(temp(ii,1)).WAVEFORM; % the filter
x=waveforms(temp(ii,2)).WAVEFORM; % the raw waveform

%Matched Filtering Time Domain -mex function
CC=my_matched_filtering(x,y);

% Shift
CC_shifted=CC_shifted+my_shift(CC,templates(temp(ii)).TRAVEL_TIME,templates(temp(ii)).BPICK,waveforms(1).DELTA);

end %end of match filter for template - waveform

% Normalize for the number of traces
if M>1
CC_sum=CC_shifted./M;
else
CC_sum=CC_shifted;
end
%Detections for each template   

[pks{1,i},locs{1,i}] = findpeaks(double(CC_sum),'MinPeakDistance',mindis./waveforms(1).DELTA,'MinPeakHeight',thres*mad(CC_sum,1));

end% end of template loop


end % end of function