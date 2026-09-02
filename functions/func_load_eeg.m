function func_load_eeg(app)
try
    file_path = app.txt_path_data.Value;
    file_name = app.list_eeg_files.Value;%file name

    % Load data
    EEG = pop_mffimport(fullfile(file_path,file_name) ,[], 0, 0) ;
    
    % Find number of video files
    videos_path = dir(fullfile(file_path,file_name,'*.mov'));%find all videos
    n_videos = length(videos_path);%number of video files
    
    % Check if video latency file exists
    file_marker = dir(fullfile(file_path,'0_markers',[file_name(1:end-4),'_video_latency.csv']));
    if ~isempty(file_marker)
        selected_events = readtable(fullfile(file_path,'0_markers',file_marker(1).name));
        setappdata(app.hand_editing,'selected_events',selected_events);
    else
        % Use a pop-up window to display all EEG events and latencies
        func_select_event_to_sync(app,EEG,n_videos,[]);
    end

    % Update lamp state
    app.lamp_load_eeg.Color = 'g';

    % save the data for global use
    setappdata(app.hand_editing,'EEG',EEG);
    setappdata(app.hand_editing,'n_videos',n_videos);

    fprintf(['\n\n',file_name,' loaded!']);
catch ME
    if ~isdeployed
        %errordlg(ME.message, 'func_load_eeg');
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_load_eeg');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end