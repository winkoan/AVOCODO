function func_drop_marker(app)
try
    % Get video start latencies
    video_start_latencies = getappdata(app.hand_editing,'video_start_latencies');
    
    % Which video?
    idx_video = str2num(app.drop_number_videos.Value);
    
    video_start = video_start_latencies(idx_video)/1000;%pick a video start time and convert to seconds
    
    lat_video = app.number_slider.Value;%latency in seconds in video
    type = app.txt_marker_type.Value;%event type
    tab = app.table_markers;%table in gui
    new_entry = {type,video_start+lat_video,lat_video,idx_video};
    
    if ~isempty(type)
        % Check if the same EEG latency already has a marker
        tab_exist = get(tab,'Data');
        if ~isempty(tab_exist)
            eeg_latency_exist = cell2mat(tab_exist(:,2));
        else
            eeg_latency_exist = -1;
        end
        
        if isempty(find(eeg_latency_exist==new_entry{1,2}))
            set(tab,'Data',sortrows([tab_exist; new_entry],2));%update table
            
            % Save another copy of table for "redo"
            setappdata(app.hand_editing,'table_redo',{});
        
            func_add_marker_to_spectrogram(app);%plot markers in spectrogram
        else
            questdlg('Marker existed at this EEG latency!','Choice','OK','');
        end
    end
catch ME
    errordlg(ME.message, 'func_drop_marker');
end