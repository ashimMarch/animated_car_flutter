import 'package:animated_car/components/door_lock.dart';
import 'package:animated_car/components/tesla_bottom_navigationbar.dart';
import 'package:animated_car/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            selectedTab: _controller.selectedBottomTab,
            onTap: (index) {
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
                    Positioned(
                      right: constrains.maxWidth*0.05,
                      child: DoorLock(
                        isLock: _controller.isRightDoorLocked,
                        press: _controller.updateRightDoorLock, 
                      ),
                    ),
                    Positioned(
                      left: constrains.maxWidth*0.05,
                      child: DoorLock(
                        isLock: _controller.isLeftDoorLocked,
                        press: _controller.updateLeftDoorLock, 
                      ),
                    ),
                    Positioned(
                      top: constrains.maxHeight*0.13,
                      child: DoorLock(
                        isLock: _controller.isBonnetLock,
                        press: _controller.updateBonnetDoorLock, 
                      ),
                    ),
                    Positioned(
                      bottom: constrains.maxHeight*0.17,
                      child: DoorLock(
                        isLock: _controller.isTrunkLock,
                        press: _controller.updateTrunkDoorLock, 
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
