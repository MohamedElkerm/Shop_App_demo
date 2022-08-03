import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 10.0,
  @required String text,
  bool isUpper = true,
  Color color = Colors.blue,
  @required function,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: FlatButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  //Validation is not correct
  //required Function validate,
  @required controller,
  @required label,
  @required prefix,
  @required type,
  suffix,
  suffixPressed,
  hint = '',
  onTap,
  onSubmit,
  onChange,
  isPassword = false,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: HexColor('#F18D35'),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        cursorColor: HexColor('#F18D35'),
        //Validation is not correct
        //validator:validate ,
        onFieldSubmitted: onSubmit,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onChanged: onChange,
        onTap: onTap,
        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(color: HexColor('#F18D35')),
          ),
          prefixIcon: Icon(
            prefix,
            color: HexColor('#F18D35'),
          ),
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              color: HexColor('#F18D35'),
            ),
            onPressed: suffixPressed,
          ),
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndReplacement(context, widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defaultTextButton({@required function, @required text}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: HexColor('#F18D35')),
        ));

void showToast({@required state, @required msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

//enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
      break;
    case ToastStates.ERROR:
      return Colors.red;
      break;
    case ToastStates.WARNING:
      return Colors.amber;
      break;
  }
}