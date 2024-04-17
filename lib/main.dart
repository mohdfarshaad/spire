import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spire/auth/change_password.dart';
import 'package:spire/auth/signin.dart';
import 'package:spire/auth/signup.dart';
import 'package:spire/firebase_options.dart';
import 'package:spire/screens/add_resturant_screen.dart';
import 'package:spire/screens/first_screen.dart';
import 'package:spire/screens/profile_screen.dart';
import 'package:spire/screens/search_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  final _router = GoRouter(
    initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FirstScreen(),
    ),
    GoRoute(
      path: '/addresturants',
      builder: (context, state) =>  const AddRestaurantScreen(),
    ),
     GoRoute(
      path: '/search',
      builder: (context, state) =>  const SearchScreen(),
    ),
    GoRoute(
      path: '/profilwscreen',
      builder: (context, state) =>  const ProfileScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) =>   const SignUp(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) =>   const SignIn(),
    ),
    GoRoute(
      path: '/changepassword',
      builder: (context, state) =>   const ChangePassword(),
    ),
    
  ],
);
   MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}


