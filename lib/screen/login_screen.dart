import 'package:flutter/material.dart';
import 'package:test_project/bloc/user_cubit.dart';
import 'package:test_project/custom_widget/text_field_input.dart';
import 'package:test_project/helper/firebaseHelper.dart';
import 'package:test_project/helper/nav_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/model/userData_model.dart';
import '../custom_widget/button.dart';
import '../helper/utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  //globalKey
  final _formKey = GlobalKey<FormState>();

  //TextEditing Controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<UserCubit>().getToken();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Stack(alignment: Alignment.center,
                children: [
                  Column(
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
                      customButton(buttonTitle: "Login",onTap: ()async{
                        if (_formKey.currentState!.validate()) {
                         var data = await context.read<UserCubit>().login(email.text,password.text,context);
                          if(data !=null){
                                if (data.isAdmin == true) {
                                  openScreen(homeScreenAdmin);
                                } else {
                                  openScreen(homeScreenUser);
                                }
                              }
                            }
                      }),

                    ],
                  ),
                  BlocBuilder<UserCubit,UserDataState>(
                      builder: (context,state) {
                        return Visibility(
                          visible: state.reqState ==ReqState.LOADING,
                          child: CircularProgressIndicator(),
                        );
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
