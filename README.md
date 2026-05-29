# ios_system_sound

Playing UI Sound Effects or Invoking Vibration Using System Sound Services

There are some predefined system sounds, for the system sound ID in the range 1000 to 2000 (decimal), 
as shown below (from 2.0 to 5.0 beta). 

The system sounds are all stored in/System/Library/Audio/UISounds/.

> Note: Sounds played with System Sound Services are not subject to configuration using your audio session. 
> As a result, you cannot keep the behavior of System Sound Services audio in line with other audio behavior in your application.
> This is the most important reason to avoid using System Sound Services for any audio apart from its intended uses

## Usage 用法

```dart
IosSystemSound().play(.photoShutter);
```

## References 参考

https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html

https://developer.apple.com/documentation/audiotoolbox/audioservicesplaysystemsound(_:)

https://github.com/TUNER88/iOSSystemSoundsLibrary

