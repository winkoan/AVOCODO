% This script goes through all EEG events and converts specific event types to EEG+ or EEG-
% Note: This is only one example.
% You should cutomize this script for your specific paradigm and processing pipeline.

% Conversion rules
EEG_minus = {'talking+','movement+'};
EEG_plus = {'talking-','movement-'};

% Change event types based on rules
for idx = 1:length(EEG.event)
    EEG.event(idx).type
    if any(contains(EEG_minus,EEG.event(idx).type))
        EEG.event(idx).type = 'EEG-';
    elseif any(contains(EEG_plus,EEG.event(idx).type))
        EEG.event(idx).type = 'EEG+';
    end
end

EEG = eeg_checkset(EEG);