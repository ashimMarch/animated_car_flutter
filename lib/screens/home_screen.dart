import 'package:animated_car/components/door_lock.dart';
import 'package:animated_car/components/tesla_bottom_navigationbar.dart';
import 'package:animated_car/constants.dart';
import 'package:animated_car/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;

  void setupBatteryAnimation(){
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600)
    );
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController, 
      // so this animation start at 0 and end on half
      // means after 300 milliseconds [total duration is 600]
      curve: const Interval(0.0, 0.5),
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
        print('${_animationBattery.value} \n');
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
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth*0.45,
                      ),
                    ),
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
