function flag_continue = func_reset_workspace(app)

try
    % Currently can only load mff files
    answer = questdlg('Are you ready to load EEG? Unsaved markers (if any) will be deleted.','Choice','Yes','No','');
    if strcmp(answer,'Yes')
        flag_continue = 1;

        vlc = getappdata(app.hand_editing,'vlc');%close vlc window if exists

        if ~isempty(vlc)%if vlc exists, quit
            try
                vlc.quit();
            catch
            end
        end

        % Reset table markers data
        setappdata(app.hand_editing,'table_markers',{});

        app.num_video_event_index.Value = 0;
        app.txt_video_event.Value = '';

        app.lamp_load_video.Color = 'r';
        app.lamp_load_eeg.Color = 'r';
        cla( app.axis_spectrogram ,'reset');

        pause(0.5);
        fprintf('\n\nLoading EEG data... (this may take some time)\n')

        % Clear marker table
        app.table_markers.Data={};

        file_path = app.txt_path_data.Value;
        file_name = app.list_eeg_files.Value;%file name

        % Check if marker file exists
        file_marker = dir(fullfile(file_path,'0_markers',[file_name(1:end-4),'.csv']));
        if ~isempty(file_marker)
            tab = readtable(fullfile(file_path,'0_markers',file_marker(1).name));
            app.table_markers.Data = table2cell(tab);
        end
    else
        flag_continue = 0;
    end
catch ME
    flag_continue = 0;
    if ~isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_reset_workspace');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end