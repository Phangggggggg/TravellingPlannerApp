import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:travelling_app/api/get_covid.dart';
import 'package:travelling_app/api/get_restaurant.dart';
import 'package:travelling_app/api/get_attraction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _userName = '';
  String _passWord = '';
  String _message = '';
  String _errText = '';
  bool _autoValidate = false;
  late FirebaseAuth _auth;

  final _formKey = GlobalKey<FormState>();

  void resetTextField() {
    usernameController.clear();
    passwordController.clear();
    _message = "";
  }

  void iniFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  @override
  void initState() {
    super.initState();
    iniFirebase();
  }

  Widget _buildRegisterWith() {
    return Center(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an account?  ',
              style: TextStyle(color: Colors.black)),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed('/register');
                }),
        ]),
      ),
    );
  }

  Future signIn() async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: usernameController.text.trim(), // need gto use email

          password: passwordController.text.trim());
      // print(newUser.user!.displayName);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Widget _buildLoginText() {
    return Column(
      children: [
        Text(
          "Welcome!",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text("To continue using this app,"),
        Text("please sign in first.")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Column(children: [
        Container(margin: const EdgeInsets.all(20), child: _buildLoginText()),
        Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    filled: true,

                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0)),
                    labelText: "Username",
                    // errorText: _errText,
                    hintText: 'Enter your Username',
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                  ),
                  validator: (text) {
                    print(text);
                    if (text == null || text.isEmpty) {
                      return 'Enter Your Username';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    iconColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0)),
                    labelText: "Password",
                    hintText: 'Enter your Password',
                    prefixIcon: Icon(Icons.key),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter Your Password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: MaterialButton(
                  minWidth: 300.0,
                  height: 50.0,
                  color: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // validate
                    //   var uname = usernameController.text;
                    //   var pwd = passwordController.text;
                    //   setState(() {
                    //     _userName = uname;
                    //     _passWord = pwd;
                    //     _message = "username : $uname\nPassword : $pwd";
                    //   });
                    // GetPlace g = GetPlace();
                    // g.getAPlace('อาหาร', '13.6904831,100.5226014');
                    // GetResturant resturant = GetResturant();
                    // resturant.getAResDetail('P08000001');

                    // GetAtrraction atrrac = GetAtrraction();

                    // atrrac.getAtrract('P03000001');
                    // GetCovid covid = GetCovid();
                    // covid.getCovidDialy();
                    signIn();
                    Get.toNamed('/home');

                    // user
                    //     .authUser(_userName, _passWord)
                    //     .then((value) {
                    //   if (value) {

                    //     print(UserSharedPreference.getUser()
                    //         .toString());
                    //     Get.toNamed('/home');
                    //   } else {
                    //     setState(() {
                    //       _autoValidate = true;
                    //       resetTextField();
                    //     });
                    //     print("fail authentication");
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => AlertDialog(
                    //         title: Text("Fail Authentication"),
                    //         content: Text(
                    //             'Fail! Please Register your account first before Login'),
                    //         actions: [
                    //           TextButton(
                    //               onPressed: () =>
                    //                   Navigator.pop(context),
                    //               child: Text('OK'))
                    //         ],
                    //       ),
                    //     );
                    //   }
                    // });
                    // }
                    // setState(() {
                    //   _autoValidate = true;
                    // });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: _buildRegisterWith(),
              )
            ]),
          ),
        ),
      ])),
    ));
  }
}
