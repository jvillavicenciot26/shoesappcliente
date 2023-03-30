import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';

class ItemSizeWidget extends StatelessWidget {
  double size;
  ItemSizeWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 54,
      decoration: BoxDecoration(
        //color: Colors.amber,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 0.95,
          color: BrandColor.primaryFontColor.withOpacity(0.30),
        ),
      ),
      alignment: Alignment.center,
      child: H5(
        text: size.toString(),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
