function func_gui_closing(app)
<<<<<<< Updated upstream

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

save(fullfile('config','default.mat'),'default');

delete(app)
=======
try
    % Kill VLC
    vlc = getappdata(app.hand_editing,'vlc');
    fui = getappdata(app.hand_editing,'fui');
    
    if ~isempty(fui) && isvalid(fui)
        delete(fui.Parent);
    end
    
    if ~isempty(vlc)
        vlc.quit();
    end
    
    % Save default values
    default.txt_path_to_data = app.txt_path_data.Value;
    default.txt_marker_type = app.txt_marker_type.Items;
    default.txt_script_remove_events = app.txt_script_remove_events.Value;
    
    if isdeployed
        save(fullfile(ctfroot,'run_AVOCODO','config','default.mat'),'default');%for compiling
    else
        save(fullfile(pwd,'config','default.mat'),'default');
    end
    
    delete(app)
catch ME
    if isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_gui_closing');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end
>>>>>>> Stashed changes
