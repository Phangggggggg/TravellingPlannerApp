import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/screens/Authentication/login.dart';

class SplashScreen extends StatelessWidget {
  final String assetName = 'lib/assets/logos/favspot.svg';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 2000.0,
        duration: 1500,
        splash:
            // width: 3000,
            // height: 3000,
            SvgPicture.asset(
          assetName,
          height: 3000.0,
          width: 3000.0,
        ),
        //   Container(
        //   // child: Image.asset(widget.newsItem.imgPath.toString()),

        //   // width: 1500,

        //   // height: 1000,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage('lib/assets/logo/logo2.png'),
        //           fit: BoxFit.contain
        //           )),
        // ),
        //   // Image.asset('lib/assets/logo/logo4.png',
        //     height: 2500,
        //     width: 2500
        // ),
        nextScreen: Login(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white);
  }
}
