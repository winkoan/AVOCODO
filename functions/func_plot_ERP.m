function func_plot_ERP(app,txt_events,txt_win_erp)
try
    % Plot EEG at the current time instance
    EEG = getappdata(app.hand_editing,'EEG');
    
    % Remove outring electrodes
    dist = extractfield(EEG.chanlocs,'radius');
    % Find channels with distance greater than threshold (e.g., 0.5 normalized units)
    outer_thresh = 0.5;
    outer_idx = find(dist > outer_thresh);
    EEG = pop_select(EEG, 'nochannel', outer_idx);
    
    % Basic preprocessing
    EEG = pop_eegfilt(EEG, 0.3, 100,[],0,1);%filtering
    EEG = pop_resample(EEG, 250);%downsampling
    
    % Epoching
    erp_window = eval(txt_win_erp);
    erp_events = eval(txt_events);
    
    EEG_epoch = pop_epoch(EEG,erp_events,erp_window);
    EEG_epoch = pop_rmbase(EEG_epoch,[EEG_epoch.times(1),0]);
    
    [~,idx_bad,~,~] = pop_rejchan(EEG_epoch, 'threshold', 3, 'norm', 'on', 'measure', 'kurt');%remove bad channels
    EEG_epoch = pop_interp(EEG_epoch,idx_bad);
    EEG_epoch = pop_reref(EEG_epoch,[]);
    EEG_epoch = pop_rmbase(EEG_epoch,[EEG_epoch.times(1),0]);
    
    % Plotting
    figure;pop_timtopo(EEG_epoch,[erp_window(1)+0.005,erp_window(2)-0.005]*1000,[100,150,200]); 
catch ME
    if isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_plot_ERP');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end