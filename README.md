# SourceTV manager

Allows you to manage SourceTV

### Supported Games

* Day of Defeat: Source

### Requirements

* [SourceMod](https://www.sourcemod.net) 1.12 or later

### Installation

* Download latest [release](https://github.com/dronelektron/sm-source-tv-manager/releases)
* Extract `gamedata` and `plugins` folders to `addons/sourcemod` folder of your server

### API

Called when recording has started

```sourcepawn
forward void SourceTV_OnStartRecording();
```

Called when recording has stopped

```sourcepawn
forward void SourceTV_OnStopRecording();
```
