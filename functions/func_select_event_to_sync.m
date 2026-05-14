function func_select_event_to_sync(app, EEG, n_required, selected_events_prev)

    if nargin < 4
        selected_events_prev = [];
    end

    % Create table
    n_events = length(EEG.event);

    tab_pop = table( ...
        (1:n_events)', ...
        extractfield(EEG.event,'type')', ...
        extractfield(EEG.event,'begintime')', ...
        (extractfield(EEG.event,'latency') / EEG.srate)', ...
        'VariableNames', {'Index','Type','BeginTime','Latency_sec'} ...
    );

    % Determine previously selected rows
    selected_rows_init = [];

    if ~isempty(selected_events_prev) && istable(selected_events_prev)
        if ismember('Index', selected_events_prev.Properties.VariableNames)
            selected_rows_init = selected_events_prev.Index;
            selected_rows_init = selected_rows_init(selected_rows_init >= 1 & selected_rows_init <= n_events);
            selected_rows_init = unique(selected_rows_init(:))';
        end
    end

    % Create popup
    fig = uifigure( ...
        'Name', 'Select EEG Events', ...
        'Position', [100 100 760 500] ...
    );

    fig.UserData.tab_pop = tab_pop;
    fig.UserData.selected_rows = selected_rows_init;
    fig.UserData.n_required = n_required;

    % Instruction text
    uilabel(fig, ...
        'Text', sprintf('You have to select this number of events: %d', n_required), ...
        'Position', [20 455 720 30], ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16, ...
        'FontWeight', 'bold');

    % Dynamic selected count
    count_label = uilabel(fig, ...
        'Text', sprintf('Currently selected: %d / %d', length(selected_rows_init), n_required), ...
        'Position', [20 425 720 25], ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 13);

    fig.UserData.count_label = count_label;

    % Create uitable
    uit = uitable(fig, ...
        'Data', tab_pop, ...
        'Position', [20 70 720 340], ...
        'CellSelectionCallback', @(src,event) toggle_row_selection(src,event,fig));

    % Apply initial highlighting
    style_selected_rows(uit, selected_rows_init);

    % Confirm button
    uibutton(fig, ...
        'Text', 'Use Selected Events', ...
        'Position', [290 20 180 30], ...
        'ButtonPushedFcn', @(btn,event) confirm_selection(fig));

    % Pause execution here until correct selection is confirmed
    uiwait(fig);

    % Return selected rows and close window
    if isvalid(fig)
        selected_rows = fig.UserData.selected_rows;
        tab_pop = fig.UserData.tab_pop;

        selected_events = tab_pop(selected_rows, :);

        disp(selected_events)

        % Save the data for global use
        setappdata(app.hand_editing, 'selected_events', selected_events);

        close(fig);
    else
        selected_events = table();
    end
end

function toggle_row_selection(src, event, fig)

    if isempty(event.Indices)
        return
    end

    row_idx = event.Indices(1,1);

    selected_rows = fig.UserData.selected_rows;

    if ismember(row_idx, selected_rows)
        selected_rows(selected_rows == row_idx) = [];
    else
        selected_rows(end+1) = row_idx;
    end

    selected_rows = sort(selected_rows);
    fig.UserData.selected_rows = selected_rows;

    style_selected_rows(src, selected_rows);

    n_required = fig.UserData.n_required;
    fig.UserData.count_label.Text = sprintf( ...
        'Currently selected: %d / %d', ...
        length(selected_rows), n_required ...
    );
end

function style_selected_rows(uit, selected_rows)

    removeStyle(uit);

    if ~isempty(selected_rows)
        s = uistyle('BackgroundColor', [0.8 0.9 1]);
        addStyle(uit, s, 'row', selected_rows);
    end
end

function confirm_selection(fig)

    selected_rows = fig.UserData.selected_rows;
    n_required = fig.UserData.n_required;

    if length(selected_rows) ~= n_required
        uialert( ...
            fig, ...
            'Number of sync events has to match with number of videos', ...
            'Selection Error' ...
        );
        return
    end

    uiresume(fig);
end