# iOS System Sound

<div align="center">
   <img src="https://raw.githubusercontent.com/runoob-coder/ios_system_sound/master/ios-system-sound.png" width="200" style="width: 200px;" alt="iOS System Sound">
</div>

[![Pub Version](https://img.shields.io/pub/v/ios_system_sound.svg)][pub]
[![API Reference](https://img.shields.io/badge/API-Reference-0175C2.svg)](https://pub.dev/documentation/ios_system_sound/latest/)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/runoob-coder/ios_system_sound)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/runoob-coder/ios_system_sound.svg?style=social)][GitHub]

使用系统声音服务（System Sound Services）播放 iOS 系统 UI 音效或触发振动的 Flutter 插件。

[English](README.md) | 简体中文

## ✨ 功能

- 🎛️ 支持播放**全部 iOS 预置系统音效**（`SystemSoundID`）：邮件、短信、提醒、按键、相机、录音、DTMF、耳机等
- 📳 支持通过 `kSystemSoundID_Vibrate` 触发**振动**
- 🔢 支持播放枚举尚未收录的**任意原始 ID**
- 🗂️ 每个音效自带**元数据**：所属系统分类，便于快速搭建分组 UI
- 🤝 **跨平台安全**：非 iOS 平台调用均为空操作，不会抛异常

## 📦 安装

用下面的命令安装最新版本：

```bash
flutter pub add ios_system_sound
```

然后在代码中导入：

```dart
import 'package:ios_system_sound/ios_system_sound.dart';
```

环境要求：**iOS 13.0+**。

## 🚀 用法

### 🔊 播放系统音效

```dart
final sound = IosSystemSound();

// 相机快门声
await sound.play(SystemSoundID.photoShutter);

// 发送短信
await sound.play(SystemSoundID.sentMessage);

// 解锁
await sound.play(SystemSoundID.unlock);
```

返回的 `Future` 在播放请求交给系统后立即完成，**不会**等待声音播放结束；当某个音效 ID 在当前设备上不存在时，系统会静默忽略。

### ⏭️ 依次播放多个音效

传入 `waitForCompletion: true` 后，`Future` 会等到系统报告播放结束才完成，因此可以依次播放一串音效，而不必猜测每个音效的时长：

```dart
for (final id in SystemSoundID.byCategory[SystemSoundCategory.alert]!) {
  await sound.play(id, waitForCompletion: true);
}
```

`vibrate()` 与 `playRawId()` 同样支持该参数。在非 iOS 平台上这些调用依旧是空操作，并立即完成。

### 📳 触发振动

```dart
await sound.vibrate();
```

### 🔢 播放原始音效 ID

适用于枚举尚未收录的 ID，或在原生侧通过 `AudioServicesCreateSystemSoundID` 创建的音效。

```dart
await sound.playRawId(1108); // 等价于 SystemSoundID.photoShutter
```

### 🔍 通过数值反查音效

```dart
SystemSoundID.fromValue(1004);         // SystemSoundID.sentMessage
SystemSoundID.tryFromValue(42);        // null
SystemSoundID.photoShutter.value;      // 1108
SystemSoundID.photoShutter.category;   // SystemSoundCategory.camera
```

### 🧩 构建分组界面

```dart
for (final entry in SystemSoundID.byCategory.entries) {
  final category = entry.key;  // SystemSoundCategory.headset
  final sounds = entry.value;
}
```

## 🗂️ 音效分类

| 分类 | 数量 | 示例 |
| --- | ---: | --- |
| `SystemSoundCategory.mail` | 4 | `newMail`、`mailSent`、`voiceMailReceived` |
| `SystemSoundCategory.sms` | 11 | `receivedMessage`、`sentMessage`、`smsReceived1` |
| `SystemSoundCategory.alert` | 18 | `alarm`、`bloom`、`noir` |
| `SystemSoundCategory.keyPress` | 5 | `tink`、`tock`、`tinkKeyPressed` |
| `SystemSoundCategory.power` | 2 | `lowPower`、`connectedToPower` |
| `SystemSoundCategory.simToolkit` | 5 | `simToolkitSMS` |
| `SystemSoundCategory.network` | 1 | `ussd` |
| `SystemSoundCategory.callTone` | 6 | `ctBusy`、`ctError`、`ctCallWaiting` |
| `SystemSoundCategory.device` | 5 | `lock`、`unlock`、`shake` |
| `SystemSoundCategory.camera` | 1 | `photoShutter` |
| `SystemSoundCategory.recording` | 4 | `beginRecord`、`endVideoRecord` |
| `SystemSoundCategory.voiceChat` | 9 | `jblBegin`、`vcEnded`、`vcRinging` |
| `SystemSoundCategory.touchTone` | 12 | `dtmf0` ... `dtmfPound` |
| `SystemSoundCategory.headset` | 6 | `longLowShortHigh` |
| `SystemSoundCategory.preview` | 33 | `voicemail2`、`updateSelection` |
| `SystemSoundCategory.vibration` | 3 | `vibrate` |
| `SystemSoundCategory.unknown` | 1 | `webcamStart` |

合计 126 个音效（即 `SystemSoundID.values.length`）。

## 📱 示例工程

仓库内置的 [example](example) 按分类浏览全部音效，支持按音效名、分类名或数值 ID 搜索，并可在每个分类中依次播放全部样本。

```bash
cd example && flutter run
```

> [!NOTE]
> **iOS 模拟器无法播放系统音效**，请在真机上运行示例。

## 🌍 平台行为

System Sound Services 仅存在于 iOS。在其它平台上调用会被忽略（debug 构建下会通过 `debugPrint` 输出提示），因此跨平台 App 无需额外分支处理即可共享同一套代码。

| 平台 | 行为 |
| --- | --- |
| iOS | 播放音效 / 振动 |
| 其它平台 | 空操作 |

## 📝 注意事项

> [!NOTE]
> 不同的 iOS 版本和设备，其支持的声音 ID 集合可能略有不同，本库持续补充中。

> [!NOTE]
> 通过 System Sound Services 播放的声音不受 Audio Session 配置影响，因此无法与 App 中其他音频行为保持一致。这也是不应将 System Sound Services 用于其预期用途以外场景的最主要原因。

## 🔗 参考

- [Apple - Using Audio (System Sound Services)](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html)
- [AudioServicesPlaySystemSound(_:)](https://developer.apple.com/documentation/audiotoolbox/audioservicesplaysystemsound(_:))
- [iOSSystemSoundsLibrary](https://github.com/TUNER88/iOSSystemSoundsLibrary)

## 💛 支持

如果 [`ios_system_sound`][pub] 帮助你做出了更好的 App，请考虑支持一下。  
只需几秒钟，就能让更多 Flutter 开发者发现这个库。

- ⭐ [在 GitHub 上 Star][GitHub]
- 👍 [在 pub.dev 上点赞][pub]

## [☕️ 请我喝奶茶](https://www.noob-coder.com/buy-me-a-coffee)

<table>
<thead>
<tr>
    <th style="text-align:center;">赞赏码 WeChat</th>
    <th style="text-align:center;">支付宝 Alipay</th>
</tr>
</thead>
<tbody>
<tr>
    <td width="50%"><img src="https://raw.githubusercontent.com/runoob-coder/runoob-coder/main/public/appreciate.avif" alt="赞赏码WeChat" /></td>
    <td width="50%"><img src="https://raw.githubusercontent.com/runoob-coder/runoob-coder/main/public/alipay.avif" alt="支付宝Alipay" /></td>
  </tr>
</tbody>
</table>

[pub]: https://pub.dev/packages/ios_system_sound

[GitHub]: https://github.com/runoob-coder/ios_system_sound
