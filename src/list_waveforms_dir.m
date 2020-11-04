function [N,directories]=list_waveforms_dir(raw_dir)
%use this tiny function to list the raw wavefroms directory
%the output is the number of directories which is used for the parfor loop
%and the name of each directory
%--------------------------------------------------------------------------

%List all filenames in templates directory
data_path=sprintf('%s/', raw_dir);
directories=dir(data_path);
directories(ismember( {directories.name}, {'.', '..'})) = [];  %remove . and ..


N=length(directories);

end