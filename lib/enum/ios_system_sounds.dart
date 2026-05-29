/// Default iOS system sound IDs
enum SystemSoundID {
  /// 1000
  newMail,

  /// 1001
  mailSent,

  /// 1002
  voiceMailReceived,

  /// 1003
  receivedMessage,

  /// 1004
  sentMessage,

  /// 1005
  alarm,

  /// 1006
  lowPower,

  /// 1007
  smsReceived1,

  /// 1008
  smsReceived2,

  /// 1009
  smsReceived3,

  /// 1010
  smsReceived4,

  /// 1011
  smsReceivedVibrate,

  /// 1012
  smsReceived,

  /// 1013
  smsReceive5,

  /// 1014
  smsReceive6,

  /// 1015
  voicemail,

  /// 1016
  tweetSent,

  /// 1017-1019 待确认

  /// 1020
  anticipate,

  /// 1021
  bloom,

  /// 1022
  calypso,

  /// 1023
  chooChoo,

  /// 1024
  descent,

  /// 1025
  fanfare,

  /// 1026
  ladder,

  /// 1027
  minuet,

  /// 1028
  newsFlash,

  /// 1029
  noir,

  /// 1030
  sherwoodForest,

  /// 1031
  spell,

  /// 1032
  suspense,

  /// 1033
  telegraph,

  /// 1034
  tiptoes,

  /// 1035
  typewriters,

  /// 1036
  update,

  /// 1037 - 1049 无

  /// 1050
  ussd,

  /// 1052
  simToolkitCallDropped,

  /// 1052
  simToolkitGeneralBeep,

  /// 1053
  simToolkitNegativeACK,

  /// 1054
  simToolkitPositiveACK,

  /// 1055
  simToolkitSMS,

  /// 1056 无

  /// 1057
  tink,

  /// 1060
  webcamStart,

  /// 1061 待确认

  /// 1070
  ctBusy,

  /// 1071
  ctCongestion,

  /// 1072
  ctPathAck,

  /// 1073
  ctError,

  /// 1074
  ctCallWaiting,

  /// 1075
  ctKeytone2,

  /// 1076 - 1099 无

  /// 1100,
  lock,

  /// 1101
  unlock,

  /// 1102
  failedUnlock,

  /// 1103
  tinkKeyPressed,

  /// 1104
  tock,

  /// 1105
  tock2,

  /// 1106
  connectedToPower,

  /// 1107 待确认

  /// 1108
  photoShutter,

  /// 1109
  shake,

  /// 1110
  jblBegin,

  /// 1111
  jblConfirm,

  /// 1112
  jblCancel,

  /// 1113
  beginRecord,

  /// 1114
  endRecord,

  /// 1115
  jblAmbiguous,

  /// 1116
  jblNoMatch,

  /// 1117
  beginVideoRecord,

  /// 1118
  endVideoRecord,

  /// 1119-1149 待确认

  /// 1150
  vcInvitationAccepted,

  /// 1151
  vcRinging,

  /// 1152
  vcEnded,

  /// 1153
  ctCallWaiting2,

  /// 1154
  vcRinging2,

  /// 1155 -1199 待确认

  /// 1200
  dtmf0,

  /// 1201
  dtmf1,

  /// 1202
  dtmf2,

  /// 1203
  dtmf3,

  /// 1204
  dtmf4,

  /// 1205
  dtmf5,

  /// 1206
  dtmf6,

  /// 1207
  dtmf7,

  /// 1208
  dtmf8,

  /// 1209
  dtmf9,

  /// 1210
  dtmfStar,

  /// 1211
  dtmfPound,

  /// 1212 - 1252 无

  /// 1253 待确认

  /// 1254
  longLowShortHigh,

  /// 1255
  shortDoubleHigh,

  /// 1256
  shortLowHigh,

  /// 1257
  shortDoubleLow,

  /// 1258
  shortDoubleLow2,

  /// 1259
  middle9ShortDoubleLow,

  /// 1260 - 1299 待确认

  /// 1300
  voicemail2,

  /// 1301
  receivedMessage2,

  /// 1302
  newMail2,

  /// 1303
  mailSent2,

  /// 1304
  alarm2,

  /// 1305
  lock2,

  /// 1306
  tock3;

  /// Get the integer value for the system sound ID
  int get value => switch (this) {
    newMail => 1000,
    mailSent => 1001,
    voiceMailReceived => 1002,
    receivedMessage => 1003,
    sentMessage => 1004,
    alarm => 1005,
    lowPower => 1006,
    smsReceived1 => 1007,
    smsReceived2 => 1008,
    smsReceived3 => 1009,
    smsReceived4 => 1010,
    smsReceivedVibrate => 1011,
    smsReceived => 1012,
    smsReceive5 => 1013,
    smsReceive6 => 1014,
    voicemail => 1015,
    tweetSent => 1016,
    anticipate => 1020,
    bloom => 1021,
    calypso => 1022,
    chooChoo => 1023,
    descent => 1024,
    fanfare => 1025,
    ladder => 1026,
    minuet => 1027,
    newsFlash => 1028,
    noir => 1029,
    sherwoodForest => 1030,
    spell => 1031,
    suspense => 1032,
    telegraph => 1033,
    tiptoes => 1034,
    typewriters => 1035,
    update => 1036,
    ussd => 1050,
    simToolkitCallDropped => 1051,
    simToolkitGeneralBeep => 1052,
    simToolkitNegativeACK => 1053,
    simToolkitPositiveACK => 1054,
    simToolkitSMS => 1055,
    tink => 1057,
    webcamStart => 1060,
    ctBusy => 1070,
    ctCongestion => 1071,
    ctPathAck => 1072,
    ctError => 1073,
    ctCallWaiting => 1074,
    ctKeytone2 => 1075,
    lock => 1100,
    unlock => 1101,
    failedUnlock => 1102,
    tinkKeyPressed => 1103,
    tock => 1104,
    tock2 => 1105,
    connectedToPower => 1106,
    photoShutter => 1108,
    shake => 1109,
    jblBegin => 1110,
    jblConfirm => 1111,
    jblCancel => 1112,
    beginRecord => 1113,
    endRecord => 1114,
    jblAmbiguous => 1115,
    jblNoMatch => 1116,
    beginVideoRecord => 1117,
    endVideoRecord => 1118,
    vcInvitationAccepted => 1150,
    vcRinging => 1151,
    vcEnded => 1152,
    ctCallWaiting2 => 1153,
    vcRinging2 => 1154,
    dtmf0 => 1200,
    dtmf1 => 1201,
    dtmf2 => 1202,
    dtmf3 => 1203,
    dtmf4 => 1204,
    dtmf5 => 1205,
    dtmf6 => 1206,
    dtmf7 => 1207,
    dtmf8 => 1208,
    dtmf9 => 1209,
    dtmfStar => 1210,
    dtmfPound => 1211,
    longLowShortHigh => 1254,
    shortDoubleHigh => 1255,
    shortLowHigh => 1256,
    shortDoubleLow => 1257,
    shortDoubleLow2 => 1258,
    middle9ShortDoubleLow => 1259,
    voicemail2 => 1300,
    receivedMessage2 => 1301,
    newMail2 => 1302,
    mailSent2 => 1303,
    alarm2 => 1304,
    lock2 => 1305,
    tock3 => 1306,
  };
}
