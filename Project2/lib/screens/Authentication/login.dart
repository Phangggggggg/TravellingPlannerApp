import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelling_app/utils/user_shared_preferences.dart';
import 'package:travelling_app/colors/colors.dart';
import 'package:travelling_app/widgets/logo_widget.dart';

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
              style: TextStyle(color: kBrown, fontFamily: 'Aeonik')),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(color: kRed, fontFamily: 'Aeonik'),
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
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;
        String displayName = currentUser.displayName!;
        String email = currentUser.email!;
        await UserSharedPreference.setUser(uid, displayName, email);
        print(UserSharedPreference.getUser());
      }else{
        throw Exception('Cant log in');
      }
    
      // print(newUser.user!.displayName);
    } on FirebaseAuthException catch (e) {
      print(e);
      rethrow;
    }
  }

  Widget _buildLoginText() {
    return Column(
      children: [

      SizedBox(
        height: 50,
      ),
        Text(
          "Welcome!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: kBrown),
        ),
        SizedBox(
          height: 10,
        ),
        Text("To continue using this app,", style: TextStyle(color: kBrown,fontSize: 14,),),
        Text("please sign in first.", style: TextStyle(color: kBrown,fontSize: 14)),
         SizedBox(
          height: 10,
        ),
        LogoWidget(height: 180, width: 180),
      ],
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Column(children: [
        _buildLoginText(),
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
                    hintText: 'Enter your Email',
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter Your Email';
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
                  color: kRed,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  onPressed: () async{
                    await signIn();
                    Get.toNamed('/home');
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
