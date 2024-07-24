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

save(fullfile('config','default.mat'),'default');

delete(app)