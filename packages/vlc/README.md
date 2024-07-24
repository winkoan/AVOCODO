# matlab-vlc

Control VLC from a MATLAB script

VLC actions such as play, pause, stop, next, previous, etc. are defined as class methods.
VLC settings such as Loop, Random, Repeat and Fullscreen are exposed to MATLAB and can be accessed with set() and get().
Informations about the current file can be retrieved through the 'Current' property (length, position, metadata, etc).

### Methods
- `add('file')`: add "file" to the playlist
- `play()` or `play('file')`: resume playback or play "file"
- `pause()`: pause playback
- `stop()`: stop playback
- `next()`: play next track
- `prev()`: play previous track
- `seek(position)`: seek to position (in seconds)
- `move(x,y)`: move item ID x in the playlist after item ID y
- `remove(x)`: remove item ID x from the playlist
- `clear()`: empty the playlist
- `quit()`: quit VLC and delete object

### Properties
- Port (read only)
- Version (read only)
- Status (read only)
- Current (read only)
- Playlist (read only)
- Loop
- Repeat
- Random
- Fullscreen
- Rate
- Volume

## Example
```
>> v = VLC()

v = 

  VLC with properties:

          Port: 4212
       Version: '2.2.8 Weatherwax'
        Status: 'stopped'
       Current: []
      Playlist: [1x1 struct]
          Loop: 'off'
        Repeat: 'off'
        Random: 'off'
    Fullscreen: 'off'
          Rate: 1
        Volume: 256

>> v.play('/Users/Lea/Desktop/3905.aif') 
>> v

v = 

  VLC with properties:

          Port: 4212
       Version: '2.2.8 Weatherwax'
        Status: 'playing'
       Current: [1x1 struct]
      Playlist: [1x1 struct]
          Loop: 'off'
        Repeat: 'off'
        Random: 'off'
    Fullscreen: 'off'
          Rate: 1
        Volume: 256

>> v.Current

ans = 

          ID: 4
      Length: 77.0903
        Meta: [1x1 struct]
    Position: 8.8021

>> v.stop()
```

## Requires
- A JSON decoding function ([json_decode](https://gitlab.com/leastrobino/matlab-json))