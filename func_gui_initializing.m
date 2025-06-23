function func_gui_initializing(app)

warning off
clc

% Load default field values
if isdeployed
    load(fullfile(ctfroot,'run_AVOCODO','config','default.mat'),'default');%for compiling
else
    % Add necessary folders to path
    addpath(genpath('packages'),'-END');
    addpath(genpath('functions'));
    addpath(genpath('config'),'-END');

    load(fullfile(pwd,'config','default.mat'),'default');
end

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

if isempty(default.txt_script_remove_events)
    app.txt_script_remove_events.Value = '';
else
    app.txt_script_remove_events.Value = default.txt_script_remove_events;
end

func_update_file_list(app,0);%update file list

if ~isdeployed
    addpath(genpath(default.txt_path_to_eeglab),'-END');
end