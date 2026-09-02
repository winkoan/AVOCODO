function func_add_eeg_marker_to_spectrogram(app)
try
    ylim = getappdata(app.hand_editing,'ylim');
    EEG = getappdata(app.hand_editing,'EEG');
    idx_video = str2num(app.drop_number_videos.Value );
    
    h_stem_eeg = getappdata(app.hand_editing,'h_stem_eeg');
    h_marker_txt_eeg = getappdata(app.hand_editing,'h_marker_txt_eeg');
    h_marker_lat_eeg = getappdata(app.hand_editing,'h_marker_lat_eeg');
    selected_events = getappdata(app.hand_editing,'selected_events');
    
    delete(h_stem_eeg);%clear handle
    delete(h_marker_txt_eeg);%clear handle
    delete(h_marker_lat_eeg);%clear handle
    
    % Get EEG event type and latency
    type = {};
    lat = [];
    for idx = 1:length(EEG.event)
        type{end+1,1} = EEG.event(idx).type;
        lat(end+1,1) = EEG.event(idx).latency/EEG.srate; % Latency in seconds
    end
    
    video_start_latencies = [];
    for idx_v = 1:size(selected_events,1)
        video_start_latencies(idx_v) = lat(selected_events.Index(idx_v))*1000;%save latency in ms
    end
    setappdata(app.hand_editing,'video_start_latencies',video_start_latencies);%update video start latency
    
    offset = lat(selected_events.Index(idx_video));%offset for the current video
    lat = lat - offset; % Apply the offset to all latencies
    
    % Stem plot 
    color_dark_green = '#5d872a';
    h_stem_eeg = stem(app.axis_spectrogram,lat,ones(1,length(lat))*ylim(2),...
        'Marker','none','linewidth',2,'color',color_dark_green);
    setappdata(app.hand_editing,'h_stem_eeg',h_stem_eeg);%update handle
    
    h_marker_txt_eeg = func_add_text_to_spectrogram(app,0.8,type,lat,color_dark_green);
    h_marker_lat_eeg = func_add_text_to_spectrogram(app,0.65,arrayfun(@(x) num2str(x,'%.2f'), lat, 'UniformOutput', 0),...
        lat,color_dark_green);
    setappdata(app.hand_editing,'h_marker_txt_eeg',h_marker_txt_eeg);%update handle
    setappdata(app.hand_editing,'h_marker_lat_eeg',h_marker_lat_eeg);%update handle
catch ME
    errordlg(ME.message, 'func_add_eeg_marker_to_spectrogram');
end