import 'package:animated_car/components/battery_status.dart';
import 'package:animated_car/components/door_lock.dart';
import 'package:animated_car/components/temp_details.dart';
import 'package:animated_car/components/tesla_bottom_navigationbar.dart';
import 'package:animated_car/constants.dart';
import 'package:animated_car/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/tyres.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  void setupBatteryAnimation(){
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600)
    );
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1)
    );
  }
  void setupTempAnimation(){
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController, curve: const Interval(0.2, 0.4)
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController, curve: const Interval(0.45, 0.65)
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
       curve: const Interval(0.7, 1),
    );
  }

  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
    setupTempAnimation();
  }
  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller,_batteryAnimationController,_tempAnimationController]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            selectedTab: _controller.selectedBottomTab,
            onTap: (index) {
              if(index == 1) {
                _batteryAnimationController.forward();
              } else if(_controller.selectedBottomTab == 1 && index != 1){
                _batteryAnimationController.reverse(from: 0.7);
              }
              if(index == 2){
                _tempAnimationController.forward();
              }else if(_controller.selectedBottomTab == 2 && index != 2){
                  _tempAnimationController.reverse(from: 0.4);
              }
              _controller.showTyreController(index);
              _controller.onBottomNavigationTabChange(index);
            },
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(//  for taking all space 
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),

                    Positioned(
                      left: constrains.maxWidth*0.5*_animationCarShift.value,
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: constrains.maxHeight*0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0 ? constrains.maxWidth*0.05 : constrains.maxWidth*0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLocked,
                          press: _controller.updateRightDoorLock, 
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0 ? constrains.maxWidth*0.05 : constrains.maxWidth*0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLocked,
                          press: _controller.updateLeftDoorLock, 
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0 ? constrains.maxHeight*0.13 : constrains.maxHeight*0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetDoorLock, 
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0 ? constrains.maxHeight*0.17 : constrains.maxHeight*0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkLock,
                          press: _controller.updateTrunkDoorLock, 
                        ),
                      ),
                    ),

                    // Battery
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth*0.45,
                      ),
                    ),
                    Positioned(
                      // Here the animation value start at 0 & end on 1
                      top: 50*(1-_animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(constrains: constrains,),
                      ),
                    ),

                    //  Temp
                    Positioned(
                      top: 60*(1-_animationCarShift.value),
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(controller: _controller),
                      ),
                    ),
                    Positioned(
                      right: -180*(1-_animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected 
                        ? Image.asset(
                          'assets/images/Cool_glow_2.png',
                          width: 200,
                          key: UniqueKey(),
                        )
                        : Image.asset(
                          'assets/images/Hot_glow_4.png',
                          width: 200,
                          key: UniqueKey(),
                        ),
                      ),
                    ),

                    //  Tyre section
                    if(_controller.isShowTyre) ...tyres(constrains)
                  ],
                );
              }
            ),
          ),
        );
      }
    );
  }
}
