import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../const/color.dart';
class CustomContainer extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final Color textColor;
  final Widget? icon;
  // final BoxDecoration decoration;
  const CustomContainer({
    super.key,
    required this.title,
    required this.onTap,
    this.color = ColorP.whiteColor,
    this.height = 60,
    this.width = 280,
    this.borderRadius= 0.3,
    this.textColor= ColorP.prim,
    this.icon

    // required this.decoration,


  });

  @override
  Widget build(BuildContext context) {

    return  Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(width*0.3),
            border: Border.all(width: 3,color: ColorP.prim),

          ),
          child: ListTile(
            leading: icon,
            title: Text(
              textAlign: TextAlign.center,
              title,style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: width*0.07,
              color: textColor,





            ),
            ),
          ),
        ),
      ),
    );

  }
}
