import 'package:flutter/material.dart';
import 'package:spire/theme/typography.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String cuisine;
  final String location;
  final String image;

  const DetailsScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.location,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name,style: titleStyle,),
        centerTitle: true,
        toolbarHeight: 80,
        leading: const BackButton(style: ButtonStyle(iconSize: MaterialStatePropertyAll(30)),),
        leadingWidth: 80,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(image)
              ),
              const SizedBox(height: 30,),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                  name,
                  style: titleStyle,
                ),
                const Divider(thickness: 2,),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: subTitleStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  cuisine,
                  style: subTitleStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  location,
                  style: subTitleStyle,
                ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
