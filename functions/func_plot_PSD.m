function func_plot_PSD(app)
try
    % Plot EEG at the current time instance
    EEG = getappdata(app.hand_editing,'EEG');
    
    EEG = pop_resample(EEG, 250);
    
    figure;pop_spectopo(EEG,1,[EEG.times(1),EEG.times(end)],'EEG','freq',[4,10,25],'freqrange',[1,60]); 
catch ME
    if isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_plot_PSD');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end