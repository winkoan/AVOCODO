function func_gui_closing(app)

% Kill VLC
vlc = getappdata(app.hand_editing,'vlc');
if ~isempty(vlc)
    vlc.quit();
end

% Save default values
default.txt_path_to_data = app.txt_path_data.Value;
default.txt_path_to_eeglab = app.txt_path_eeglab.Value;
default.txt_marker_type = app.txt_marker_type.Items;
default.txt_script_remove_events = app.txt_script_remove_events.Value;

save(fullfile(ctfroot,'run_AVOCODO','config','default.mat'),'default');%for compiling
%save(fullfile(pwd,'config','default.mat'),'default');

delete(app)