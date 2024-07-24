function func_add_eeg_marker_to_spectrogram(app)

ylim = getappdata(app.hand_editing,'ylim');
EEG = getappdata(app.hand_editing,'EEG');
idx_video = str2num(app.drop_number_videos.Value );

h_stem_eeg = getappdata(app.hand_editing,'h_stem_eeg');
h_marker_txt_eeg = getappdata(app.hand_editing,'h_marker_txt_eeg');
h_marker_lat_eeg = getappdata(app.hand_editing,'h_marker_lat_eeg');

delete(h_stem_eeg);%clear handle
delete(h_marker_txt_eeg);%clear handle
delete(h_marker_lat_eeg);%clear handle

% Get EEG event type and latency
type = {};
lat = [];
for idx = 1:length(EEG.event)
    type{end+1,1} = EEG.event(idx).type;
    lat(end+1,1) = EEG.event(idx).latency/1000;%latency in seconds
end
idx_videos = find(contains(type,'VBeg'));%find indices of all videos
offset = lat(idx_videos(idx_video));%
lat = lat - offset;%offset latencies by the beginning of video

% Stem plot 
h_stem_eeg = stem(app.axis_spectrogram,lat,ones(1,length(lat))*ylim(2),...
    'Marker','none','linewidth',1.5,'color','b');
setappdata(app.hand_editing,'h_stem_eeg',h_stem_eeg);%update handle

h_marker_txt_eeg = func_add_text_to_spectrogram(app,0.8,type,lat,'b');
h_marker_lat_eeg = func_add_text_to_spectrogram(app,0.7,arrayfun(@num2str, lat, 'UniformOutput', 0),...
    lat,'b');
setappdata(app.hand_editing,'h_marker_txt_eeg',h_marker_txt_eeg);%update handle
setappdata(app.hand_editing,'h_marker_lat_eeg',h_marker_lat_eeg);%update handle
