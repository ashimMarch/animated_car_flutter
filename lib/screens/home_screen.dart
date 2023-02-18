import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(// we need to know how much width and height available for this car after taken AppBar and NavBar space
          builder: (context, constrains) {
            print('constrains.maxHeight : ${constrains.maxHeight} ');
            print('constrains.minHeight : ${constrains.minHeight}');
            print('constrains.maxWidth : ${constrains.maxWidth}');
            print('constrains.minWidth : ${constrains.minWidth}');
            print('\n ${constrains.maxHeight*0.1}\n');
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: constrains.maxHeight*0.1),
                  child: SvgPicture.asset(
                    'assets/icons/Car.svg',
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
