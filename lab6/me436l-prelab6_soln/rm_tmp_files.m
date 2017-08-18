function rm_tmp_files(path)
% RM_TMP_FILES - removes any hidden or temp files
a = dir([path '/~*']);

if ~isempty(a), delete([path '/' a.name]); end

