import 'package:flutter/widgets.dart';
import 'package:logiology/utils/color.dart';

class HeadText extends StatelessWidget {
  final String heading;
  final double fontSize;
  const HeadText({super.key, required this.heading, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return  Text(
      heading,
      style: TextStyle(
          color: ColorClass.blackColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'PoppinsMedium'
      ),
    );
  }
}
