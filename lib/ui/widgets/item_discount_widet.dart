import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';

class ItemDiscountWidget extends StatelessWidget {
  int discount;

  ItemDiscountWidget({required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: BrandColor.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: H5(
        text: "-$discount%",
        color: BrandColor.secondaryFontColor,
      ),
    );
  }
}
