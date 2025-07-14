function func_play(app)
try
    % Get VLC
    vlc = getappdata(app.hand_editing,'vlc');
    window_width = app.number_window_width.Value/2;%seconds
    
    vlc.play();%play video
catch ME
    if isdeployed
        %errordlg(ME.message, 'func_load_eeg');
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_play');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end
