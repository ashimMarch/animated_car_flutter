import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: SvgPicture.asset('assets/icons/door_lock.svg'),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
