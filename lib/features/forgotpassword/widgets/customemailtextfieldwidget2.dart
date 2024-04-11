import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../forgotpassword.dart';



class CustomEmailTextFieldWidget2 extends StatelessWidget {
  final bool obscureText;
  final String labelText;
  final TextEditingController tController;
  final String? icon;
  final Widget suffixIcon;
  final ForgotPasswordController controlleer;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  CustomEmailTextFieldWidget2(
      {super.key,
      required this.obscureText,
      required this.labelText,
      required this.tController,
      this.icon,
      this.suffixIcon = const SizedBox(),
      required this.controlleer,
      this.autovalidateMode,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tController,
      cursorColor: Colors.white,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: autovalidateMode,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: const Color(0xff3D3D3D),
        filled: true,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xff858585),
        ),
        errorStyle: TextStyle(
          color: Colors.red.withOpacity(0.8),
        ),
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: SvgPicture.asset(
            icon!,
            height: 4,
            width: 4,
            color: Color(0xff858585),
          ),
        ),
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1.2, color: Colors.red.withOpacity(0.9)),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.2, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}