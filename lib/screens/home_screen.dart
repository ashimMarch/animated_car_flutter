import 'package:animated_car/components/battery_status.dart';
import 'package:animated_car/components/door_lock.dart';
import 'package:animated_car/components/tesla_bottom_navigationbar.dart';
import 'package:animated_car/constants.dart';
import 'package:animated_car/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void setupBatteryAnimation(){
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600)
    );
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      // Here the animaion end on 0.5
      // it ends on 300 milliseconds
      curve: const Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController, 
      // After a delay we start the animation
      // after 60 millisecons delay it start
      // so it start at 360 and end on 600 milliseconds
      curve: const Interval(0.6, 1)
    );
  }
  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
  }
  @override
  void dispose() {
    _batteryAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller,_batteryAnimationController]),
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
              _controller.onBottomNavigationTabChange(index);
            },
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: constrains.maxHeight*0.1),
                      child: SvgPicture.asset(
                        'assets/icons/Car.svg',
                        width: double.infinity,
                        height: double.infinity,
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
                    )
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
