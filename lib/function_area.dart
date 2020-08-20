import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as imgClass;
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';
import 'message_model.dart';

StorageReference _storageReference;
final _firestore = Firestore.instance;

class FunctionArea {
  static Future<File> pickImage({@required ImageSource imageSource}) async {
    File selectedImage = await ImagePicker.pickImage(source: imageSource);
    return compressImage(selectedImage);
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDirectory = await getTemporaryDirectory();
    final path = tempDirectory.path;
    int random = Random().nextInt(10000);
    imgClass.Image image =
        imgClass.decodeImage(imageToCompress.readAsBytesSync());
    imgClass.copyResize(image, width: 500, height: 500);
    return new File('$path/image_$random.jpg')
      ..writeAsBytesSync(imgClass.encodeJpg(image, quality: 85));
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    _storageReference = FirebaseStorage.instance
        .ref()
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    StorageUploadTask _storageUploadTask = _storageReference.putFile(imageFile);
    String imageURL =
        await (await _storageUploadTask.onComplete).ref.getDownloadURL();
    return imageURL;
  }

  Future<void> uploadImage(
      File imageFile, Message messageForMe, Message messageForThem) async {
    String imageURL = await uploadImageToStorage(imageFile);

    Map mapForMe = messageForMe.toMap();
    Map mapForThem = messageForThem.toMap();

    mapForMe['ImageURL'] = imageURL;
    mapForThem['ImageURL'] = imageURL;

    await _firestore
        .collection(messagesDB)
        .document(messageForThem.companionID)
        .collection(messageForMe.companionID)
        .add(mapForMe);

    await _firestore
        .collection(messagesDB)
        .document(messageForThem.companionID)
        .collection('Recent Chats')
        .document(messageForMe.companionID)
        .setData(mapForMe);

    await _firestore
        .collection(messagesDB)
        .document(messageForMe.companionID)
        .collection('Recent Chats')
        .document(messageForThem.companionID)
        .setData(mapForThem);

    await _firestore
        .collection(messagesDB)
        .document(messageForMe.companionID)
        .collection(messageForThem.companionID)
        .add(mapForThem);
  }
}
