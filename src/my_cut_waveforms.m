function ycut=my_cut_waveforms(y,pick_Bwin,pick_Awin, header)
%Cut waveforms around arrival time
%Arrival time is already in header
%Be careful with header - P picks on vertical saved in A
% S picks on both horizontals saved in T0
%------------------------------------------------------------------

%check component    
if header(1).KCMPNM(3)=='Z'
start=round((header.A-pick_Bwin)./header(1).DELTA); %start before pick
stop=round((header.A+pick_Awin)./header(1).DELTA); %window after pick
elseif header(1).KCMPNM(3)=='E' || header(1).KCMPNM(3)=='N'   
start=round((header.T0-pick_Bwin)./header(1).DELTA); %start before pick
stop=round((header.T0+pick_Awin)./header(1).DELTA); %window after pick
end
%padding zeros
if stop<length(y)
    temp1=y(start:stop);
    temp1=temp1-mean(temp1);
    ycut=temp1;
else
    temp2=[y(start:end); zeros(stop-length(y),1)];
    temp2=temp2-mean(temp2);
    ycut=temp2;
end



end