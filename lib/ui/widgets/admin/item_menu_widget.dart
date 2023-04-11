import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';

class ItemMenuWidget extends StatelessWidget {
  String text;
  String icon;
  VoidCallback onTap;

  ItemMenuWidget({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.0),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 12.0,
              color: Colors.indigo,
              offset: Offset(4, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12.0,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Image.asset(
                icon,
                height: 36,
              ),
            ),
            spacing4,
            H5(
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}
