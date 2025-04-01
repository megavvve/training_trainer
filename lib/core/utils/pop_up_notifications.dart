import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void inputFieldsNotFilledIn(BuildContext context){
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      "Поля ввода не заполнены",
      style: TextStyle(
        fontSize: 16.0.sp,
        color: Colors.white,
      ),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating, 
    
   
  ),
);
}


void showErrorSnackBar(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.hideCurrentSnackBar(); 
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0.sp,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    )
  );
}