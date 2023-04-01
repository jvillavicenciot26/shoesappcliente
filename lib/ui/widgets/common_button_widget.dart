import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';

class CommonButtonWidget extends StatelessWidget {
  String text;
  Color color;
  String? icon;

  CommonButtonWidget({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: icon != null
            ? SvgPicture.asset(
                icon!,
                color: Colors.white,
              )
            : SizedBox(),
        label: H5(
          text: text,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
