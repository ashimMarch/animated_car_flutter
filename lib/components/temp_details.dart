
import 'package:animated_car/components/temp_btn.dart';
import 'package:animated_car/constants.dart';
import 'package:animated_car/home_controller.dart';
import 'package:flutter/material.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  }) : _controller = controller, super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'COOL',
                  press: _controller.updatedCoolSelected,
                ),
                const SizedBox(width: defaultPadding,),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  svgSrc: 'assets/icons/heatShape.svg',
                  activeColor: Colors.red,
                  title: 'HEAT',
                  press: _controller.updatedCoolSelected,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {}, 
                icon: const Icon(Icons.arrow_drop_up,size: 48,)
              ),              
              const Text(
                '29'+'\u2103',
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {}, 
                icon: const Icon(Icons.arrow_drop_down,size: 48,)
              ),
            ],
          ),
          const Spacer(),
          const Text('CURRENT TEMPERATURE'),
          const SizedBox(height: defaultPadding,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('INSIDE'),
                  Text(
                    '20'+'\u2103',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(width: defaultPadding,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('OUTSIDE',style: TextStyle(color: Colors.white54),),
                  Text(
                    '35'+'\u2103',
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
