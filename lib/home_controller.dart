import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{
  // we use HomeCotroller for logical part

  int selectedBottomTab = 0;
  void onBottomNavigationTabChange(int index){
    selectedBottomTab = index;
    notifyListeners();
  }

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

  bool isCoolSelected = true;
  void updatedCoolSelected(){
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }
}