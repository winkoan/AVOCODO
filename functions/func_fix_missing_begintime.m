function EEG = func_fix_missing_begintime(EEG)

    n_events = length(EEG.event);

    valid_idx = [];
    valid_time = [];

    % ---- Find first valid begintime ----
    for i = 1:n_events
        if isfield(EEG.event, 'begintime')
            bt = EEG.event(i).begintime(1:end-6);
        else
            error('EEG.event does not contain begintime field.');
        end

        try
            dt = datetime(bt);
            if ~isnat(dt)
                dt.Format = 'yyyy-MM-dd''T''hh:mm:ss.SSSSSS';

                valid_idx = i;
                valid_time = dt;
                break
            end
        catch
            % invalid begintime, skip
        end
    end

    if isempty(valid_idx)
        error('No valid begintime found in EEG.event.');
    end

    valid_latency = EEG.event(valid_idx).latency;

    % ---- Fill invalid begintime entries ----
    for i = 1:n_events

        bt = EEG.event(i).begintime(1:end-6);
        is_valid = false;

        try
            dt = datetime(bt);
            if ~isnat(dt)
                is_valid = true;
            end
        catch
            is_valid = false;
        end

        if ~is_valid
            latency_diff_sec = ...
                (EEG.event(i).latency - valid_latency) / EEG.srate;

            new_time = valid_time + seconds(latency_diff_sec);

            % Store as string; adjust format if needed
            str_added_event = strcat(string(new_time),EEG.event(valid_idx).begintime(end-5:end));
            EEG.event(i).begintime = char(str_added_event);
        end
    end
end