import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{
  // we use HomeCotroller for logical part

  bool isRightDoorLocked = true;
  
  void updateRightDoorLock(){
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }
}