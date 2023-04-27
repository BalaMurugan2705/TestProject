import 'package:flutter/material.dart';
import 'package:test_project/custom_widget/text_field_input.dart';
import 'package:test_project/helper/nav_helper.dart';

import '../custom_widget/button.dart';
import '../helper/utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: size.height * 0.1),
                          child: const Center(
                            child: Text(
                              'Login Screen',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFieldButton(
                                    controller: email,
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return "Please Enter Email";
                                      } else if (isEmailValid(val)) {
                                        return "Please Enter Valid Email";
                                      }
                                    },
                                    onChange: (val) {},
                                    inputType: TextInputType.emailAddress,
                                    labelText: "Email",
                                    fontweight: FontWeight.w400,
                                    floating: FloatingLabelBehavior.auto,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldButton(
                                      controller: password,
                                      validate: (val) {
                                        if (val!.isEmpty) {
                                          return "Please Enter password";
                                        }
                                      },
                                      onChange: (val) {},
                                      inputType: TextInputType.emailAddress,
                                      labelText: "Password",
                                      fontweight: FontWeight.w400,
                                      floating: FloatingLabelBehavior.auto,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  customButton(buttonTitle: "Login",onTap: (){
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      openScreen(homeScreenAdmin);
                    }
                  }),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
