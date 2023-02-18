import 'package:animated_car/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeslaBottomNavigationBar extends StatelessWidget {
  const TeslaBottomNavigationBar({
    Key? key, 
    required this.selectedTab, 
    required this.onTap,
  }) : super(key: key);

  final int selectedTab;
  final ValueChanged<int> onTap;
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: selectedTab,
        items: List.generate(
          navIconSrc.length,
          (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navIconSrc[index],
              color: index == selectedTab ? primaryColor : Colors.white54,
            ),
            label: ""
          ),
        )
      ),
    );
  }
}

List<String> navIconSrc = [
  'assets/icons/Lock.svg',
  'assets/icons/Charge.svg',
  'assets/icons/Temp.svg',
  'assets/icons/Tyre.svg',
];