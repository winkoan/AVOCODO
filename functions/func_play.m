function func_play(app)
try
    % Get VLC
    vlc = getappdata(app.hand_editing,'vlc');
    window_width = app.number_window_width.Value/2;%seconds
    
    vlc.play();%play video
catch ME
    errordlg(ME.message, 'func_play');
end
