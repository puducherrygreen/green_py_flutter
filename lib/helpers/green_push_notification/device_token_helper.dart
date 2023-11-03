import 'package:green_puducherry/constant/constant.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../local_storage.dart';

class DeviceToken {
  static setDeviceToken(String? fCMToken) async {
    String? userId = await LocalStorage.getString(GreenText.kUserId);
    String? deviceToken = await LocalStorage.getString(GreenText.kDeviceToken);
    if (userId != null && fCMToken != deviceToken) {
      bool connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        /// tokent update logig

        print('------------- token : $fCMToken');
        LocalStorage.setString(GreenText.kDeviceToken, fCMToken);
      }
    } else {
      print('---------------local user id ------------ $userId');
      print('-----$deviceToken----------device token ------------ $fCMToken');
    }
  }
}
