function func_add_marker_to_spectrogram(app)

tab = app.table_markers;%table in gui
ylim = getappdata(app.hand_editing,'ylim');
h_stem = getappdata(app.hand_editing,'h_stem');
h_marker_txt = getappdata(app.hand_editing,'h_marker_txt');
h_marker_lat = getappdata(app.hand_editing,'h_marker_lat');
idx_video = str2num(app.drop_number_videos.Value );

delete(h_stem);%clear handle
delete(h_marker_txt);%clear handle
delete(h_marker_lat);%clear handle

if ~isempty(tab.Data)

    % Get all markers latency of this video
    idx_this_video = find(cell2mat(tab.Data(:,4))==idx_video);

    if ~isempty(idx_this_video)
        lat_in_video = cell2mat(tab.Data(idx_this_video,3));
        
        % Stem plot 
        h_stem = stem(app.axis_spectrogram,lat_in_video,ones(1,length(lat_in_video))*ylim(2),...
            'Marker','none','linewidth',1.5,'color','r');
        setappdata(app.hand_editing,'h_stem',h_stem);%update handle
        
        h_marker_txt = func_add_text_to_spectrogram(app,0.6,tab.Data(:,1),lat_in_video,'r');
        h_marker_lat = func_add_text_to_spectrogram(app,0.5,arrayfun(@num2str, lat_in_video, 'UniformOutput', 0),...
            lat_in_video,'r');
        setappdata(app.hand_editing,'h_marker_txt',h_marker_txt);%update handle
        setappdata(app.hand_editing,'h_marker_lat',h_marker_lat);%update handle
    end
end
