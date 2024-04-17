
// ignore_for_file: avoid_print, unused_field, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spire/auth/change_password.dart';
import 'package:spire/components/button_cmp.dart';
import 'package:spire/components/text_button_cmp.dart';
import 'package:spire/components/textfield_cmp.dart';
import 'package:spire/theme/typography.dart';
import 'package:spire/utils/show_snackbar.dart';

class SignIn extends StatefulWidget {

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController =  TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>(); 
   
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true); // Show loading indicator
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Securely store credentials (if necessary)
      await _storeCredentials(userCredential.user!.uid);

     //Navigate to HomeScreen 
     context.go('/');

     //show success messege
     showSnackbar(context, "Signed in successfully");


    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign in Failed. check your Email and Password'; // Generic error message
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'The email address you entered is not registered.';
          break;
        case 'wrong-password':
          errorMessage = 'The password you entered is incorrect.';
          break;
        default:
          // Handle other potential error codes
      }
      _showErrorDialog(errorMessage);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _storeCredentials(String uid) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign In Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

   String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Email Address';
    }
    // Email validation regex
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a Valid Email Address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Password';
    }
    // Password must be at least 6 characters long
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60,bottom: 20,left: 20,right: 20),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Welcome Text
                    const Text("Welcome Back",style: largeHeadingStyle,),
                    const SizedBox(height: 30,),
                
                    //logo
                    Icon(FontAwesomeIcons.userLock,size: 100,color: Colors.grey.shade700,),
                        
                    const SizedBox(height: 50,),
                
                    TextFieldCmp(controller: 
                    emailController, labelText:"Email", textFieldIcon:Icons.email,validator: validateEmail, ),
                    
                    const SizedBox(height: 20,),
                    
                    //Password
                    TextFieldCmp(controller: 
                    passwordController, labelText:"Password", textFieldIcon:FontAwesomeIcons.key,validator: validatePassword,
                    obscureText: true,
                     ),
                        
                    const SizedBox(height: 20,),
                        
                    //signin button
                    ButtonCmp(buttonText: "Sign in", onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _signIn();
                    }}),   
                     const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButtonCmp(onTap: (){
                          context.go('/signup');
                        }, textColor: Colors.grey.shade800, title:"Sign Up"),
                         TextButtonCmp(onTap: (){
                          Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const ChangePassword()),
                       );
                         }, textColor: Colors.grey.shade800, title:"Forgot Password ?")
                      ],
                    )    
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