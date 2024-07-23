// ignore_for_file: prefer_const_constructors

import 'package:fake_store/authentication/data/models/user_model.dart';
import 'package:fake_store/authentication/data/repositeries/auth_repositery.dart';
import 'package:fake_store/authentication/presentation/screens/login_screen.dart';
import 'package:fake_store/authentication/presentation/widgets/btn_widget.dart';
import 'package:fake_store/authentication/presentation/widgets/text_form_widget.dart';
import 'package:fake_store/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool matchPass = true;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List gender = ["Male", "Female", "Other"];
  late String selectedGender = gender[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            // textAlign: TextAlign.center,
            'Signup',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormWidget(
                  prefix: Icon(Icons.person),
                  textHint: 'User Name',
                  controller: namecontroller,
                ),
                TextFormWidget(
                  prefix: Icon(Icons.email),
                  controller: emailcontroller,
                  textHint: 'Email',
                  validate: (p0) {
                    if (p0!.contains('@')) {
                      return null;
                    } else {
                      return ("this feild must contain @");
                    }
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: IntlPhoneField(
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'EG',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
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
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text(
                            '${gender[0]}'), // Display the title for option 1
                        value: gender[0], // Assign a value of 1 to this option
                        groupValue:
                            selectedGender, // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          setState(() {
                            selectedGender =
                                value!; // Update _selectedValue when option 1 is selected
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text(
                            '${gender[1]}'), // Display the title for option 1
                        value: gender[1], // Assign a value of 1 to this option
                        groupValue:
                            selectedGender, // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          setState(() {
                            selectedGender =
                                value!; // Update _selectedValue when option 1 is selected
                          });
                        },
                      ),
                    ),
                  ],
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
                            email: emailcontroller.text,
                            phone: phonecontroller.text,
                          );
                          if (AuthRepositery.checkData(user)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content:
                                    Text('Email or UserName alraedy exist')));
                          } else {
                            AuthRepositery.savUserData(user);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return ProductScreen(userData: user);
                              },
                            ));
                          }
                        }
                      });
                    },
                    btnText: "SignUp"),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                    },
                    child: Text('Already have account ?')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
