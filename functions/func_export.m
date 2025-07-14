function func_export(app,flag_additional_script)
% Export EEG
try
    % Prompt to confirm
    answer = questdlg('Are you ready to export?','Choice','Yes','No','');
    
    if strcmp(answer,'Yes')
        % Get EEG to export
        EEG = getappdata(app.hand_editing,'EEG');
    
        % Get table of markers
        tab = get(app.table_markers,'Data');
        
        % Get all event types (can be much faster if using extractfields)
        % But the current code doesn't rely on any specific toolbox
        types = {};
        for idx = 1:length(EEG.event)
            types{idx,1} = EEG.event(idx).type;
        end
        
        video_events = find(contains(types,'VBeg'));%find beginning of each video
        if isempty(video_events)
            video_events = find(contains(types,'sync'));%find beginning of each video
        end
        
        if ~isempty(tab)%add events if table is not empty
            for idx = 1:size(tab,1)%append EEG events
                EEG.event(end+1).type = tab{idx,1};
                EEG.event(end).latency = tab{idx,2}*1000;%in ms (eeg latency)
    
                % Add time stamp, so can be saved in .mff format without any issue
                idx_video = tab{idx,4};
                ts_video_begin = datetime(EEG.event(video_events(idx_video)).begintime(1:end-6));
                ts_video_begin.Format = 'yyyy-MM-dd''T''hh:mm:ss.SSSSSS';
                video_latency = tab{idx,3}*1000;%video latency in ms
                ts_added_event = ts_video_begin+milliseconds(video_latency);
                str_added_event = strcat(string(ts_added_event),EEG.event(video_events(idx_video)).begintime(end-5:end));
                EEG.event(end).begintime = str_added_event;%the exact format as used in .mff files
    
                % Add others (again for .mff export)
                EEG.event(end).name = 'video_coding';
                EEG.event(end).tracktype = 'VDCD';%4 char for video coding (can be anything)
                EEG.event(end).classid = 'EVNT';%(can be anything)
                EEG.event(end).code = tab{idx,1};%
                EEG.event(end).duration = 1;%
                EEG.event(end).relativebegintime = 0;%
                EEG.event(end).mffkeys = '[cel#: 0, obs#: 0, pos#: 0, argu: 0]';
            end
            EEG = pop_editeventvals(EEG,'sort',{'latency',0});%sort events by their latency
        end
        
        if flag_additional_script
            try
                %some additional scripts to filter tags
            run(app.txt_script_remove_events.Value);%run this script if choose to run additional script
            catch ME
                % Show error in a pop-up window
                errordlg(ME.message, 'Runtime Error');
            end
        end
    
        % Save markers
        out_path = fullfile(app.txt_path_data.Value,'0_markers');%all markers
        if ~exist(out_path);mkdir(out_path);end
        out_file = [app.list_eeg_files.Value(1:end-4),'.csv'];
        if ~isempty(tab)%add events if table is not empty
            writetable(cell2table(tab,'VariableNames',{'type','latency_in_EEG','latency_in_video','# video'}),...
                fullfile(out_path,out_file));
        else
            writetable(cell2table({'Everything looks good!',EEG.times(end)/1000,app.slide_video.Limits(2),str2num(app.drop_number_videos.Value)},...
                'VariableNames',{'type','latency_in_EEG','latency_in_video','# video'}),...
                fullfile(out_path,out_file));
        end
    
        % Save EEG
        fprintf('\n\nSaving EEG... (this may take some time)\n')
        out_path = fullfile(app.txt_path_data.Value,'1_marked_EEG');%markers are dropped in EEG
        if ~exist(out_path);mkdir(out_path);end
        out_file = [app.list_eeg_files.Value(1:end-4),'_marked.mff'];%add marked to file name
        pop_mffexport( EEG, fullfile(out_path,out_file)); % export file to .mff format
        %pop_saveset(EEG,'filename',out_file,'filepath',out_path,'savemode','onefile','version','7.3');%optionally, save to .set file
        fprintf('\n\nEEG saved!\n')
        
        % Make two beep sounds for completion
        beep;pause(0.2);
        beep
    
        % Plot time course with markers
        pop_eegplot(EEG, 1, 1, 1);
    end
catch ME
    if isdeployed
        %errordlg(ME.message, 'func_load_eeg');
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_export');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end