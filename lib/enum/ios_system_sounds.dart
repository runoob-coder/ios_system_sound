/// Categories used by iOS to group its predefined system sounds, so consumers
/// can build grouped UI without maintaining their own mapping.
enum SystemSoundCategory {
  /// Mail related feedback (new mail, mail sent, voicemail).
  mail,

  /// Message (SMS/iMessage) related feedback and alert tones.
  sms,

  /// Calendar / alert style tones that can be used as custom ringtones.
  alert,

  /// Key press feedback tones.
  keyPress,

  /// Power state changes (low battery, connected to power).
  power,

  /// SIM Toolkit tones.
  simToolkit,

  /// Carrier / network tones such as USSD.
  network,

  /// Circuit switched call progress tones (busy, congestion, ...).
  callTone,

  /// Device level feedback: lock, unlock, ringer switch, shake to shuffle.
  device,

  /// Camera feedback.
  camera,

  /// Audio / video recording start & stop feedback.
  recording,

  /// Voice control (JBL) and voice chat feedback.
  voiceChat,

  /// DTMF touch tones (0-9, *, #).
  touchTone,

  /// Headset call control tones.
  headset,

  /// Variants used by the system sound picker preview UI.
  preview,

  /// Vibration-only feedback (no audible sound).
  vibration,

  /// Not (yet) documented by Apple.
  unknown;

  /// Stable display name of the category.
  String get label => switch (this) {
    .mail => 'Mail',
    .sms => 'Messages',
    .alert => 'Alerts',
    .keyPress => 'Key Press',
    .power => 'Power',
    .simToolkit => 'SIM Toolkit',
    .network => 'Network',
    .callTone => 'Call Tones',
    .device => 'Device',
    .camera => 'Camera',
    .recording => 'Recording',
    .voiceChat => 'Voice Control',
    .touchTone => 'Touch Tones',
    .headset => 'Headset',
    .preview => 'Sound Picker Preview',
    .vibration => 'Vibration',
    .unknown => 'Uncategorized',
  };
}

/// Predefined iOS system sound IDs: the `1000...1351` range, plus `4095`
/// (`kSystemSoundID_Vibrate`), which vibrates instead of playing audio.
///
/// Each value exposes the raw [SystemSoundID.value] handed to
/// `AudioServicesPlaySystemSound(_:)` and the [SystemSoundCategory] it belongs
/// to.
///
/// ```dart
/// IosSystemSound().play(SystemSoundID.photoShutter);
/// ```
///
/// > Supported IDs differ slightly between iOS versions and devices; unavailable
/// > ones are silently ignored.
enum SystemSoundID {
  /// New mail received (1000).
  newMail(1000, .mail),

  /// Mail sent (1001).
  mailSent(1001, .mail),

  /// Voicemail received (1002).
  voiceMailReceived(1002, .mail),

  /// Message received (1003).
  receivedMessage(1003, .sms),

  /// Message sent (1004).
  sentMessage(1004, .sms),

  /// Calendar alarm (1005).
  alarm(1005, .alert),

  /// Low battery warning (1006).
  lowPower(1006, .power),

  /// SMS alert tone #1 (1007).
  smsReceived1(1007, .sms),

  /// SMS alert tone #2 (1008).
  smsReceived2(1008, .sms),

  /// SMS alert tone #3 (1009).
  smsReceived3(1009, .sms),

  /// SMS alert tone #4 (1010).
  smsReceived4(1010, .sms),

  /// SMS vibration pattern (1011).
  smsReceivedVibrate(1011, .sms),

  /// SMS alert tone #5 (1012).
  smsReceived(1012, .sms),

  /// SMS alert tone #6 (1013).
  smsReceive5(1013, .sms),

  /// SMS alert tone #7 (1014).
  smsReceive6(1014, .sms),

  /// Voicemail preview (1015).
  voicemail(1015, .mail),

  /// Tweet sent (1016).
  tweetSent(1016, .sms),

  /// Alert tone (1020).
  ///
  /// 1017-1019 are not documented by Apple.
  anticipate(1020, .alert),

  /// Alert tone (1021).
  bloom(1021, .alert),

  /// Alert tone (1022).
  calypso(1022, .alert),

  /// Alert tone (1023).
  chooChoo(1023, .alert),

  /// Alert tone (1024).
  descent(1024, .alert),

  /// Alert tone (1025).
  fanfare(1025, .alert),

  /// Alert tone (1026).
  ladder(1026, .alert),

  /// Alert tone (1027).
  minuet(1027, .alert),

  /// Alert tone (1028).
  newsFlash(1028, .alert),

  /// Alert tone (1029).
  noir(1029, .alert),

  /// Alert tone (1030).
  sherwoodForest(1030, .alert),

  /// Alert tone (1031).
  spell(1031, .alert),

  /// Alert tone (1032).
  suspense(1032, .alert),

  /// Alert tone (1033).
  telegraph(1033, .alert),

  /// Alert tone (1034).
  tiptoes(1034, .alert),

  /// Alert tone (1035).
  typewriters(1035, .alert),

  /// Alert tone (1036).
  ///
  /// 1037-1049 are unused.
  update(1036, .alert),

  /// USSD alert (1050).
  ussd(1050, .network),

  /// SIM Toolkit call dropped (1051).
  simToolkitCallDropped(1051, .simToolkit),

  /// SIM Toolkit general beep (1052).
  simToolkitGeneralBeep(1052, .simToolkit),

  /// SIM Toolkit negative acknowledgement (1053).
  simToolkitNegativeACK(1053, .simToolkit),

  /// SIM Toolkit positive acknowledgement (1054).
  simToolkitPositiveACK(1054, .simToolkit),

  /// SIM Toolkit SMS (1055).
  ///
  /// 1056 is unused.
  simToolkitSMS(1055, .simToolkit),

  /// Keypad / PIN key pressed (1057).
  ///
  /// 1058 and 1059 are unused.
  tink(1057, .keyPress),

  /// Webcam start (1060). Undocumented by Apple, availability not guaranteed.
  webcamStart(1060, .unknown),

  /// Line busy (1070).
  ctBusy(1070, .callTone),

  /// Network congestion (1071).
  ctCongestion(1071, .callTone),

  /// Path acknowledge (1072).
  ctPathAck(1072, .callTone),

  /// Call error (1073).
  ctError(1073, .callTone),

  /// Call waiting (1074).
  ctCallWaiting(1074, .callTone),

  /// Second keypad tone (1075).
  ///
  /// 1076-1099 are unused.
  ctKeytone2(1075, .keyPress),

  /// Screen locked (1100).
  lock(1100, .device),

  /// Screen unlocked (1101).
  unlock(1101, .device),

  /// Screen unlock failed (1102).
  failedUnlock(1102, .device),

  /// Key pressed (1103).
  tinkKeyPressed(1103, .keyPress),

  /// Key pressed (1104).
  tock(1104, .keyPress),

  /// Alternate key pressed (1105).
  tock2(1105, .keyPress),

  /// Connected to power (1106).
  connectedToPower(1106, .power),

  /// Ringer switch toggled (1107).
  ringerChanged(1107, .device),

  /// Camera shutter (1108).
  photoShutter(1108, .camera),

  /// Shake to shuffle (1109).
  shake(1109, .device),

  /// Voice control ready (1110).
  jblBegin(1110, .voiceChat),

  /// Voice control confirmation (1111).
  jblConfirm(1111, .voiceChat),

  /// Voice control cancelled (1112).
  jblCancel(1112, .voiceChat),

  /// Audio recording started (1113).
  beginRecord(1113, .recording),

  /// Audio recording stopped (1114).
  endRecord(1114, .recording),

  /// Voice control ambiguous (1115).
  jblAmbiguous(1115, .voiceChat),

  /// Voice control no match (1116).
  jblNoMatch(1116, .voiceChat),

  /// Video recording started (1117).
  beginVideoRecord(1117, .recording),

  /// Video recording stopped (1118).
  ///
  /// 1119-1149 are undocumented by Apple.
  endVideoRecord(1118, .recording),

  /// Invitation accepted (1150).
  vcInvitationAccepted(1150, .voiceChat),

  /// Incoming call ringing (1151).
  vcRinging(1151, .voiceChat),

  /// Call ended (1152).
  vcEnded(1152, .voiceChat),

  /// Call waiting during call (1153).
  ctCallWaiting2(1153, .callTone),

  /// Call upgrade ringing (1154).
  ///
  /// 1155-1199 are undocumented by Apple.
  vcRinging2(1154, .voiceChat),

  /// DTMF tone `0` (1200).
  dtmf0(1200, .touchTone),

  /// DTMF tone `1` (1201).
  dtmf1(1201, .touchTone),

  /// DTMF tone `2` (1202).
  dtmf2(1202, .touchTone),

  /// DTMF tone `3` (1203).
  dtmf3(1203, .touchTone),

  /// DTMF tone `4` (1204).
  dtmf4(1204, .touchTone),

  /// DTMF tone `5` (1205).
  dtmf5(1205, .touchTone),

  /// DTMF tone `6` (1206).
  dtmf6(1206, .touchTone),

  /// DTMF tone `7` (1207).
  dtmf7(1207, .touchTone),

  /// DTMF tone `8` (1208).
  dtmf8(1208, .touchTone),

  /// DTMF tone `9` (1209).
  dtmf9(1209, .touchTone),

  /// DTMF tone `*` (1210).
  dtmfStar(1210, .touchTone),

  /// DTMF tone `#` (1211).
  ///
  /// 1212-1253 are unused or undocumented by Apple.
  dtmfPound(1211, .touchTone),

  /// Headset start call (1254).
  longLowShortHigh(1254, .headset),

  /// Headset redial (1255).
  shortDoubleHigh(1255, .headset),

  /// Headset answer call (1256).
  shortLowHigh(1256, .headset),

  /// Headset end call (1257).
  shortDoubleLow(1257, .headset),

  /// Headset call waiting action (1258).
  shortDoubleLow2(1258, .headset),

  /// Headset transition end (1259).
  ///
  /// 1260-1299 are undocumented by Apple.
  middle9ShortDoubleLow(1259, .headset),

  /// Voicemail (preview) (1300).
  voicemail2(1300, .preview),

  /// Message received (preview) (1301).
  receivedMessage2(1301, .preview),

  /// New mail received (preview) (1302).
  newMail2(1302, .preview),

  /// Mail sent (preview) (1303).
  mailSent2(1303, .preview),

  /// Calendar alarm (preview) (1304).
  alarm2(1304, .preview),

  /// Screen locked (preview) (1305).
  lock2(1305, .preview),

  /// Key press click (preview) (1306).
  tock3(1306, .preview),

  /// SMS tone #1 (picker) (1307).
  smsReceivedSelection1(1307, .preview),

  /// SMS tone #2 (picker) (1308).
  smsReceivedSelection2(1308, .preview),

  /// SMS tone #3 (picker) (1309).
  smsReceivedSelection3(1309, .preview),

  /// SMS tone #4 (picker) (1310).
  smsReceivedSelection4(1310, .preview),

  /// SMS vibration pattern (picker, 1311).
  smsReceivedSelectionVibrate(1311, .preview),

  /// SMS tone #5 (picker) (1312).
  smsReceivedSelection5(1312, .preview),

  /// SMS tone #6 (picker) (1313).
  smsReceivedSelection6(1313, .preview),

  /// SMS tone #7 (picker) (1314).
  smsReceivedSelection7(1314, .preview),

  /// Voicemail (picker) (1315).
  voicemailSelection(1315, .preview),

  /// Alert tone (picker) (1320).
  anticipateSelection(1320, .preview),

  /// Alert tone (picker) (1321).
  bloomSelection(1321, .preview),

  /// Alert tone (picker) (1322).
  calypsoSelection(1322, .preview),

  /// Alert tone (picker) (1323).
  chooChooSelection(1323, .preview),

  /// Alert tone (picker) (1324).
  descentSelection(1324, .preview),

  /// Alert tone (picker) (1325).
  fanfareSelection(1325, .preview),

  /// Alert tone (picker) (1326).
  ladderSelection(1326, .preview),

  /// Alert tone (picker) (1327).
  minuetSelection(1327, .preview),

  /// Alert tone (picker) (1328).
  newsFlashSelection(1328, .preview),

  /// Alert tone (picker) (1329).
  noirSelection(1329, .preview),

  /// Alert tone (picker) (1330).
  sherwoodForestSelection(1330, .preview),

  /// Alert tone (picker) (1331).
  spellSelection(1331, .preview),

  /// Alert tone (picker) (1332).
  suspenseSelection(1332, .preview),

  /// Alert tone (picker) (1333).
  telegraphSelection(1333, .preview),

  /// Alert tone (picker) (1334).
  tiptoesSelection(1334, .preview),

  /// Alert tone (picker) (1335).
  typewritersSelection(1335, .preview),

  /// Alert tone (picker) (1336).
  updateSelection(1336, .preview),

  /// Ringer / vibration setting changed (1350). Vibrates when the device is in
  /// silent mode.
  ringerVibeChanged(1350, .vibration),

  /// Silent / vibration setting changed (1351). Vibrates when the device is in
  /// silent mode.
  silentVibeChanged(1351, .vibration),

  /// Vibration feedback (`kSystemSoundID_Vibrate`, 4095). Plays no sound.
  vibrate(4095, .vibration);

  const SystemSoundID(this.value, this.category);

  /// The raw `SystemSoundID` handed to `AudioServicesPlaySystemSound(_:)`.
  final int value;

  /// The [SystemSoundCategory] this sound belongs to.
  final SystemSoundCategory category;

  /// All sounds grouped by [category].
  static Map<SystemSoundCategory, List<SystemSoundID>> get byCategory {
    return <SystemSoundCategory, List<SystemSoundID>>{
      for (final category in SystemSoundCategory.values)
        category: values.where((id) => id.category == category).toList(),
    };
  }

  /// Looks up a sound by its raw [SystemSoundID.value].
  ///
  /// Throws an [ArgumentError] when unknown; use [tryFromValue] instead if
  /// unknown values should be tolerated.
  static SystemSoundID fromValue(int value) {
    final sound = tryFromValue(value);
    if (sound == null) {
      throw ArgumentError.value(
        value,
        'value',
        'Unknown SystemSoundID. Use '
            'IosSystemSound().playRawId($value) to play unsupported IDs.',
      );
    }
    return sound;
  }

  /// Looks up a sound by its raw [SystemSoundID.value], or `null` when unknown.
  static SystemSoundID? tryFromValue(int value) {
    for (final sound in values) {
      if (sound.value == value) {
        return sound;
      }
    }
    return null;
  }
}
