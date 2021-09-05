# Spotify Now Playing

<p align="center">
  <a href="https://github.com/fork-my-spoons/spotify-now-playing.spoon/actions">
    <img alt="Build" src="https://github.com/fork-my-spoons/spotify-now-playing.spoon/workflows/release/badge.svg"/></a>
  <a href="https://github.com/fork-my-spoons/spotify-now-playing.spoon/issues">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/fork-my-spoons/spotify-now-playing.spoon"/></a>
  <a href="https://github.com/fork-my-spoons/spotify-now-playing.spoon/releases">
    <img alt="GitHub all releases" src="https://img.shields.io/github/downloads/fork-my-spoons/spotify-now-playing.spoon/total"/></a>
</p>

A menu bar app which shows currently playing song on Spotify:

Playing: 

<p align="center">
  <img alt="screenshot" src="https://github.com/fork-my-spoons/spotify-current-song.spoon/raw/main/screenshots/screenshot.png">
</p>
  
Paused:
  
<p align="center">
  <img alt="screenshot2" src="https://github.com/fork-my-spoons/spotify-current-song.spoon/raw/main/screenshots/screenshot2.png">
</p>
  
Click on the bar toggles the playback. It is also possible to setup shortcuts to play next/previous track and toggle the playback - see below.

# Installation

 - install [Hammerspoon](http://www.hammerspoon.org/) - a powerfull automation tool for OS X
   - Manually:

      Download the [latest release](), and drag Hammerspoon.app from your Downloads folder to Applications.
   - Homebrew:

      ```brew install hammerspoon --cask```

 - download [spotify-now-playing.spoon](https://github.com/fork-my-spoons/spotify-now-playing.spoon/releases/latest/download/spotify-now-playing.spoon.zip), unzip and double click on a .spoon file. It will be installed under `~/.hammerspoon/Spoons` folder.
 
 - open ~/.hammerspoon/init.lua and add the following snippet, adding your parameters:

```lua
-- Spotify current song
hs.loadSpoon("spotify-current-song")
spoon['spotify-current-song']:start()
spoon['spotify-current-song']:bindHotkeys(
  {
    next={ {"alt"}, "."},
    prev={ {"alt"}, ","},
    playpause={ {"alt"}, "/"}
  }
)
```

The config above sets up the ollowing shortcuts:

 - <kbd>⌥</kbd> + <kbd>,</kbd> - play next track
 - <kbd>⌥</kbd> + <kbd>.</kbd> - play previous track
 - <kbd>⌥</kbd> + <kbd>/</kbd> - play/pause
