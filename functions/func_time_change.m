function func_time_change(app,value)
try
    % Update slider and number value (second)
    app.number_slider.Value = value;
    app.slide_video.Value = value;
    
    % Update text for video time (mm:ss)
    app.txt_video_time.Text = datestr(seconds(round(value)),'MM:SS');
    
    % Update video frame
    % Get VLC
    vlc = getappdata(app.hand_editing,'vlc');
    
    % Update frame
    vlc.seek(value);%select time
    
    % Update spectrogram
    window_width = app.number_window_width.Value/2;%seconds
    xlim = [value-window_width,value+window_width];
    set(app.axis_spectrogram,'xlim',xlim);
    
    % Update dashed line
    h_line = getappdata(app.hand_editing,'h_line');
    h_line.XData = [value,value];
    
    setappdata(app.hand_editing,'vlc',vlc);
catch ME
    errordlg(ME.message, 'func_time_change');
end