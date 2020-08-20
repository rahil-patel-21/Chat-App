import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../authcontroller.dart';
import '../constants/reference_constants.dart';

Stream<DocumentSnapshot> callStream({@required User currentUser}) =>
    callCollection.document(currentUser.userNumber).snapshots();

Stream<DocumentSnapshot> liveStream() =>
    liveStreamsCollection.document('Temporary Live Stream').snapshots();
