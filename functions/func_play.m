function func_play(app)

% Get VLC
vlc = getappdata(app.hand_editing,'vlc');
window_width = app.number_window_width.Value/2;%seconds

vlc.play();%play video
% while strcmp(vlc.Status,'playing')
%     time = vlc.Current.Position/1000000;%in seconds;
% 
%     % Update slider and number value (second)
%     app.number_slider.Value = time;
%     app.slide_video.Value = time;
% 
%     % Update spectrogram
%     xlim = [time-window_width,time+window_width];
%     set(app.axis_spectrogram,'xlim',xlim);
% 
%     % Update dashed line
%     h_line = getappdata(app.hand_editing,'h_line');
%     h_line.XData = [time,time];
% 
%     pause(0.5)
% end
