import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text('Первый экран')),
        body: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SecondScreen();
              }));
            },
            child: Hero(tag: 'flutterLogo', child: FlutterLogo(size: 100.h)),
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второй экран')),
      body: Center(
        child: Hero(tag: 'flutterLogo', child: FlutterLogo(size: 100.h)),
      ),
    );
  }
}
