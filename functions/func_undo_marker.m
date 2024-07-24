function func_undo_marker(app)
tab = app.table_markers;%table in gui
tab_data = get(tab,'Data');

if ~isempty(tab_data)
    tab_data(end,:) = [];%remove last entry
    
    set(tab,'Data',tab_data);%update table

    func_add_marker_to_spectrogram(app);%plot markers in spectrogram
end

