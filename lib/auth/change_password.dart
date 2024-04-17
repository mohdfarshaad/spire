import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spire/components/back_button_cmp.dart';
import 'package:spire/components/button_cmp.dart';
import 'package:spire/components/textfield_cmp.dart';
import 'package:spire/theme/typography.dart';

class ChangePassword extends StatefulWidget {

   const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController emailController =  TextEditingController();
   final _formKey = GlobalKey<FormState>(); 

    String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // Email validation regex
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonCmp(onTap:(){Navigator.pop(context);},),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60,bottom: 20,left: 20,right: 20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Welcome Text
                    const Text("Change Password",style: largeHeadingStyle,),
                    const SizedBox(height: 30,),
                
                    //logo
                    Icon(FontAwesomeIcons.key,size: 100,color: Colors.grey.shade700,),
                        
                    const SizedBox(height: 50,),
                
                    TextFieldCmp(controller: 
                    emailController, labelText:"Email", textFieldIcon:Icons.email, validator: validateEmail,),
                  
                    const SizedBox(height: 20),
                
                    //signin button
                    ButtonCmp(buttonText: "Verify", onTap: (){
                        if (_formKey.currentState!.validate()) {
                         
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}