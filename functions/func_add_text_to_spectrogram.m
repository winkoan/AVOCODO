function h_text = func_add_text_to_spectrogram(app,y_value,txt2add,lat2add,color)
% y_value is a fraction (0,1)
ylim = getappdata(app.hand_editing,'ylim');
y_level = ylim(1) + (ylim(2) - ylim(1))*y_value;

% add text to spectrogram
h_text = text(app.axis_spectrogram,lat2add,y_level*ones(1,length(lat2add)),txt2add,'color',color);
