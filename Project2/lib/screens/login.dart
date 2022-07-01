import 'package:flutter/material.dart';

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

  final _formKey = GlobalKey<FormState>();

  void resetTextField() {
    usernameController.clear();
    passwordController.clear();
    _message = "";
  }

  Widget _buildRegisterWith() {
    return Center(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Don\'t have an account?  ',
          ),
          TextSpan(
            text: 'Sign Up',
            // recognizer: TapGestureRecognizer()
            //   ..onTap = () {
            //     Get.toNamed('/register');
            //   }),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
