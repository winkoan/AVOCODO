![alt text](config/logo.png?raw=true)

# Audio/VideO CODing Optimization

### AVOCODO
 A MATLAB-based GUI that optimizes the experience in audio/video coding EEG data.

(Below is a temporary README)

Created by Winko W. An (anwenkang@gmail.com) on 6/25/2024

The purpose of this project is to create a MATLAB-based GUI that can

1) Load and visualize both EEG (mff format recorded by NetStation) and video
2) The video can be played (with audio) synchronized with EEG
3) A user can drop markers (with designated types) at a time of choice

System requirements (tested on):

1) Mac OS Ventura (13.6.7)
2) MATLAB (R2021b)
3) VLC media player (3.0.16 Vetinari Intel 64bit)
4) EEGLAB (2021.1)

Notes:
1) EEG has to be in .mff format (EGI)
2) Video has to be in .mov format and is in the .mff file
3) AVOCODO will automatically create subfolders "0_markers" and "1_marked_EEG" inside the source folder.