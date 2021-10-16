import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_amit/Components/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project_amit/Components/Components.dart';
import 'package:graduation_project_amit/Layout/AppLayout.dart';
import 'package:graduation_project_amit/MainScreens/Login/Regestration/SignUpPage.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

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
                  key: formKey,
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
                      CustomTextForm(context,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email address',
                        onTap: (){},
                        preIcon: Icons.email_outlined,
                        validate: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            else if (!value.contains('@')) {
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

                      else /*if (value.toString().length!=8) {
                        return 'your password must be at least 8 characters';
                      }*/
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
                        icon: Icon(Icons.visibility_outlined,),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      ),
                    ),
                  ),
                ),

                      SizedBox(
                        height: 30.0,
                      ),

                       CustomButton(
                          function: () {
                          if (formKey.currentState!.validate()) {
                             userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }

                            //just for testing
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (BuildContext context) =>  AppLayout()));
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),

                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(onPressed: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) => SignUpPage(),
                              ),
                            );
                          }, child: Text('SignUp')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                )
              ],
            )
            ),
            ),
          ),
        );

  }
   userLogin({required String email, required String password,}) async
  {
    //sending data to login api
    final response = await http.post(
      Uri.parse('https://retail.amit-learning.com/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{

        'email': email,
        'password': password,

      }),
    );
    if (response.statusCode == 200) {

      print('Congratulations,you have signed in successfully');
      Navigator.push(context, MaterialPageRoute(
               builder: (BuildContext context) =>  AppLayout()));
     // print(jsonDecode(response.body)['token']);
      token=jsonDecode(response.body)['token'];
      showToast(text:'Logged in Successfully' , state: ToastStates.SUCCESS);


    }
    else {
      showToast(text:jsonDecode(response.body)['error'] , state: ToastStates.ERROR);
      throw Exception('Failed to login');





    }
  }

}
