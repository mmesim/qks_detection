function [templates,ids]=get_templates(templates_dir,type,co,P_Bpick_win,P_Apick_win,S_Bpick_win,S_Apick_win)
%here we work with the templates
%Original waveforms are sac files with 90 s length
%The header should have P picks as A on vertical
%and S picks as T0 on both horizontals
%The output is the template cut around the P and S arrival time
%--------------------------------------------------------------------------
%Process for each template:
% 01. read template - 02. remove linear trend - 03. Remove mean 
% 04. filter - 05. cut around P or S - 06. return structure with templates


%% 01. List all filenames in templates directory
data_path=sprintf('%s/', templates_dir);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
%--------------------------------------------------------------------------
%                Preallocate memory                                       %
ids=zeros(length(listing),1);
templates=struct('ID',{},'WAVEFORM',{},'DELTA',{},'TRAVEL_TIME',{}, 'BPICK',{}, ...
                   'EVLA',{},'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'STLA',{}, 'STLO',{}, 'STEL', {}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {});
%--------------------------------------------------------------------------
%% 02. Preprocess [remove mean, remove trend, filter, cut] and save as structures
% Load each tempalte and do preprocessing on the fly - Save what's left. 
for i=1:length(listing) %change to parfor
filename=sprintf('%s/%s',data_path,listing(i).name);
[y,~,header]=rdsac(filename);    
splitfilename=strsplit(listing(i).name,'.');   
ids(i,1)=str2double(splitfilename{1,1}); 
%--------------------------------------------------------------------------
% Start preprocessing for waveforms
% Remove trend
yr=my_detrend(y,1);
% Remove mean
ym=yr-mean(yr);
% Filter
yf=my_filter(ym,type,header.DELTA,co);
% Cut around P or S arrival time
%Check channel -- for Z we use header.A reading
if header.KCMPNM(3)=='Z'
travel_time=header.A;  %save travel time for later use 
bpick=P_Bpick_win; %save for later use
ycut=my_cut_waveforms(yf,P_Bpick_win,P_Apick_win, header);
%Check channel -- for E or N we use header.T0 reading
elseif  header.KCMPNM(3)=='E' || header.KCMPNM(3)=='N'
travel_time=header.T0;  %save travel time for later use 
bpick=S_Bpick_win; %save for later use
ycut=my_cut_waveforms(yf,S_Bpick_win,S_Apick_win, header); 
end %end if: channel handling

% Save as structure
templates(i)=struct('ID',ids(i,1),'WAVEFORM',ycut,'DELTA',header.DELTA,'TRAVEL_TIME',travel_time,'BPICK',bpick, ...
                   'EVLA',header.EVLA,'EVLO',header.EVLO, 'EVDP', header.EVDP, ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'STLA',header.STLA, 'STLO',header.STLO, 'STEL', header.STEL, ...
                    'KSTNM', header.KSTNM, 'KCMPNM',header.KCMPNM, 'KNETWK', header.KNETWK);
end % endfor: reading sac files

 end  %end function