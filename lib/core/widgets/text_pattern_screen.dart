import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextPatternScreen extends StatelessWidget {
  const TextPatternScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const baseText = "TRAININGTRAINER";
    final lines = _generatePattern(baseText);

     return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < lines.length; i++)
                _buildTextLine(lines[i], i),
            ],
          ),
        );
    

  }

  List<String> _generatePattern(String text) {
    final pattern = <String>[];
    for (int i = 0; i < text.length; i++) {
      final shifted = text.substring(i) + text.substring(0, i);
      pattern.add(shifted);
    }
    return pattern;
  }

  Widget _buildTextLine(String text, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        text,
        style: TextStyle(
         height: 2.5.h,
          fontSize: 16.sp,
          color: Colors.blue,
          fontFamily: 'RobotoMono',
          fontWeight: FontWeight.w500,
          letterSpacing: 15.sp,
        ),
      ),
    );
  }

  // Color _getColorForIndex(int index) {
  //   final colors = [
  //     Colors.red,
  //     Colors.orange,
  //     Colors.yellow,
  //     Colors.green,
  //     Colors.blue,
  //     Colors.indigo,
  //     Colors.purple,
  //   ];
  //   return colors[index % colors.length];
  // }
}