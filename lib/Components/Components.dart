import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget CustomButton({
  double width = double.infinity,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double radius = 20.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.red[700],
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
    );



Widget CustomTextForm(
    context, {
      required TextEditingController controller,
      required TextInputType keyboardType,
      required String label,
      required Function() onTap,
      Function(String?)? onChange,
      bool isPassword = false,
      String? Function(String?)? validate,
      IconData? preIcon,
      bool AutoFocus = false,
      String? prefixText,

    }) {
  final bool isactive = isPassword;
  isactive? isPassword = isPassword: null;


  return TextFormField(
    controller: controller,
    autofocus: AutoFocus,
    obscureText: isPassword,
    keyboardType: keyboardType,
    validator: validate,
    //onTap: onTap,
    onChanged: onChange,
    decoration: InputDecoration(
      prefixText: prefixText,
      labelText: label,
      prefixIcon: Icon(
        preIcon,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
    ),
  );
}

//changing password visibility
bool isPassword = true;
IconData? suffixIcon = Icons.visibility_off_outlined;
void changePasswordVisibility(){

  isPassword =! isPassword;
  suffixIcon = isPassword ?Icons.visibility_off_outlined:Icons.visibility_outlined;
}

void showToast({
  required String text,
  required ToastStates state,})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);