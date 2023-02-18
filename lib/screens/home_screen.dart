import 'package:animated_car/constants.dart';
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
      builder: (context, snapshot) {
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: constrains.maxHeight*0.10),
                      child: SvgPicture.asset(
                        'assets/icons/Car.svg',
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      right: constrains.maxWidth*0.05,
                      child: GestureDetector(
                        onTap: _controller.updateRightDoorLock,
                        child: AnimatedSwitcher(
                          duration: defaultDuration,
                          switchInCurve: Curves.easeInOutBack,
                          transitionBuilder: (child, animation) => ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                          child: _controller.isRightDoorLocked 
                            ? SvgPicture.asset(
                              'assets/icons/door_lock.svg',
                              //  if we do not add key it will show no animation. bcos both of them are same widget.
                              //  flutter think they are same.
                              key: const ValueKey('lock'),
                            )
                            : SvgPicture.asset(
                              'assets/icons/door_unlock.svg',
                              key: const ValueKey('unlock'),
                            ),
                        ),
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
