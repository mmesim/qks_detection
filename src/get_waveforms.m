function waveforms=get_waveforms(raw_dir,directory,type,co,wlen)
%here we work with raw waveforms
%For each daily waveform in the listed directory the process is
% 01. read the sac file - 02. Remove linear trend - 03. Remove mean
% 04. Filter - 05. Return structure with raw waveforms

%% 01. List all filenames in raw directory   
data_path=sprintf('%s/%s/', raw_dir,directory);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
%--------------------------------------------------------------------------
%                Preallocate memory                                       %
waveforms=struct('WAVEFORM',{},'DELTA',{},'NZYEAR',{}, ...
                    'NZJDAY',{}, 'NZHOUR', {}, 'NZMIN', {}, ...
                    'NZSEC', {}, 'NZMSEC',{},'KZDATE',{}, ...
                    'KZTIME',{}, 'KSTNM', {}, 'KCMPNM',{},...
                    'KNETWK', {});
%--------------------------------------------------------------------------
%% 02. Preprocess [remove mean, remove trend, filter] and save as structures
% Load each waveform and do preprocessing on the fly 
j=1;
for i=1:length(listing) %change to parfor
filename=sprintf('%s/%s',data_path,listing(i).name);
[y,~,header]=rdsac(filename);    

%Here we check if the waveforms are 0ne day long
%If there are not wll not be saved and a message will be displayed
if length(y)<round(wlen/header.DELTA)
fprintf('Problem with station: %s.%s.%s. Cause: Data <1 day\n', header.KNETWK,header.KSTNM,header.KCMPNM);

else
    
%--------------------------------------------------------------------------
% Start preprocessing for waveforms
% Remove trend
yr=my_detrend(y,1);
% Remove mean
ym=yr-mean(yr);
% Filter
yf=my_filter(ym,type,header.DELTA,co);
% Save as structure
waveforms(j)=struct('WAVEFORM',yf,'DELTA',header.DELTA,'NZYEAR',header.NZYEAR, ...
                    'NZJDAY',header.NZJDAY, 'NZHOUR', header.NZHOUR, 'NZMIN', header.NZMIN, ...
                    'NZSEC', header.NZSEC, 'NZMSEC',header.NZMSEC,'KZDATE',header.KZDATE, ...
                    'KZTIME',header.KZTIME, 'KSTNM', header.KSTNM, 'KCMPNM',header.KCMPNM,...
                    'KNETWK', header.KNETWK);
                j=j+1;
end
end


end