import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Widget> tyres(BoxConstraints constrains) {
    return [
      Positioned(
        left: constrains.maxWidth*0.22,
        top: constrains.maxHeight*0.2,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
      ),
      Positioned(
        right: constrains.maxWidth*0.22,
        top: constrains.maxHeight*0.2,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
      ),
      Positioned(
        right: constrains.maxWidth*0.22,
        bottom: constrains.maxHeight*0.2,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
      ),
      Positioned(
        left: constrains.maxWidth*0.22,
        bottom: constrains.maxHeight*0.2,
        child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
      ),
    ];
  }

