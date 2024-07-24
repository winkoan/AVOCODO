function func_redo_marker(app)
% Get table of markers for redo
tab_back_up = getappdata(app.hand_editing,'table_markers');

tab = app.table_markers;%table in gui
tab_data_current = get(tab,'Data');

if size(tab_data_current,1)+1<=length(tab_back_up)
    tab_redo = tab_back_up(1:(size(tab_data_current,1)+1),:);
    
    set(tab,'Data',tab_redo);%update table

    func_add_marker_to_spectrogram(app);%plot markers in spectrogram
end
