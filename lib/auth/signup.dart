// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:spire/auth/change_password.dart';
import 'package:spire/components/button_cmp.dart';
import 'package:spire/components/text_button_cmp.dart';
import 'package:spire/components/textfield_cmp.dart';
import 'package:spire/theme/typography.dart';
import 'package:spire/utils/show_snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

   Future<void> _signUp() async {
    setState(() => _isLoading = true); 
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      createUserDocument(userCredential);

      //clearing
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      context.go('/');

      showSnackbar(context, "Signed up successfully");


    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred.'; // Generic error message
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password you entered is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The email address you entered is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        default:
         errorMessage = 'please try again';
      }
      _showErrorDialog(errorMessage);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential)async{
    if (userCredential != null && userCredential.user != null){
      FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set(
        {
          'userid':userCredential.user!.uid,
          'email':userCredential.user!.email,
          'name':nameController.text,
        }
      );
      
    }

  }
  
  // Future<void> _storeCredentials(String uid) async {

  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('uid', uid);
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Up Error'),
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    // Password must be at least 6 characters long
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  void dispose(){
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Welcome Text
                    const Text("Welcome ", style: largeHeadingStyle),
                    const SizedBox(height: 30),
                    // Logo
                    Icon(FontAwesomeIcons.userGroup, size: 100, color: Colors.grey.shade700),
                    const SizedBox(height: 50),
                    TextFieldCmp(
                      controller: nameController,
                      labelText: "Name",
                      textFieldIcon: Icons.person,
                      validator: validateName,
                    ),
                    const SizedBox(height: 20),
                    TextFieldCmp(
                      controller: emailController,
                      labelText: "Email",
                      textFieldIcon: Icons.email,
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 20),
                    // Password
                    TextFieldCmp(
                      controller: passwordController,
                      labelText: "Password",
                      textFieldIcon: FontAwesomeIcons.key,
                      obscureText: true,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 20),
                    // Signup button
                    ButtonCmp(
                      buttonText: "Sign Up",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                        _signUp();    
                      }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButtonCmp(
                          onTap: () {
                            context.go('/signin');
                          },
                          textColor: Colors.grey.shade800,
                          title: "Sign In",
                        ),
                        TextButtonCmp(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChangePassword()),
                            );
                          },
                          textColor: Colors.grey.shade800,
                          title: "Forgot Password ?",
                        ),
                      ],
                    ),
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


