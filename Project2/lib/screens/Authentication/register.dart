import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController dateCtl = TextEditingController();
    TextEditingController city = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    final format = DateFormat('yyyy-MM-dd');
    
    String _userName = '';
    String _passWord = '';
    String _email = '';
    String _message = '';

    bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  Widget _buildRegisterWith() {
    return Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Already have an account?  ',
           style: TextStyle(color: Colors.black),
        ),
        TextSpan(
            text: 'Sign In',
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed('/login');
              }),
      ])),
    );
  }


    Widget build(BuildContext context) {
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    children: [
                        SizedBox(
                         height: 50,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 10, 0, 0),
                            child: Text(
                            "Sign up",
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
                        )
                        ),
                        Padding(
                        padding: const EdgeInsets.all(0.0),
                            child: Text('Sign up your account in order to use the app.'),
                        ),
                        Container(
                margin: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                filled: true,
                                iconColor: Colors.blue,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Username",
                                hintText: 'Enter your Username',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              style: TextStyle(fontSize: 15),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter Your Username';
                                }
                                return null;
                              },
                            ),
                          ),
                          Row(children: [
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: TextFormField(
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  filled: true,
                                  iconColor: Colors.blue,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: "Full Name",
                                  hintText: 'Enter your Full Name',
                                  prefixIcon: Icon(Icons.account_box_outlined),
                                ),
                                style: TextStyle(fontSize: 15),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter Your Full Name';
                                  }
                                  return null;
                                },
                              ),
                            )),
                            Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: DateTimeField(
                                      controller: dateCtl,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        filled: true,
                                        iconColor: Colors.blue,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        labelText: "Birthdy",
                                        hintText: 'Your Date of Birth',
                                        prefixIcon:
                                            Icon(Icons.calendar_month_outlined),
                                      ),
                                      style: TextStyle(fontSize: 15),
                                      format: format,
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = showDatePicker(
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary:
                                                      Colors.blue, // header background color
                                                  onPrimary:
                                                      Colors.white, // header text color
                                                  onSurface:
                                                      Colors.black, // body text color
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.black, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          context: context,
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );

                                        return date;
                                      })),
                            ),
                          ]),
                        //   Row(
                        //     children: <Widget>[
                        //       Flexible(
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(7.0),
                        //           child: TextFormField(
                        //             controller: phoneNoController,
                        //             decoration: InputDecoration(
                        //               contentPadding:
                        //                   EdgeInsets.symmetric(vertical: 15.0),
                        //               filled: true,
                        //               iconColor: kDarkBlue,
                        //               fillColor: kWhite,
                        //               focusedBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                       color: kWhite, width: 2.0),
                        //                   borderRadius:
                        //                       BorderRadius.circular(15.0)),
                        //               enabledBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                       color: kWhite, width: 2.0),
                        //                   borderRadius:
                        //                       BorderRadius.circular(15.0)),
                        //               labelText: "Phone Number",
                        //               hintText: 'Enter your Phone Number',
                        //               prefixIcon:
                        //                   Icon(Icons.add_ic_call_outlined),
                        //             ),
                        //             style: TextStyle(fontSize: 15),
                        //             validator: (text) {
                        //               if (text == null || text.isEmpty) {
                        //                 return 'Enter your Phone Number';
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //       Flexible(
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(7.0),
                        //           child: TextFormField(
                        //             controller: city,
                        //             decoration: InputDecoration(
                        //               contentPadding:
                        //                   EdgeInsets.symmetric(vertical: 15.0),
                        //               filled: true,
                        //               iconColor: kDarkBlue,
                        //               fillColor: kWhite,
                        //               focusedBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                       color: kWhite, width: 2.0),
                        //                   borderRadius:
                        //                       BorderRadius.circular(15.0)),
                        //               enabledBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                       color: kWhite, width: 2.0),
                        //                   borderRadius:
                        //                       BorderRadius.circular(15.0)),
                        //               labelText: "Your City",
                        //               hintText: 'Enter your City',
                        //               prefixIcon:
                        //                   Icon(Icons.add_location_alt_outlined),
                        //             ),
                        //             style: TextStyle(fontSize: 15),
                        //             validator: (text) {
                        //               if (text == null || text.isEmpty) {
                        //                 return 'Enter your City';
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                filled: true,
                                iconColor: Colors.blue,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Email",
                                hintText: 'Enter your Email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              style: TextStyle(fontSize: 15),
                              validator: (input) =>
                                  isEmail(input!) ? null : "Check your email",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: TextFormField(
                              // keyboardType: TextInputType.emailAddress,
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0),
                                filled: true,
                                iconColor: Colors.blue,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Password",
                                hintText: 'Enter your Password',
                                prefixIcon: Icon(Icons.key),
                              ),

                              style: TextStyle(fontSize: 15),

                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter Your Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Center(
                              child: MaterialButton(
                                minWidth: 300.0,
                                height: 50.0,
                                color: Colors.blue,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var uname = usernameController.text;
                                    var pwd = passwordController.text;

                                    var email = emailController.text;

                                    setState(() {
                                      _userName = uname;
                                      _passWord = pwd;

                                      _email = email;

                                      _message =
                                          "username : $uname\nPassword : $pwd";
                                    //   user
                                    //       .createUser(
                                    //           _email, _userName, _passWord)
                                    //       .then((value) {
                                    //     if (value) {
                                    //       Get.toNamed('/login');
                                    //     } else {
                                    //       setState(() {
                                    //         resetTextField();
                                    //       });
                                    //       print(
                                    //           "this username is already exist.");
                                    //       showDialog(
                                    //         context: context,
                                    //         builder: (context) => AlertDialog(
                                    //           title: Text(
                                    //               "Fail Username Already Exists"),
                                    //           content: Text(
                                    //               'Fail! Can\'t create new user account. Username already exists'),
                                    //           actions: [
                                    //             TextButton(
                                    //                 onPressed: () =>
                                    //                     Navigator.pop(context),
                                    //                 child: Text('OK'))
                                    //           ],
                                    //         ),
                                    //       );
                                        // }
                                      }
                                    );
                                    
                                    Get.toNamed('/login');
                                    }
                                },
                             
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: _buildRegisterWith(),
                          ),
                        ],
                      )),
                ),
              ),


                    ]
                )
            )


        );
    
    }

}