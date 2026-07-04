# iOS System Sound

Playing UI Sound Effects or Invoking Vibration Using System Sound Services on iOS.

使用系统声音服务（System Sound Services）播放 iOS 系统 UI 音效或触发振动的 Flutter 插件。

---

## 🚀 Installation / 安装

👉 [pub.dev Install Guide / 安装指南](https://pub.dev/packages/ios_system_sound/install)

---

## 📦 Usage / 用法

```dart
// Camera shutter / 相机快门声
IosSystemSound().play(SystemSoundID.photoShutter);

// Message sent / 发送消息
IosSystemSound().play(SystemSoundID.sentMessage);

// Unlock / 解锁
IosSystemSound().play(SystemSoundID.unlock);
```

---

## 🔊 SystemSoundID

iOS predefines system sounds in the range 1000~2000 (decimal). All sound files are stored in `/System/Library/Audio/UISounds/`.

iOS 预定义了编号 1000~2000（十进制）范围内的系统声音，所有声音文件存储在 `/System/Library/Audio/UISounds/` 目录下。

For the complete list of sound IDs, see the documentation:

完整的声音 ID 列表请查看文档：

👉 [SystemSoundID Enum Reference / 枚举参考](https://pub.dev/documentation/ios_system_sound/latest/enum_ios_system_sounds/SystemSoundID.html)

> [!NOTE]
> The set of supported sound IDs may vary slightly across different iOS versions and devices. This library is being continuously supplemented.
>
> 不同的 iOS 版本和设备，其支持的声音 ID 集合可能略有不同，本库持续补充中。

> [!NOTE]
> Sounds played via System Sound Services are not subject to Audio Session configuration, so they cannot be aligned with other audio behavior in your app. This is the main reason to avoid using System Sound Services for anything other than its intended purpose.
>
> 通过 System Sound Services 播放的声音不受 Audio Session 配置影响，因此无法与 App 中其他音频行为保持一致。这也是不应将 System Sound Services 用于其预期用途以外场景的最主要原因。

---

## 📚 References / 参考

- [Apple - Using Audio (System Sound Services)](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html)
- [AudioServicesPlaySystemSound(_:)](https://developer.apple.com/documentation/audiotoolbox/audioservicesplaysystemsound(_:))
- [iOSSystemSoundsLibrary](https://github.com/TUNER88/iOSSystemSoundsLibrary)

---

## ☕️ Buy Me a Coffee / 请我喝咖啡

<a href="https://ko-fi.com/noob_coder" target="_blank">
  <img src="https://storage.ko-fi.com/cdn/kofi6.png" alt="Buy Me a Coffee at ko-fi.com" />
</a>
