import 'package:flutter/foundation.dart';

class Call {
  final String callerNumber;
  final String callChannelID;

  Call({
    @required this.callerNumber,
    @required this.callChannelID,
  });

  Map<String, dynamic> dataToMap(Call call) {
    Map<String, dynamic> snapshotMap = Map();
    snapshotMap['CallerNumber'] = call.callerNumber;
    snapshotMap['CallChannelID'] = call.callChannelID;
    return snapshotMap;
  }
}
