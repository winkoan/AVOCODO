function h_text = func_add_text_to_spectrogram(app,y_value,txt2add,lat2add,color)
<<<<<<< Updated upstream
% y_value is a fraction (0,1)
ylim = getappdata(app.hand_editing,'ylim');
y_level = ylim(1) + (ylim(2) - ylim(1))*y_value;

% add text to spectrogram
h_text = text(app.axis_spectrogram,lat2add,y_level*ones(1,length(lat2add)),txt2add,'color',color);
=======
try
    % y_value is a fraction (0,1)
    ylim = getappdata(app.hand_editing,'ylim');
    y_level = ylim(1) + (ylim(2) - ylim(1))*y_value;
    
    % add text to spectrogram
    h_text = text(app.axis_spectrogram,lat2add,y_level*ones(1,length(lat2add)),txt2add,'color',color,'FontSize',16,'FontWeight', 'bold');
    set(h_text,'Rotation',60);
catch ME
    if isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_add_text_to_spectrogram');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end
>>>>>>> Stashed changes
