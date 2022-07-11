import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  static const String logoPath = "lib/assets/logos/favnobg.png";
  double height;
  double width;
  LogoWidget({required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoPath,
      height: height,
      width: width,
    );
  }
}
