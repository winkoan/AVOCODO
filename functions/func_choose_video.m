function func_choose_video(app,value)
% Choose video player to set slider
videos = getappdata(app.hand_editing,'videos');
audios = getappdata(app.hand_editing,'audios');

vlc = getappdata(app.hand_editing,'vlc');
if ~isempty(vlc)%if vlc exists, quit
    try
        vlc.quit();
    catch
    end
end

app.lamp_load_video.Color = 'r';
pause(0.5);

value = str2num(value);

a = audios{value};

% Plot spectrogram
cla( app.axis_spectrogram ,'reset');
[s,f,t] = spectrogram(a.data,256,128,2048,a.fs);% calculate spectrogram
imagesc(app.axis_spectrogram,t,f,log10(abs(s)));
colormap(app.axis_spectrogram,gray);%set colormap
clim = get(app.axis_spectrogram,'clim');
clim_new = [clim(1)+(clim(2)-clim(1))*0.5,clim(1)+(clim(2)-clim(1))*1];
set(app.axis_spectrogram,'xlim',xlim,'ydir','normal','ylim',[0,f(end)],'clim',clim_new);
close all%close figure if created (maybe need to figure out why it was created...)

% Add a dashed line
hold(app.axis_spectrogram,'on');
ylim = get(app.axis_spectrogram,'ylim');
h_line = plot(app.axis_spectrogram,[0,0],ylim,'k--','linewidth',1);
setappdata(app.hand_editing,'h_line',h_line);

% Choose video path
videos_path = getappdata(app.hand_editing,'videos_path');
videos_path = fullfile(videos_path(value).folder, videos_path(value).name);

% Update slider
app.slide_video.Limits = [0, videos{value}.Duration];%set to the duration of selected video
app.slide_video.MajorTicks = linspace(0, videos{value}.Duration, 5);

% Create VLC object
% MAKE SURE YOU HAVE VLC INSTALLED!
vlc = VLC();
vlc.add(videos_path);
vlc.seek(0);
vlc.Rate = app.spin_speed.Value;%set playback speed

setappdata(app.hand_editing,'vlc',vlc);
setappdata(app.hand_editing,'ylim',ylim);

% Show current frame
func_time_change(app,0);%start at 0 seconds

% add eeg markers to spectrogram
func_add_eeg_marker_to_spectrogram(app);
func_add_marker_to_spectrogram(app);

app.lamp_load_video.Color = 'g';

% Make two beep sounds for completion
beep;pause(0.2);
beep
