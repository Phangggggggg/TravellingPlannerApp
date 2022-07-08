import 'package:flutter/material.dart';
import 'package:travelling_app/colors/colors.dart';
import '../../utils/user_shared_preferences.dart';
import '../../widgets/about_you_widget.dart';


class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final List<String> userInfos = UserSharedPreference.getUser();
  //[userId, username, email,fullname,birthday,phone,city]; 
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AboutYouWidget(title: 'Username', icon: Icons.person_rounded, actualUser: userInfos[1],iconColor: kRed,),
      AboutYouWidget(title: 'Email', icon: Icons.email_rounded, actualUser: userInfos[2],iconColor: kRed,),
      // AboutYouWidget(title: 'Full Name', icon: Icons.account_box, actualUser: userInfos[3],iconColor: kDarkBlue,),
      // AboutYouWidget(title: 'Birthday', icon: Icons.calendar_month, actualUser: userInfos[4],iconColor: kLightBlue),
      // AboutYouWidget(title: 'Phone', icon: Icons.add_ic_call, actualUser: userInfos[5],iconColor: kDarkBlue),
      // AboutYouWidget(title: 'Location',icon: Icons.add_location_alt, actualUser: userInfos[6],iconColor: kLightBlue),
    ]);
  }
}