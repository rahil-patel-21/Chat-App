import 'package:cloud_firestore/cloud_firestore.dart';

const String CALL_DATABASE = 'Call Databases';
const String LIVE_STREAM_DATABASE = 'Live Steams Database';

const String APP_ID = 'd9756722a1e841558d3ae396cd544fd6';

final CollectionReference callCollection =
    Firestore.instance.collection(CALL_DATABASE);

final CollectionReference liveStreamsCollection =
    Firestore.instance.collection(LIVE_STREAM_DATABASE);
