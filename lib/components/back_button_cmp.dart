import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackButtonCmp extends StatelessWidget {
  final VoidCallback onTap;
    const BackButtonCmp({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: IconButton(
        icon: const Icon(FontAwesomeIcons.arrowLeft,color: Colors.black,
        size: 25,
        ),
        onPressed: onTap,
      ),
    );
  }
}