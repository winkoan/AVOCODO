function func_plot_EEG(app,filtering)
% Plot EEG at the current time instance
% Get video start latencies
video_start_latencies = getappdata(app.hand_editing,'video_start_latencies');

EEG = getappdata(app.hand_editing,'EEG');

if filtering
    EEG = pop_eegfilt(EEG, 0.3, 100,[],0,1);
end

% Which video?
idx_video = str2num(app.drop_number_videos.Value);

video_start = video_start_latencies(idx_video)/1000;%pick a video start time (sec)

current_video_time = app.number_slider.Value;%latency in sec in video

current_EEG_time = current_video_time + video_start;%EEG time to plot (sec)

window_width = app.number_window_width.Value;%sec

% Plot time course with markers
pop_eegplot(EEG, 1, 1, 1, [],'winlength',window_width,'dispchans',30);
txt_time = findobj('tag','EPosition','parent',gcf);
txt_time.String = num2str(current_EEG_time-1-window_width/2);%in sec
button_forward = findobj('tag','Pushbutton3','parent',gcf);
eval(button_forward.Callback);