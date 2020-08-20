import 'package:flutter/cupertino.dart';
import 'package:techexperiment001/enums/image_sending_state.dart';

class ImageSendProvider with ChangeNotifier {
  ImageSendingState _imageSendingState = ImageSendingState.NotSending;
  ImageSendingState get getImageSendingState => _imageSendingState;

  void setSending() {
    _imageSendingState = ImageSendingState.Sending;
    notifyListeners();
  }

  void setNotSending() {
    _imageSendingState = ImageSendingState.NotSending;
    notifyListeners();
  }
}
