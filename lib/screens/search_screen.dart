import 'package:flutter/material.dart';
import 'package:spire/components/search_bar_cmp.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarCmp(),
      )
    );
  }
}