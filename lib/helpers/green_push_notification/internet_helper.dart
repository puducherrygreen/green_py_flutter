import 'dart:async';

class InternetHelper {
  static StreamController<bool> connectivityStreamController =
      StreamController<bool>.broadcast();
}
