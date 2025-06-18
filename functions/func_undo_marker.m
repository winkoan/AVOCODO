function func_undo_marker(app,row)
tab = app.table_markers;%table in gui
tab_data = get(tab,'Data');
tab_redo = getappdata(app.hand_editing,'table_redo');%table saved for redo

if ~isempty(tab_data)
    if row==0
        row = size(tab_data,1);%if not specified,remove the last row
    end
    tab_redo = [tab_data(row,:);tab_redo];%add to-be-deleted row to the redo table
    setappdata(app.hand_editing,'table_redo',tab_redo);

    tab_data(row,:) = [];%remove last entry
    
    set(tab,'Data',tab_data);%update table

    func_add_marker_to_spectrogram(app);%plot markers in spectrogram
end

