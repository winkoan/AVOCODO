function func_update_table_after_resync(app)

tab = app.table_markers;%get current table in gui

% Get video start latencies
video_start_latencies = getappdata(app.hand_editing,'video_start_latencies');

for idx_row = 1:size(tab.Data,1)
    idx_video = tab.Data{idx_row,4};
    lat_video = tab.Data{idx_row,3};%in seconds
    offset_this = video_start_latencies(idx_video)/1000;%in seconds

    % Update table
    tab.Data{idx_row,2} = lat_video + offset_this;
end
