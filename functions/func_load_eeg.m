function func_load_eeg(app)
% Currently can only load mff files
answer = questdlg('Are you ready to load EEG? Unsaved markers (if any) will be deleted.','Choice','Yes','No','');
if strcmp(answer,'Yes')
    vlc = getappdata(app.hand_editing,'vlc');%close vlc window if exists
    if ~isempty(vlc)%if vlc exists, quit
        try
            vlc.quit();
        catch
        end
<<<<<<< Updated upstream
    end
    
    % Reset table markers data
    setappdata(app.hand_editing,'table_markers',{});
    
    app.lamp_load_video.Color = 'r';
    app.lamp_load_eeg.Color = 'r';
    cla( app.axis_spectrogram ,'reset');
    
    pause(0.5);
    fprintf('\n\nLoading EEG data... (this may take some time)\n')

    % Clear marker table
    app.table_markers.Data={};

    file_path = app.txt_path_data.Value;
    file_name = app.list_eeg_files.Value;%file name

    % Check if marker file exists
    file_marker = dir(fullfile(file_path,'0_markers',[file_name(1:end-4),'.csv']));
    if ~isempty(file_marker)
        tab = readtable(fullfile(file_path,'0_markers',file_marker(1).name));
        app.table_markers.Data = table2cell(tab);
=======
    
        if ~isempty(fui) && isvalid(fui)
            delete(fui.Parent);
        end
        
        % Reset table markers data
        setappdata(app.hand_editing,'table_markers',{});
        
        app.lamp_load_video.Color = 'r';
        app.lamp_load_eeg.Color = 'r';
        cla( app.axis_spectrogram ,'reset');
        
        pause(0.5);
        fprintf('\n\nLoading EEG data... (this may take some time)\n')
    
        % Clear marker table
        app.table_markers.Data={};
    
        file_path = app.txt_path_data.Value;
        file_name = app.list_eeg_files.Value;%file name
    
        % Check if marker file exists
        file_marker = dir(fullfile(file_path,'0_markers',[file_name(1:end-4),'.csv']));
        if ~isempty(file_marker)
            tab = readtable(fullfile(file_path,'0_markers',file_marker(1).name));
            app.table_markers.Data = table2cell(tab);
        end
    
        % Load data
        EEG = pop_mffimport(fullfile(file_path,file_name) ,[], 0, 0) ;
    
        % Use a pop-up window to display all EEG events and latencies
        tab_pop = table(extractfield(EEG.event,'type')',extractfield(EEG.event,'begintime')',...
            (extractfield(EEG.event,'latency')/1000)','VariableNames',{'Type','BeginTime','Latency (second)'});
    
        % Define row and column dimensions
        nRows = size(tab_pop, 1);
        nCols = size(tab_pop, 2);
    
        % Estimate pixel size per cell
        rowHeight = 22;
        colWidth = 100;
        
        % Calculate total size needed
        tableWidth = colWidth * nCols;
        tableHeight = min(rowHeight * (nRows + 1),500); % +1 for header
        
        % Create the figure window to match the table size
        f = uifigure('Name', 'EEG markers - for sanity check only', 'Position', [100 100 tableWidth+150 tableHeight+40]);
        
        % Create the table and fill the window
        fui = uitable(f, 'Data', tab_pop, 'Position', [20 20 tableWidth+100 tableHeight]);
    
        % Update lamp state
        app.lamp_load_eeg.Color = 'g';
    
        % save the data for global use
        setappdata(app.hand_editing,'EEG',EEG);
        setappdata(app.hand_editing,'fui',fui);
    
        fprintf(['\n\n',file_name,' loaded!']);
    end
catch ME
    if ~isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_load_eeg');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
>>>>>>> Stashed changes
    end

    % Load data
    EEG = pop_mffimport(fullfile(file_path,file_name) ,[], 0, 0) ;

    % Get all event types (can be much faster if using extractfields)
    types = {};
    for idx = 1:length(EEG.event)
        types{idx,1} = EEG.event(idx).type;
    end
    video_events = find(contains(types,'VBeg'));%find beginning of each video
    video_start_latencies = [];
    for idx = 1:length(video_events)
        video_start_latencies(idx,1) = EEG.event(video_events(idx)).latency;%(ms)
    end

    % Update lamp state
    app.lamp_load_eeg.Color = 'g';

    % save the data for global use
    setappdata(app.hand_editing,'EEG',EEG);
    setappdata(app.hand_editing,'video_start_latencies',video_start_latencies);

    fprintf(['\n\n',file_name,' loaded!']);
end