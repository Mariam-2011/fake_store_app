// ignore_for_file: prefer_const_constructors

import 'package:fake_store/authentication/data/models/user_model.dart';
import 'package:fake_store/authentication/data/repositeries/auth_repositery.dart';
import 'package:fake_store/authentication/presentation/screens/signup_screen.dart';
import 'package:fake_store/authentication/presentation/widgets/btn_widget.dart';
import 'package:fake_store/authentication/presentation/widgets/text_form_widget.dart';
import 'package:fake_store/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool matchPass = true;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            // textAlign: TextAlign.center,
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9tu0c_cjxMIIll3_E23_TRiAGPLXAW5WJFg&s'),
              ),
              TextFormWidget(
                prefix: Icon(Icons.person),
                textHint: 'User Name',
                controller: namecontroller,
              ),
              TextFormWidget(
                prefix: Icon(Icons.lock),
                controller: passwordcontroller,
                textHint: 'Password',
                isPass: true,
                validate: (p0) {
                  if ((p0!).length >= 6 && matchPass == true) {
                    return null;
                  } else {
                    return ("Wrong password");
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              BtnWidget(
                  fun: () {
                    setState(() {
                      // _formKey.currentState!.validate();
                      if (_formKey.currentState!.validate()) {
                        var user = UserModel(
                          username: namecontroller.text,
                          email: namecontroller.text,
                          phone: phonecontroller.text,
                        );
                        if (AuthRepositery.checkData(user)) {
                          var realUser = AuthRepositery.getUserData();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductScreen(userData: realUser!);
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text("Email or UserName doesn't exist")));
                        }
                      }
                    });
                  },
                  btnText: "Login"),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SignupScreen();
                      },
                    ));
                  },
                  child: Text("Don't have account ?")),
            ],
          ),
        ),
      ),
    );
  }
}
