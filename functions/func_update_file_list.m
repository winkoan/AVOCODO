function func_update_file_list(app,state)
try
    if state ~= 0%if this is initializing
        path = uigetdir(app.txt_path_data.Value);
        app.txt_path_data.Value = path;%update file path
    end
    
    path = app.txt_path_data.Value;
    files = dir(fullfile(path,'*.mff'));
    
    items = {};%fill item cell
    for idx = 1:length(files)
        items{idx,1} = files(idx).name;
    end
    
    app.list_eeg_files.Items = items;%update GUI list
    
    % Set lamp color
    app.lamp_load_eeg.Color = 'r';
    app.lamp_load_video.Color = 'r';
<<<<<<< Updated upstream
catch
    
=======
catch ME
    if isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_update_file_list');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
>>>>>>> Stashed changes
end

