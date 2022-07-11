import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/widgets/logo_widget.dart';


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
  late FirebaseAuth _auth;
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
          text: 'Already have an account?  ',
          style: TextStyle(color: kBrown, fontFamily: 'Aeonik'),
        ),
        TextSpan(
            text: 'Sign In',
            style: TextStyle(color: kRed, fontFamily: 'Aeonik'),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed('/login');
              }),
      ])),
    );
  }

  Future signUp() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await newUser.user!.updateDisplayName(usernameController.text.trim());
      // print(newUser);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
        height: 40,
      ),
         LogoWidget(height: 170, width: 170),
      Container(
          margin: EdgeInsets.fromLTRB(0.0, 10, 0, 0),
          child: Text(
            "Sign up",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color: kBrown),
          )),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text('Sign up your account in order to use the app.', style: TextStyle(color: kBrown)),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        filled: true,
                        iconColor: kRed,
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
                      style: TextStyle(fontSize: 15, color: kBrown),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter Your Username';
                        }
                        return null;
                      },
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
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
                      style: TextStyle(fontSize: 15, color: kBrown),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
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

                      style: TextStyle(fontSize: 15, color: kBrown),

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
                        color: kRed,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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

                              _message = "username : $uname\nPassword : $pwd";
                            });
                            signUp();

                            Get.toNamed('/login');
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 15),
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
    ])));
  }
}
