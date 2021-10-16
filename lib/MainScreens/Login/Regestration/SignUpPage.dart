import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_amit/Components/Components.dart';
import 'package:graduation_project_amit/Components/Constants.dart';
import 'package:graduation_project_amit/Layout/AppLayout.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var signUpKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: signUpKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/logo.png'),
                              height: 125.0,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            CustomTextForm(
                              context,
                              controller: nameController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Name',
                              onTap: () {},
                              preIcon: Icons.drive_file_rename_outline,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'The name field is required';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            CustomTextForm(
                              context,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email address',
                              onTap: () {},
                              preIcon: Icons.email_outlined,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {

                                  return 'Please enter some text';


                                } else if (!value.contains('@')) {
                                  return 'your email address must contain @ sign ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            //password form field

                      SizedBox(
                        height: 60,
                        width: 500,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }

                            else
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPassword,

                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Type your password',
                            prefixIcon: Icon(Icons.lock),
                            suffix: isPassword ? IconButton(
                              onPressed: () {
                                setState(() {
                                  changePasswordVisibility();
                                });

                              }, icon: Icon(suffixIcon),)
                                : IconButton(
                              onPressed: () {
                                setState(() {
                                  changePasswordVisibility();
                                });
                              },
                              icon: Icon(Icons.visibility_outlined),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0)
                            )
                          )),
                      ),
                            SizedBox(
                              height: 30.0,
                            ),
                            CustomButton(
                              function: () {
                                if (signUpKey.currentState!.validate()) {

                                  userSignUp(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'SignUp',
                              isUpperCase: true,
                            ),

                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account!'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Login')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void userSignUp(
      {required String email,
      required String password,
      required String name}) async {
    //sending data to register api
    final response = await http.post(
      Uri.parse('https://retail.amit-learning.com/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
     // print('Congratulations,you have registered successfully');

      token = jsonDecode(response.body)["token"];
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) =>  AppLayout()));
      showToast(text:'Congratulations, you have signed up Successfully' , state: ToastStates.SUCCESS);
      // print(token);

    } else {
      showToast(text:jsonDecode(response.body)['message'] , state: ToastStates.ERROR);
      throw Exception('Failed to send data');
    }
  }
}
