import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelling_app/colors/colors.dart';

class AboutYouWidget extends StatelessWidget {
  String title;
  String actualUser;
  IconData icon;
  Color iconColor;

  AboutYouWidget(
      {required this.title, required this.actualUser, required this.icon,required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: kWheat,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 30,
                color: iconColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0.0, 3),
                  child: Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10),
                  child: Text(actualUser,
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}