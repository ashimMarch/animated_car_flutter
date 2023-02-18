import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{
  // we use HomeCotroller for logical part

  bool isRightDoorLocked = true;
  bool isLeftDoorLocked = true;
  bool isBonnetLock = true;
  bool isTrunkLock = true;
  
  void updateRightDoorLock(){
    isRightDoorLocked = !isRightDoorLocked;
    notifyListeners();
  }
  void updateLeftDoorLock(){
    isLeftDoorLocked = !isLeftDoorLocked;
    notifyListeners();
  }
  void updateBonnetDoorLock(){
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }
  void updateTrunkDoorLock(){
    isTrunkLock = !isTrunkLock;
    notifyListeners();
  }
}