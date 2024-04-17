import 'package:flutter/material.dart';

class TextFieldCmp extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final IconData textFieldIcon;
  final FormFieldValidator<String>? validator;


  const TextFieldCmp({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.textFieldIcon,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle:const TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.w300,
              color: Colors.black
              ),
              icon:Icon(textFieldIcon,color: Colors.grey,size: 20,),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
