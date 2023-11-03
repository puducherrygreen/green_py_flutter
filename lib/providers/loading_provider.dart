import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  callFunction(Function function) async {
    isLoading = false;
    notifyListeners();
    try {
      await function();
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
    notifyListeners();
  }
}
