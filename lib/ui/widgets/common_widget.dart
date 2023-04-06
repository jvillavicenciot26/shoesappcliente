import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/utils/responsive.dart';

SizedBox spacing2 = const SizedBox(height: 2);
SizedBox spacing4 = const SizedBox(height: 4);
SizedBox spacing8 = const SizedBox(height: 8);
SizedBox spacing12 = const SizedBox(height: 12);
SizedBox spacing16 = const SizedBox(height: 16);
SizedBox spacing20 = const SizedBox(height: 20);
SizedBox spacing30 = const SizedBox(height: 30);
SizedBox spacing40 = const SizedBox(height: 40);

SizedBox spacing2Width = const SizedBox(width: 2);
SizedBox spacing4Width = const SizedBox(width: 4);
SizedBox spacing8Width = const SizedBox(width: 8);
SizedBox spacing12Width = const SizedBox(width: 12);
SizedBox spacing14Width = const SizedBox(width: 14);
SizedBox spacing16Width = const SizedBox(width: 16);

Center loadingWidget = const Center(
  child: SizedBox(
    height: 20,
    width: 20,
    child: CupertinoActivityIndicator(
      radius: 8,
      color: BrandColor.primaryColor,
    ),
  ),
);

Stack backgroundWidget(BuildContext context) => Stack(
      children: [
        Positioned(
          top: -ResponsiveUI.pDiagonal(context, 0.15),
          left: -ResponsiveUI.pDiagonal(context, 0.05),
          child: Stack(
            children: [
              Transform.rotate(
                angle: pi / 3.5,
                child: Container(
                  height: ResponsiveUI.pDiagonal(context, 0.4),
                  width: ResponsiveUI.pDiagonal(context, 0.4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(90.0),
                    gradient: LinearGradient(
                      colors: [
                        BrandColor.secondaryFontColor,
                        BrandColor.primaryColor,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: BrandColor.primaryColor.withOpacity(0.05),
                        blurRadius: 12.0,
                        offset: Offset(6, 6),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

SnackBar snackBarError(String message) => SnackBar(
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Row(
        children: [
          Expanded(
            child: H5(
              text: message,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
