import 'package:flutter/widgets.dart';
import 'package:logiology/custom_widgets/colors.dart';

class Heading extends StatelessWidget {
  final String heading;
  const Heading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return  Text(
      heading,
      style: TextStyle(
        color: CommonColor.blackColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'PoppinsMedium'
      ),
    );
  }
}
