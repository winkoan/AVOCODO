function func_redo_marker(app)
try
    % Get table of markers for redo
    %tab_back_up = getappdata(app.hand_editing,'table_markers');
    tab_redo = getappdata(app.hand_editing,'table_redo');
    
    tab = app.table_markers;%table in gui
    tab_data_current = get(tab,'Data');
    
    if size(tab_redo)>0
        tab_new = [tab_data_current;tab_redo(1,:)];%add redo-row to current
        tab_redo(1,:) = [];%remove redo-row from redo
        setappdata(app.hand_editing,'table_redo',tab_redo);
        
        set(tab,'Data',sortrows(tab_new,2));%update table
        
        func_add_marker_to_spectrogram(app);%plot markers in spectrogram
    end
catch ME
    errordlg(ME.message, 'func_redo_marker');
end