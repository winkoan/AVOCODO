function func_load_videos(app)
% Load video and audio from .mov files
fprintf('\n\nLoading video(s) and audio(s)... (this may also take some time)');

% Update lamp state
app.lamp_load_video.Color = 'r';

path = app.txt_path_data.Value;%use path to eeg for path to video
file = app.list_eeg_files.Value;%file name
videos_path = dir(fullfile(path,file,'*.mov'));%find all videos

videos = {};
audios = {};
idx_video = {};
for idx = 1:length(videos_path)
    % Create video players
    videos{idx,1} = VideoReader(fullfile(videos_path(idx).folder,...
        videos_path(idx).name));
    idx_video{idx,1} = num2str(idx);
    
<<<<<<< Updated upstream
    % Create audio players
    [audio.data,audio.fs] = audioread(fullfile(videos_path(idx).folder,videos_path(idx).name));
    audios{idx} = audio;
end

% Update number of videos spinner
app.drop_number_videos.Items = idx_video;
app.drop_number_videos.Value = '1';

% save the data for global use
setappdata(app.hand_editing,'videos',videos);
setappdata(app.hand_editing,'videos_path',videos_path);
setappdata(app.hand_editing,'audios',audios);

% Update slider and show the current frame
func_choose_video(app,'1');

% Update lamp state
app.lamp_load_video.Color = 'g';

fprintf(['\n\n',file,': video(s) and audio(s) loaded!']);

% Make two beep sounds for completion
beep;pause(0.2);
beep
=======
    % Update lamp state
    app.lamp_load_video.Color = 'r';
    
    path = app.txt_path_data.Value;%use path to eeg for path to video
    file = app.list_eeg_files.Value;%file name
    videos_path = dir(fullfile(path,file,'*.mov'));%find all videos
    
    % Give an error if no video if found
    if isempty(videos_path)
        errordlg('No video is found in the mff file!', 'Error');
        return;
    end
    
    videos = {};
    audios = {};
    idx_video = {};
    for idx = 1:length(videos_path)
        % Create video players
        videos{idx,1} = VideoReader(fullfile(videos_path(idx).folder,...
            videos_path(idx).name));
        idx_video{idx,1} = num2str(idx);
        
        % Create audio players
        [audio.data,audio.fs] = audioread(fullfile(videos_path(idx).folder,videos_path(idx).name));
        audios{idx} = audio;
    end
    
    % Update number of videos spinner
    app.drop_number_videos.Items = idx_video;
    app.drop_number_videos.Value = '1';
    
    % save the data for global use
    setappdata(app.hand_editing,'videos',videos);
    setappdata(app.hand_editing,'videos_path',videos_path);
    setappdata(app.hand_editing,'audios',audios);
    
    % Update slider and show the current frame
    func_choose_video(app,'1');
    
    % Update lamp state
    app.lamp_load_video.Color = 'g';
    
    fprintf(['\n\n',file,': video(s) and audio(s) loaded!']);
    
    % Make two beep sounds for completion
    beep;pause(0.2);
    beep
catch ME
    if isdeployed
        errordlg(getReport(ME, 'extended', 'hyperlinks', 'on'), 'func_load_videos');
    else
        fprintf('%s\n', getReport(ME, 'extended', 'hyperlinks', 'on'));
    end
end
>>>>>>> Stashed changes
