# ios_system_sound

使用系统声音服务播放 UI 音效或触发振动。

Playing UI Sound Effects or Invoking Vibration Using System Sound Services

There are some predefined system sounds, for the system sound ID in the range 1000 to 2000 (decimal), 
as shown below (from 2.0 to 5.0 beta). 

The system sounds are all stored in/System/Library/Audio/UISounds/.

> Note: Sounds played with System Sound Services are not subject to configuration using your audio session. 
> As a result, you cannot keep the behavior of System Sound Services audio in line with other audio behavior in your application.
> This is the most important reason to avoid using System Sound Services for any audio apart from its intended uses

## 📦 Usage 用法

```dart
IosSystemSound().play(.photoShutter);
```

## 🔊 [SystemSoundID](https://pub.dev/documentation/ios_system_sound/latest/enum_ios_system_sounds/SystemSoundID.html)

List of all system sounds used in iOS

https://pub.dev/documentation/ios_system_sound/latest/enum_ios_system_sounds/SystemSoundID.html

> Note: 不同的 iOS 版本和设备，其支持的 ID 集合可能略有不同。
> 持续补充中...

## 📚 References 参考

https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html

https://developer.apple.com/documentation/audiotoolbox/audioservicesplaysystemsound(_:)

https://github.com/TUNER88/iOSSystemSoundsLibrary

## ☕️ Buy Me a Coffee / 请我喝咖啡

<a href="https://ko-fi.com/noob_coder" target="_blank">
  <img src="https://storage.ko-fi.com/cdn/kofi6.png" alt="Buy Me a Coffee at ko-fi.com" />
</a>