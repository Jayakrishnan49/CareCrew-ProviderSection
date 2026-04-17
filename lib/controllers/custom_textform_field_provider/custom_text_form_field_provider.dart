import 'package:flutter/widgets.dart';

class CustomTextFormFieldProvider extends ChangeNotifier {
  bool isObscureText=true;

  togglePasswordVisibility(){
    isObscureText=!isObscureText;
    notifyListeners();
  }
}