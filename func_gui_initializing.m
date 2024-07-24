function func_gui_initializing(app)

warning off
clc
% Add necessary folders to path
addpath(genpath('packages'),'-END');
addpath(genpath('functions'));
addpath(genpath('config'),'-END');

% Load default field values
load(fullfile(pwd,'config','default.mat'),'default');

% Set default values
if isempty(default.txt_path_to_data)
    app.txt_path_data.Value = pwd;
else
    app.txt_path_data.Value = default.txt_path_to_data;
end

if isempty(default.txt_path_to_eeglab)
    app.txt_path_eeglab.Value = pwd;
else
    app.txt_path_eeglab.Value = default.txt_path_to_eeglab;
end

if isempty(default.txt_marker_type)
    app.txt_marker_type.Items = {};
else
    app.txt_marker_type.Items = default.txt_marker_type;
end

func_update_file_list(app,0);%update file list

addpath(genpath(default.txt_path_to_eeglab),'-END');