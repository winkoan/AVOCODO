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
    lat(end+1,1) = EEG.event(idx).latency/1000; % Latency in seconds
end

% Find indices for video start points VBeg and sync and boundary
idx_video_vbeg = find(contains(type, {'VBeg'})); % First video begins with 'VBeg'
idx_video_boundary = find(contains(type, 'boundary')); % Second video starts at 'boundary'
idx_video_sync = find(contains(type, {'sync'})); % First video begins with 'sync'

if ~isempty(idx_video_vbeg)
    idx_video_all = [idx_video_vbeg(1);idx_video_boundary];%Use first 'VBeg' and all boundaries
elseif ~isempty(idx_video_sync)
        idx_video_all = idx_video_sync;
        % Correct latency if sync is used
        % Note: this is based on experimental data and that the sync event has a 1000ms duration
        % Correcting for this 1000ms seems to work better on our data
        % However, this may not apply to all data
        for idx_v = 1:length(idx_video_all)
            lat(idx_video_all(idx_v)) = lat(idx_video_all(idx_v)) + 1;%save latency in seconds
        end
else
    errordlg('No valid sync markers found!', 'Error');
end

video_start_latencies = [];
for idx_v = 1:length(idx_video_all)
    video_start_latencies(idx_v) = lat(idx_video_all(idx_v))*1000;%save latency in ms
end
setappdata(app.hand_editing,'video_start_latencies',video_start_latencies);%update video start latency

offset = lat(idx_video_all(idx_video));
lat = lat - offset; % Apply the offset to all latencies

% Stem plot 
h_stem_eeg = stem(app.axis_spectrogram,lat,ones(1,length(lat))*ylim(2),...
    'Marker','none','linewidth',1.5,'color','b');
setappdata(app.hand_editing,'h_stem_eeg',h_stem_eeg);%update handle

h_marker_txt_eeg = func_add_text_to_spectrogram(app,0.8,type,lat,'b');
h_marker_lat_eeg = func_add_text_to_spectrogram(app,0.7,arrayfun(@num2str, lat, 'UniformOutput', 0),...
    lat,'b');
setappdata(app.hand_editing,'h_marker_txt_eeg',h_marker_txt_eeg);%update handle
setappdata(app.hand_editing,'h_marker_lat_eeg',h_marker_lat_eeg);%update handle