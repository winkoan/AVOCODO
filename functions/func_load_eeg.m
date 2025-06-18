function func_load_eeg(app)
% Currently can only load mff files
answer = questdlg('Are you ready to load EEG? Unsaved markers (if any) will be deleted.','Choice','Yes','No','');
if strcmp(answer,'Yes')
    vlc = getappdata(app.hand_editing,'vlc');%close vlc window if exists
    if ~isempty(vlc)%if vlc exists, quit
        try
            vlc.quit();
        catch
        end
    end
    
    % Reset table markers data
    setappdata(app.hand_editing,'table_markers',{});
    
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

    % Load data
    EEG = pop_mffimport(fullfile(file_path,file_name) ,[], 0, 0) ;

    % Update lamp state
    app.lamp_load_eeg.Color = 'g';

    % save the data for global use
    setappdata(app.hand_editing,'EEG',EEG);

    fprintf(['\n\n',file_name,' loaded!']);
end